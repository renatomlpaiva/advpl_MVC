#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

User Function NFAMARRA()
Local oBrowse
Local aButtons := {{.F.,Nil},{.F.,Nil},{.F.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,"Salvar"},{.T.,"Cancelar"},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil}}
PRIVATE _cAliasHUB := GetNextAlias()
PRIVATE _cAliasVP  := GetNextAlias()
PRIVATE _cAliasPP  := GetNextAlias()

Begin Transaction

	FWExecView('Amarracao serie HUB x AAA','HBAMARRA', MODEL_OPERATION_VIEW,  , { || .T. }, , ,aButtons )

End Transaction
Return


Static Function ModelDef()
Local oModel  := Nil
Local oStr1	:= Nil
Local oSetCABL //:= LoadStruct(1, _cAliasHUB)//FWFormStruct(1, 'SA1')
Local oSetCABC //:= LoadStruct(1, _cAliasVP)//FWFormStruct(1, 'SA1')
Local oSetCABR //:= LoadStruct(1, _cAliasPP)//FWFormStruct(1, 'SA1')
/*Local oSetHUB := LoadStruct(_cAliasHUB)
Local oSetVP  := LoadStruct(_cAliasVP)
Local oSetPP	:= LoadStruct(_cAliasPP)*/
Local oSetHUB 
Local oSetVP  
Local oSetPP	
Local aHUB_CAB:= {}
Local aHUB_VP	:= {}
Local aHUB_PP	:= {}

