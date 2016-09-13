#Include 'Protheus.ch'

User Function HUBXJOB(dDateProc)
Local cQuery  := ""
Local cQuery1  := ""
Local _cAlias := GetNextAlias()
Local _cAlias1 := GetNextAlias()

DEFAULT dDateProc := Date()-1

cQuery := " SELECT "
cQuery += " * " 
cQuery += " FROM " + RetSqlName("ZZW") + " ZZW "
cQuery += " WHERE "
cQuery += " ZZW.D_E_L_E_T_='' "
cQuery += " AND ZZW_DTINI <=' " + dToS(dDateProc) + "' "
cQuery += " AND ZZW_DTFIM >=' " + dToS(dDateProc) + "' "
cQuery += " AND ZZW_DTULT <=' " + dToS(dDateProc) + "' "
cQuery := ChangeQuery(cQuery)

If Select(_cAlias) > 0
	(_cAlias)->(DbCloseArea())
EndIf

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), _cAlias, .F., .F.)
(_cAlias)->(DBGOTOP())


While !(_cAlias)->(Eof())
	If !(Day(dDateProc+1)==1 .And. Month(dDateProc+1)==1 .And. (_cAlias)->ZZW_PROCES=="A")
		(_cAlias)->(DbSkip())
		Loop
	ElseIf !(Day(dDateProc+1)==1 .And. (_cAlias)->ZZW_PROCES=="M")
		(_cAlias)->(DbSkip())
		Loop
	Else
		cQuery1 := " SELECT "
		cQuery1 += " * "
		cQuery1 += " FROM " + RetSqlName("CT2") + " CT2 "
		cQuery1 += " WHERE " 
		cQuery1 += " CT2.D_E_L_E_T_='' "
		cQuery1 += " AND CT2_DC IN('1','3') "
		cQuery1 += If(Empty((_cAlias)->ZZW_CONTA), ," AND CT2_DEBITO='" + (_cAlias)->ZZW_CONTA + "' ")
		cQuery1 += If(Empty((_cAlias)->ZZW_CCUSTO),," AND CT2_CCD='" + (_cAlias)->ZZW_CCUSTO + "' ")
		cQuery1 += If(Empty((_cAlias)->ZZW_ITMCTB),," AND CT2_ITEMD='" + (_cAlias)->ZZW_ITMCTB + "' ")
		cQuery1 += If(Empty((_cAlias)->ZZW_CLVL),  ," AND CT2_CLVLDB='" + (_cAlias)->ZZW_CLVL + "' ")
		If (_cAlias)->ZZW_PROCES=="A"
			cQuery1 += " AND CT2_DATA BETWEEN '" + Alltrim(Str(Year(dDateProc)))+"0101" + "' AND '" + DToS(dDateProc)+ "' "
		ElseIf (_cAlias)->ZZW_PROCES=="M"
			cQuery1 += " AND CT2_DATA BETWEEN '" + DToS(FirstDay(dDateProc)) + "' AND '" + DToS(dDateProc)+ "' "
		Else
			cQuery1 += " AND CT2_DATA = '" + DToS(dDateProc) + "'"
		EndIf
		
		cQuery1 += " UNION ALL "
		
		cQuery1 += " SELECT "
		cQuery1 += " * "
		cQuery1 += " FROM " + RetSqlName("CT2") + " CT2 "
		cQuery1 += " WHERE " 
		cQuery1 += " CT2.D_E_L_E_T_='' "
		cQuery1 += " AND CT2_DC IN('2','3') "
		cQuery1 += If(Empty((_cAlias)->ZZW_CONTA), ," AND CT2_CREDIT='" + (_cAlias)->ZZW_CONTA + "' ")
		cQuery1 += If(Empty((_cAlias)->ZZW_CCUSTO),," AND CT2_CCC='" + (_cAlias)->ZZW_CCUSTO + "' ")
		cQuery1 += If(Empty((_cAlias)->ZZW_ITMCTB),," AND CT2_ITEMC='" + (_cAlias)->ZZW_ITMCTB + "' ")
		cQuery1 += If(Empty((_cAlias)->ZZW_CLVL),  ," AND CT2_CLVLCR='" + (_cAlias)->ZZW_CLVL + "' ")
		If (_cAlias)->ZZW_PROCES=="A"
			cQuery1 += " AND CT2_DATA BETWEEN '" + Alltrim(Str(Year(dDateProc)))+"0101" + "' AND '" + DToS(dDateProc)+ "' "
		ElseIf (_cAlias)->ZZW_PROCES=="M"
			cQuery1 += " AND CT2_DATA BETWEEN '" + DToS(FirstDay(dDateProc)) + "' AND '" + DToS(dDateProc)+ "' "
		Else
			cQuery1 += " AND CT2_DATA = '" + DToS(dDateProc) + "'"
		EndIf
		
		If Select(_cAlias1) > 0
			(_cAlias1)->(DbCloseArea())
		EndIf
		
		dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery1), _cAlias1, .F., .F.)
		(_cAlias1)->(DBGOTOP())
	
		lRet := ProcTitulo(_cAlias1)
	EndIf
	
(_cAlias)->(DbSkip())
EndDo
Return lRet


Static Function ProcTitulo(_cAlias1)
Local lRet := .T.



Return lRet