IF LLoad()
	oSetCABL := LoadStruct(1, _cAliasHUB)//FWFormStruct(1, 'SA1')
	oSetCABC := LoadStruct(1, _cAliasVP)//FWFormStruct(1, 'SA1')
	oSetCABR := LoadStruct(1, _cAliasPP)//FWFormStruct(1, 'SA1')
	
	oSetHUB 	:= LoadStruct(1,_cAliasHUB)//FWFormStruct(1, _cAliasHUB)
	oSetVP  	:= LoadStruct(1,_cAliasVP)//FWFormStruct(1, _cAliasVP)
	oSetPP		:= LoadStruct(1,_cAliasPP)//FWFormStruct(1, _cAliasPP)
	
	oModel := MPFormModel():New('NFAMARRM')
	
	oModel:AddFields('L_CAB',/*cOwner*/,oSetCABL)
	oModel:AddFields('C_CAB','L_CAB',oSetCABC)
	oModel:AddFields('R_CAB','L_CAB',oSetCABR)
	oModel:AddGrid('HUB_CAB'		,'L_CAB'     ,oSetHUB,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/, {|oFieldModel, lCopy| FWLoadByAlias( oFieldModel, _cAliasHUB, 'SF2' ) }/*bLoad - Carga do modelo manualmente*/)  //cOwner È para quem pertence
	oModel:AddGrid('HUB_VP'		,'HUB_CAB' ,oSetVP ,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/, {|oFieldModel, lCopy| FWLoadByAlias( oFieldModel, _cAliasVP, 'SF2' )}/*bLoad - Carga do modelo manualmente*/)  //cOwner È para quem pertence
	oModel:AddGrid('HUB_PP'		,'HUB_CAB' ,oSetPP ,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/, {|oFieldModel, lCopy| FWLoadByAlias( oFieldModel, _cAliasPP, 'SF2' )}/*bLoad - Carga do modelo manualmente*/)  //cOwner È para quem pertence
	
	
	//aAdd(aHUB_CAB,{'F2_CLIENTE',xFilial("SF2")})
	//aAdd(aHUB_CAB,{'F2_LOJA'   ,'A1_LOJA'})
	
	
	aAdd(aHUB_VP,{'F2_NFFATU','F2_DOC'})
	aAdd(aHUB_VP,{'F2_SERFAT','F2_SERIE'})
	aAdd(aHUB_VP,{'F2_PEDWEB','F2_PEDWEB'})
	
	aAdd(aHUB_PP,{'F2_DOC','F2_NFFATU'})
	aAdd(aHUB_PP,{'F2_SERIE'	,'F2_SERFAT'})
	aAdd(aHUB_PP,{'F2_PEDWEB','F2_PEDWEB'})
	
	
	//aAdd(aHUB_VP,{'F2_PEDWEB'	,'F2_PEDWEB'})
	
	//aAdd(aHUB_PP,{'F2_PEDWEB'	,'F2_PEDWEB'})
	/*
	aAdd(aHUB_VP,{'F2_DOC','F2_NFFATU'})
	aAdd(aHUB_VP,{'F2_SERIE'	,'F2_SERFAT'})
	
	aAdd(aHUB_PP,{'F2_DOC','F2_NFFATU'})
	aAdd(aHUB_PP,{'F2_SERIE'	,'F2_SERFAT'})
	*/
	oModel:SetRelation('HUB_CAB', aHUB_CAB, SF2->(IndexKey(1))) //IndexKey -> quero a ordenaÁ„o e depois filtrado
	oModel:GetModel('HUB_CAB'):SetUniqueLine({"F2_FILIAL", "F2_DOC", "F2_SERIE", "F2_CLIENTE", "F2_LOJA"})  //N„o repetir informaÁıes ou combinaÁıes {"CAMPO1","CAMPO2","CAMPOX"}
		
	oModel:SetRelation('HUB_VP', aHUB_VP, SF2->(IndexKey(1))) //IndexKey -> quero a ordenaÁ„o e depois filtrado
	//oModel:GetModel('HUB_VP'):SetLoadFilter({{'F2_PEDWEB'	,U_GetValue('HUB_VP','F2_PEDWEB')}})
	oModel:GetModel('HUB_VP'):SetUniqueLine({"F2_FILIAL", "F2_DOC", "F2_SERIE", "F2_CLIENTE", "F2_LOJA"})  //N„o repetir informaÁıes ou combinaÁıes {"CAMPO1","CAMPO2","CAMPOX"}
	//oModel:GetModel('HUB_VP'):SetLoadFilter({{'F2_DOC'	,'F2_NFFATU'},{'F2_SERIE','F2_SERFAT'}})
	oModel:GetModel('HUB_VP'):SetLoadFilter(aHUB_VP)
	oModel:SetPrimaryKey({})
	
	oModel:SetRelation('HUB_PP', aHUB_PP, SF2->(IndexKey(1))) //IndexKey -> quero a ordenaÁ„o e depois filtrado
	oModel:GetModel('HUB_PP'):SetUniqueLine({"F2_FILIAL", "F2_DOC", "F2_SERIE", "F2_CLIENTE", "F2_LOJA"})  //N„o repetir informaÁıes ou combinaÁıes {"CAMPO1","CAMPO2","CAMPOX"}
	//oModel:GetModel('HUB_PP'):SetLoadFilter({{'F2_DOC'	,'F2_NFFATU'},{'F2_SERIE','F2_SERFAT'}})
	//oModel:GetModel('HUB_PP'):SetLoadFilter({{'F2_PEDWEB'	,'F2_PEDWEB'}})
	oModel:GetModel('HUB_PP'):SetLoadFilter(aHUB_PP)
			
	oModel:SetPrimaryKey({})
	
	oModel:SetDescription("Amarracao")
	oModel:GetModel('HUB_CAB'):SetDescription('HubCard')
	oModel:GetModel('HUB_VP'):SetDescription('ValePresente')
	oModel:GetModel('HUB_PP'):SetDescription('PayPaxx')
EndIf
Return oModel

Static Function ViewDef()
Local oView	:= Nil
Local oModel	:= FWLoadModel('NFAMARRA')
Local oSetCABL:= LoadStruct(2,_cAliasHUB)//FWFormStruct(2, 'SA1')
Local oSetCABC:= LoadStruct(2,_cAliasVP)//FWFormStruct(2, 'SA1')
Local oSetCABR:= LoadStruct(2,_cAliasPP)//FWFormStruct(2, 'SA1')
Local oSetHUB	:= LoadStruct(2,_cAliasHUB)//FWFormStruct(2, _cAliasHUB)
Local oSetVP	:= LoadStruct(2,_cAliasVP)//FWFormStruct(2, _cAliasVP)
Local oSetPP	:= LoadStruct(2,_cAliasPP)//FWFormStruct(2, _cAliasPP)

oView := FWFormView():New()
oView:SetModel(oModel)

oView:AddField('VIEW_CAB_L'   ,oSetCABL,'L_CAB')
oView:AddField('VIEW_CAB_C'   ,oSetCABC,'R_CAB')
oView:AddField('VIEW_CAB_R'   ,oSetCABR,'R_CAB')
oView:AddGrid('VIEW_HUB'   	,oSetHUB,'HUB_CAB',,{|| GFocus('VIEW_HUB','HUB_CAB')})
oView:AddGrid('VIEW_VP'    	,oSetVP ,'HUB_VP')
oView:AddGrid('VIEW_PP'    	,oSetPP ,'HUB_PP')

oView:CreateHorizontalBox( 'CABEC', 20)
oView:CreateHorizontalBox( 'ROW1', 40)
oView:CreateHorizontalBox( 'ROW2', 40)

oView:CreateVerticalBox( 'L_CAB' , 33, 'CABEC' )
oView:CreateVerticalBox( 'C_CAB' , 34, 'CABEC' )
oView:CreateVerticalBox( 'R_CAB', 33, 'CABEC' )

oView:CreateVerticalBox( 'LEFT' , 50, 'ROW2' )
oView:CreateVerticalBox( 'RIGHT', 50, 'ROW2' )

oView:SetOwnerView('VIEW_CAB_L','L_CAB')
oView:SetOwnerView('VIEW_CAB_C','C_CAB')
oView:SetOwnerView('VIEW_CAB_R','R_CAB')
oView:SetOwnerView('VIEW_HUB','ROW1')
oView:SetOwnerView('VIEW_VP' ,'LEFT')
oView:SetOwnerView('VIEW_PP' ,'RIGHT')

oView:SetViewProperty("VIEW_HUB"	, "ENABLENEWGRID")
oView:SetViewProperty("VIEW_VP"		, "ENABLENEWGRID")
oView:SetViewProperty("VIEW_PP"		, "ENABLENEWGRID")

oView:SetViewProperty("VIEW_HUB"	, "GRIDFILTER", {.T.})
oView:SetViewProperty("VIEW_VP"		, "GRIDFILTER", {.T.})
oView:SetViewProperty("VIEW_PP"		, "GRIDFILTER", {.T.})

oView:EnableTitleView('VIEW_CAB_L'	,'HubCard')
oView:EnableTitleView('VIEW_CAB_C'	,'ValePresente')
oView:EnableTitleView('VIEW_CAB_R'	,'PayPaxx')
oView:EnableTitleView('VIEW_HUB'  	,'HubCard')
oView:EnableTitleView('VIEW_VP'  	,'ValePresente')
oView:EnableTitleView('VIEW_PP'  	,'PayPaxx')

oView:SetViewProperty("VIEW_HUB", "GRIDDOUBLECLICK", {{|oFormulario,cFieldName,nLineGrid,nLineModel| TESTE(oFormulario,cFieldName,nLineGrid,nLineModel)}})
//oView:SetViewProperty("VIEW_HUB", "CHANGELINE", {{ |oView, cViewID| ChangeLine(oView, cViewID) }} )
oView:SetProgressBar(.T.)

Return oView


Static Function TMPStruct(nTipo,aField)
Local oStruct 
Local n := 0

DEFAULT aField := {}

If Len(aField) == 0
	aAdd(aField,{'N.Fiscal'	 ,'TMP_DOC' 	, 'TMP_DOC'		, 'C', TamSX3("F2_DOC")[1]	 , 0, , , {}, .F., , .F., .F., .T., , })
	aAdd(aField,{'Serie'		 ,'TMP_SERIE' , 'TMP_SERIE'		, 'C', TamSX3("F2_SERIE")[1] , 0, , , {}, .F., , .F., .F., .T., , })
	aAdd(aField,{'PedidoWeb'	 ,'TMP_PEDWEB', 'TMP_PEDWEB'	, 'C', TamSX3("F2_PEDWEB")[1], 0, , , {}, .F., , .F., .F., .T., , })
	aAdd(aField,{'Serie Espelho','TMP_SERFAT'	, 'TMP_SERFAT', 'C', TamSX3("F2_SERFAT")[1], 0, , , {}, .F., , .F., .F., .T., , })
	aAdd(aField,{'NF Espelho'	 ,'TMP_EMPFAT', 'TMP_EMPFAT', 'C', TamSX3("F2_NFFATU")[1], 0, , , {}, .F., , .F., .F., .T., ,}) 
EndIf
If nTipo == 1 
	oStruct := FWFormModelStruct():New()
	oStruct:AddTable('TMP',,'TMP_FIELD')
	aEval(aField,{|x|  oStruct:AddField(x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8],x[9],x[10],x[11],x[12],x[13],x[14],x[15],x[16])})
ElseIf nTipo == 2
	n:= 0
	oStruct := FWFormViewStruct():New()
	aEval(aField,{|x| n++ ,oStruct:AddField( x[3],cValToChar(n),x[1],x[1],, 'Get' ,,,,,,,,,,,, )})
EndIf

Return oStruct

Static Function LoadStruct(nTipo,_cAlias)
Local oStruct
Local aStruct	:= (_cAlias)->(DbStruct())
Local i		:= 0
Local nColumn := 0
If nTipo == 1
	oStruct := FWFormModelStruct():New()
	oStruct:AddTable(_cAlias,,_cAlias)
	SX3->(DbSetOrder(2))
	For i := 1 To Len(aStruct)
		If aStruct[i][1] $ "|R_E_C_N_O_|D_E_L_E_T_|R_E_C_D_E_L_|"
		Else
			SX3->(DbGoTop())
			If SX3->(Dbseek(PadR(Alltrim(aStruct[i][1]),10)))
				nColumn++
				If SX3->X3_TIPO == "D"
					oStruct:AddField(Alltrim(SX3->X3_TITULO),aStruct[i][1] , aStruct[i][1], SX3->X3_TIPO, aStruct[i][3], aStruct[i][4], , , {}, .F.,&("{|| SToD("+_cAlias+"->"+aStruct[i][1]+")}") , .F., .F., .F., , )
				Else
					oStruct:AddField(Alltrim(SX3->X3_TITULO),aStruct[i][1] , aStruct[i][1], SX3->X3_TIPO, aStruct[i][3], aStruct[i][4], , , {}, .F.,&("{|| "+_cAlias+"->"+aStruct[i][1]+"}") , .F., .F., .F., , )
				EndIf
			Else
				nColumn++
				oStruct:AddField(aStruct[i][1],aStruct[i][1] , aStruct[i][1], aStruct[i][2], aStruct[i][3], aStruct[i][4], , , {}, .F.,&("{|| "+_cAlias+"->"+aStruct[i][1]+"}") , .F., .F., .F., , )
			EndIf
		EndIf
	Next
ElseIf nTipo ==2
	oStruct := FWFormViewStruct():New()
	SX3->(DbSetOrder(2))
	For i := 1 To Len(aStruct)
		If aStruct[i][1] $ "|R_E_C_N_O_|D_E_L_E_T_|R_E_C_D_E_L_|"
		Else
			SX3->(DbGoTop())
			If SX3->(Dbseek(PadR(Alltrim(aStruct[i][1]),10)))
				nColumn++
				oStruct:AddField(aStruct[i][1],cValToChar(nColumn),Alltrim(SX3->X3_TITULO), Alltrim(SX3->X3_TITULO),,'Get',,,,,,,,,,,,)
			Else
				nColumn++
				oStruct:AddField(aStruct[i][1],cValToChar(nColumn),aStruct[i][1] , aStruct[i][1],,'Get',,,,,,,,,,,,)
			EndIf
		EndIf
	Next	
EndIf

Return oStruct


Static Function LLoad()
Local lRet := .T.
Local aParam	:= {}
Local aRet	:= {}
Local cQry1:=cQry2:=cQry3:=""


If Select(_cAliasHUB) > 0
	(_cAliasHUB)->(DbCloseArea())
EndIf
If Select(_cAliasVP) > 0
	(_cAliasVP)->(DbCloseArea())
EndIf
If Select(_cAliasPP) > 0
	(_cAliasPP)->(DbCloseArea())
EndIf

aAdd(aParam,{1,"Data Inicio ?",STOD(SPACE(TAMSX3("F2_EMISSAO")[1])),"",".T.","",".T.",0,.F.})
aAdd(aParam,{1,"Data Fim    ?",STOD(SPACE(TAMSX3("F2_EMISSAO")[1])),"",".T.","",".T.",0,.F.})
			
If ParamBox(aParam,"Perido de amarraÁ„o serie HUB x AAA",@aRet)
	If aRet[1] <= aRet[2]
		cQry1 := "SELECT DISTINCT F2_FILIAL,F2_EMISSAO,F2_DOC,F2_SERIE,F2_NFFATU,F2_SERFAT,F2_EMPFAT,F2_FILFAT,F2_PEDWEB,F2_CLIENTE,F2_LOJA,R_E_C_N_O_ FROM SF2010 WHERE D_E_L_E_T_='' AND F2_SERIE='HUB' AND F2_EMISSAO BETWEEN '" + DTOS(aRet[1]) + "' AND '" + DTOS(aRet[2]) + "'"	
		cQry2 := "SELECT DISTINCT F2_FILIAL,F2_EMISSAO,F2_DOC,F2_SERIE,F2_NFFATU,F2_SERFAT,F2_EMPFAT,F2_FILFAT,F2_PEDWEB,F2_CLIENTE,F2_LOJA,R_E_C_N_O_ FROM SF2020 WHERE D_E_L_E_T_='' AND F2_SERIE='AAA' AND F2_EMISSAO BETWEEN '" + DTOS(aRet[1]) + "' AND '" + DTOS(aRet[2]) + "' AND F2_NFFATU<>''"
		cQry3 := "SELECT DISTINCT F2_FILIAL,F2_EMISSAO,F2_DOC,F2_SERIE,F2_NFFATU,F2_SERFAT,F2_EMPFAT,F2_FILFAT,F2_PEDWEB,F2_CLIENTE,F2_LOJA,R_E_C_N_O_ FROM SF2070 WHERE D_E_L_E_T_='' AND F2_SERIE='AAA' AND F2_EMISSAO BETWEEN '" + DTOS(aRet[1]) + "' AND '" + DTOS(aRet[2]) + "' AND F2_NFFATU<>''"

		dbUseArea(.T., "TOPCONN", TCGenQry(,,ChangeQuery(cQry1)), _cAliasHUB, .F., .T.)
		(_cAliasHUB)->(DBGOTOP())
		dbUseArea(.T., "TOPCONN", TCGenQry(,,ChangeQuery(cQry2)), _cAliasVP, .F., .T.)
		(_cAliasVP)->(DBGOTOP())
		dbUseArea(.T., "TOPCONN", TCGenQry(,,ChangeQuery(cQry3)), _cAliasPP, .F., .T.)
		(_cAliasPP)->(DBGOTOP())
	Else
		lRet := .F.
		MsgInfo("Informe a 'Data de Inicio' menor ou igual a 'Data Fim'")
	EndIf
Else
	lRet := .F.
EndIf

Return lRet 

Static Function LoadField1(oFieldModel, lCopy)
Local aLoad 	:= {}
Local _cAlias	:= _cAliasHUB
Local aStruct := (_cAlias)->(DbStruct())
Local aTemp	:= {} 

(_cAlias)->(DbGoTop())
While !(_cAlias)->(Eof())
	nX := 0
	aTemp	:= {}
   aEval(aStruct,{|x| aAdd(aTemp,(_cAlias)->&(x[1]))})
   aAdd(aLoad, {0,aTemp})

(_cAlias)->(DbSkip())
EndDo

      
Return aLoad

Static Function LoadField2(oFieldModel, lCopy)
Local aLoad 	:= {}
Local _cAlias	:= _cAliasVP
Local aStruct := (_cAlias)->(DbStruct())
Local aTemp	:= {} 

(_cAlias)->(DbGoTop())
While !(_cAlias)->(Eof())
	nX := 0
	aTemp	:= {}
   aEval(aStruct,{|x| aAdd(aTemp,(_cAlias)->&(x[1]))})
   aAdd(aLoad, {0,aTemp})

(_cAlias)->(DbSkip())
EndDo

      
Return aLoad

Static Function LoadField3(oFieldModel, lCopy)
Local aLoad 	:= {}
Local _cAlias	:= _cAliasPP
Local aStruct := (_cAlias)->(DbStruct())
Local aTemp	:= {} 

(_cAlias)->(DbGoTop())
While !(_cAlias)->(Eof())
	nX := 0
	aTemp	:= {}
   aEval(aStruct,{|x| aAdd(aTemp,(_cAlias)->&(x[1]))})
   aAdd(aLoad, {0,aTemp})

(_cAlias)->(DbSkip())
EndDo

      
Return aLoad
Return

User Function GetValue(cModel,cField)
Local aValue := {''}
Local oModelA	
Local oModel	
If !(cModel == Nil .Or. cField == Nil)
	ALERT(cModel+CRLF+cField)
	If (oModelA:= FWModelActive()) != Nil
		alert('ok')
		oModel	:= oModelA:GetModel(cModel)
	 	aValue[1] := oModel:GetValue(cField)
	 	alert('avalue>>' + cValToChar(aValue[1]))
 	EndIf
EndIf

Return aValue

Static Function TESTE(oFormulario,cFieldName,nLineGrid,nLineModel)
Local oMdlAct	:= FWModelActive()
Local oView	:= FWViewActive()
/*//If oMdlAct:GetModel('HUB_CAB'):GetValue("F2_EMPFAT") == "02"
	cNota	:= oMdlAct:GetModel('HUB_CAB'):GetValue("F2_NFFATU")
	cSerie	:= oMdlAct:GetModel('HUB_CAB'):GetValue("F2_SERFAT")
	cPedweb:= oMdlAct:GetModel('HUB_CAB'):GetValue("F2_PEDWEB")
	oMdlAct:GetModel('HUB_VP'):SetLoadFilter({;
						{'F2_DOC'   ,&("'"+cNota+"'")},;
						{'F2_SERIE',&("'"+cSerie+"'")},;
						{'F2_PEDWEB',&("'"+cPedweb+"'")}})	
//ElseIf oMdlAct:GetModel('HUB_CAB'):GetValue("F2_EMPFAT") == "07"
	cNota	:= oMdlAct:GetModel('HUB_CAB'):GetValue("F2_NFFATU")
	cSerie	:= oMdlAct:GetModel('HUB_CAB'):GetValue("F2_SERFAT")
	cPedweb:= oMdlAct:GetModel('HUB_CAB'):GetValue("F2_PEDWEB")
	oMdlAct:GetModel('HUB_PP'):SetLoadFilter({;
						{'F2_DOC'   ,&("'"+cNota+"'")},;
						{'F2_SERIE',&("'"+cSerie+"'")},;
						{'F2_PEDWEB',&("'"+cPedweb+"'")}})
//EndIf
*/
oView:Refresh('VIEW_VP')
oView:Refresh('VIEW_PP')
alert('duplo click >>'+cFieldName)
Return 

Static Function GFocus(cView,cModel)
	Alert('Recebeu o Foco >>'+cModel)
Return .T.

Static Function ChangeLine(oView, cViewID) 
	alert('change line>>'+cViewID)
Return .T.
