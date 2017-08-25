#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

User Function DLGMVC01()
Local aButtons := {{.F.,Nil},{.F.,Nil},{.F.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,"Gera Espelho"},{.T.,"Fechar"},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil}}
 
LoadField(0)
/*
//Descomentar linhar para teste 
DbSelectArea("SF2")
DbSelectArea("SD2")
*/

FWExecView('MATA460','DLGMVC01', MODEL_OPERATION_UPDATE,  , { || .T. }, , ,aButtons )

If Select("TMP") > 0
	TMP->(DbCloseArea())
EndIf

Return 

Static Function ModelDef()
Local oModel  := Nil
Local oStr1	:= Nil
Local oSetCAB 
Local oSetHUB  
Local oSetItem
Local aHUB_Cab:= {}
Local aHUB_Item:= {}
Local _cAliasX2 := 'SX2MDI'
 
oSetCAB := LoadField(1)
oSetHUB := FWFormStruct(1, 'SF2')
oSetItem:= FWFormStruct(1, 'SD2')
oModel := MPFormModel():New('M_MIRROR'/*cID*/, /*bPre*/, /*bPost*/,{|oModel| HBMirror(oModel)} /*bCommit*/, {|| MsgYesNo("AtenÁ„o!!!"+CRLF+"A amarraÁ„o da Nota Fiscal com seu espelhamento devera ser realizada de forma manual caso cancele esse processamento.")}/*bCancel */)
	
oModel:AddFields('CAB',/*cOwner*/,oSetCAB)
oModel:AddFields('HUB_CAB'	,'CAB'   	,oSetHUB  ,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/, /*bLoad - Carga do modelo manualmente*/)  //cOwner È para quem pertence
oModel:AddGrid('HUB_ITEM'	,'HUB_CAB'	,oSetItem ,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/, /*bLoad - Carga do modelo manualmente*/)  //cOwner È para quem pertence
	
//aAdd(aHUB_Cab,{'F2_FILIAL' ,xFilial("SF2")})

aAdd(aHUB_Item,{'D2_FILIAL' ,'F2_FILIAL'})
aAdd(aHUB_Item,{'D2_DOC'    ,'F2_DOC'})
aAdd(aHUB_Item,{'D2_SERIE'  ,'F2_SERIE'})
aAdd(aHUB_Item,{'D2_CLIENTE','F2_CLIENTE'})
aAdd(aHUB_Item,{'D2_LOJA'   ,'F2_LOJA'})

//oModel:SetRelation('HUB_ITEM', aHUB_Cab, SF2->(IndexKey(1)))
//oModel:GetModel('HUB_CAB'):SetLoadFilter({{'F2_PEDWEB'   ,"'5QEA3LHF6C'"}})
	
oModel:SetRelation('HUB_ITEM', aHUB_Item, SD2->(IndexKey(1))) //IndexKey -> quero a ordenaÁ„o e depois filtrado
oModel:GetModel('HUB_ITEM'):SetUniqueLine({"D2_FILIAL", "D2_DOC", "D2_SERIE", "D2_CLIENTE", "D2_LOJA", "D2_ITEM"})  //N„o repetir informaÁıes ou combinaÁıes {"CAMPO1","CAMPO2","CAMPOX"}
		
oModel:SetPrimaryKey({})
	
oModel:SetDescription("Gerador de Empelho HUB x AAA")

Return oModel


Static Function ViewDef()
Local oView	:= Nil
Local oModel	:= FWLoadModel('DLGMVC01')
Local oSetCAB := LoadField(2)
Local oSetHUB	:= FWFormStruct(2,"SF2")
Local oSetItem:= FWFormStruct(2,"SD2")

oView := FWFormView():New()
oView:SetModel(oModel)

oView:AddField('VIEW_CAB'  ,oSetCAB ,'CAB')
oView:AddField('VIEW_HUB'  ,oSetHUB ,'HUB_CAB')
oView:AddGrid('VIEW_ITEM'  ,oSetItem,'HUB_ITEM')

oView:CreateHorizontalBox( 'ROW1', 10)
oView:CreateHorizontalBox( 'ROW2', 50)
oView:CreateHorizontalBox( 'ROW3', 40)

oView:SetOwnerView('VIEW_CAB' ,'ROW1')
oView:SetOwnerView('VIEW_HUB' ,'ROW2')
oView:SetOwnerView('VIEW_ITEM','ROW3')

oView:SetViewProperty("VIEW_ITEM"		, "ENABLENEWGRID")

oView:EnableTitleView('VIEW_CAB'  	,'Empresa para geraÁ„o do espelho')
oView:EnableTitleView('VIEW_HUB'  	,'Nota Fiscal')

oView:SetOnlyView('VIEW_HUB')
oView:SetOnlyView('VIEW_ITEM')

oView:SetProgressBar(.T.)

Return oView

Static Function HBMIRROR(oModel)
Local aParam	:= {}
Local aRet	:= {}
Local _cEmp := ""
Local _cFil := ""
Local _cSerie := ""
Local lRet := .T.
Local aErros := {}
Local aDados := {}
Local aAllArea := GetAllArea()

aRet := {oModel:GetModel('CAB'):GetValue('TMP_EMP'),oModel:GetModel('CAB'):GetValue('TMP_FIL'),,oModel:GetModel('CAB'):GetValue('TMP_FIL')}

aAdd(aParam,{1,"Cod. Empresa",SPACE(2),,"eVal({|| If(MV_PAR01==FwCodEmp(),MsgAlert('Nao È permitido a geraÁ„o de espelhamento dentro da mesma empresa'),.T.)})","X_SM01","",0,.F.})
aAdd(aParam,{1,"Cod. Filial",SPACE(2),,"eVal({|| If(MV_PAR01==FwCodEmp() .And. MV_PAR02==FwCodFil(),MsgAlert('Nao È permitido a geraÁ„o de espelhamento dentro da mesma empresa'),.T.)})","X_SM02","",0,.F.})
aAdd(aParam,{1,"Cod. Filial",SPACE(2),,"eVal({|| !EMPTY(MV_PAR03)})","","",0,.F.})

If Empty(oModel:GetModel('CAB'):GetValue('TMP_EMP')) .Or. Empty(oModel:GetModel('CAB'):GetValue('TMP_FIL'))
	If ParamBox(aParam,"AmarraÁ„o serie HUB x AAA",@aRet)
		_cEmp	:= aRet[1]
		_cFil	:= aRet[2]
		_cSerie:= aRet[3]
		aDados := GeraDados({{{"C5_SERWEB",_cSerie}},{}})
		aRet := StartJob("U_GrMirror",GetEnvServer(),.T.,{_cEmp, _cFil, aDados[2], aDados[3], 3,_cSerie,aDados[4],SF2->F2_DOC,SF2->F2_SERIE})
	Else
		lRet := .F.
	EndIf
Else
	_cEmp	:= oModel:GetModel('CAB'):GetValue('TMP_EMP')
	_cFil	:= oModel:GetModel('CAB'):GetValue('TMP_FIL')
	_cSerie:= oModel:GetModel('CAB'):GetValue('TMP_SERIE')
	aDados := GeraDados({{{"C5_SERWEB",_cSerie}},{}})
	aRet := StartJob("U_GrMirror",GetEnvServer(),.T.,{_cEmp, _cFil, aDados[2], aDados[3], 3,_cSerie,aDados[4],SF2->F2_DOC,SF2->F2_SERIE})
EndIf

If Len(aRet[1]) > 0
	lRet := .F. 
	MsgAlert("Houve algum problema na geraÁ„o de espelhamento processe novamente.")
Else
	RecLock("SF2",.F.)
		SF2->F2_NFFATU := aRet[2] 
		SF2->F2_SERFAT := aRet[3] 
	SF2->(MsUnLock())
EndIf

GetAllArea(aAllArea)
Return lRet

Static Function GeraDados(aField)
Local aCabec	:={}
Local aItens	:={}
Local aLinha	:={}
Local aAllArea:= GetAllArea()
Local lRet		:= .T.
Local nPos		:= 0
Local i		:= 0
Local nVlTotal:= 0
	
SC6->(DbSetOrder(1))
SC6->(DbGoTop())

If SC6->(DbSeek(SC5->(C5_FILIAL+C5_NUM)))
	i := 0
	While SC5->C5_FILIAL == SC6->C6_FILIAL .And.  SC5->C5_NUM == SC6->C6_NUM .And. SC5->C5_CLIENTE == SC6->C6_CLI .And. SC5->C5_LOJACLI == SC6->C6_LOJA 
		aLinha := {}
			i++
			aAdd(aLinha,{"C6_ITEM"	,StrZero(i,2)		,Nil})
			aAdd(aLinha,{"C6_PRODUTO",SC6->C6_PRODUTO	,Nil})
			aAdd(aLinha,{"C6_DESCRI"	,SC6->C6_DESCRI	,Nil})
			aAdd(aLinha,{"C6_QTDVEN"	,SC6->C6_QTDVEN	,Nil})
			aAdd(aLinha,{"C6_PRCVEN"	,SC6->C6_PRCVEN	,Nil})
			aAdd(aLinha,{"C6_VALOR"	,SC6->C6_VALOR	,Nil})
			aAdd(aLinha,{"C6_TES"	,SC6->C6_TES		,Nil})
			aAdd(aLinha,{"C6_XCONTA"	,SC6->C6_XCONTA	,Nil})
			aAdd(aLinha,{"C6_XCCUSTO",SC6->C6_XCCUSTO	,Nil})
			aAdd(aLinha,{"C6_XITEMCT",SC6->C6_XITEMCT	,Nil})
			nVlTotal += SC6->C6_VALOR
			aEval(aField[2],{|x| aAdd(aLinha,{x[1],x[2],Nil})})
			If(Len(aLinha)>0,aAdd(aItens,aLinha),)
		
	SC6->(DbSkip())
	EndDo

	aAdd(aCabec,{"C5_TIPO"	,SC5->C5_TIPO		,Nil})
	aAdd(aCabec,{"C5_CLIENTE",SC5->C5_CLIENTE	,Nil})
	aAdd(aCabec,{"C5_LOJACLI",SC5->C5_LOJACLI	,Nil})
	aAdd(aCabec,{"C5_LOJAENT",SC5->C5_LOJAENT	,Nil})
	aAdd(aCabec,{"C5_CONDPAG",SC5->C5_CONDPAG	,Nil})
	aAdd(aCabec,{"C5_DATA1"	,SC5->C5_DATA1	,Nil})
	aAdd(aCabec,{"C5_PARC1"	,If(Empty(SC5->C5_DATA1),0,nVlTotal)	,Nil})
	aAdd(aCabec,{"C5_TPVENDA",SC5->C5_TPVENDA	,Nil})
	aAdd(aCabec,{"C5_MENNOTA",SC5->C5_MENNOTA	,Nil})
	aAdd(aCabec,{"C5_EMISSAO",SC5->C5_EMISSAO	,Nil})
	aAdd(aCabec,{"C5_PEDWEB"	,SC5->C5_PEDWEB	,Nil})
	aAdd(aCabec,{"C5_XIDMP"	,SC5->C5_XIDMP	,Nil})
	aAdd(aCabec,{"C5_XIDREC"	,SC5->C5_XIDREC	,Nil})
	aAdd(aCabec,{"C5_XJOBFLG",'J'				,Nil})
	aAdd(aCabec,{"C5_XNUMZZB",SC5->C5_NUM		,Nil})
	aAdd(aCabec,{"C5_EMPFAT",SM0->M0_CODIGO	,Nil})
	aAdd(aCabec,{"C5_FILFAT",SM0->M0_CODFIL	,Nil})
	
	aEval(aField[1],{|x| aAdd(aCabec,{x[1],x[2],Nil})})

Else 
	lRet := .F.
EndIf

GetAllArea(aAllArea)

Return {lRet,aCabec,aItens,SC5->C5_NUM}


User Function GrMirror(aParam)
Local _cEmp	:= aParam[1]
Local _cFil	:= aParam[2]
Local aCabec	:= aParam[3]
Local aItens	:= aParam[4]
Local nTp		:= aParam[5]
Local cNumPedOri:= aParam[7]
Local cNumPed := ""
Local _cSerie	:= aParam[6]
Local _cSerieOri	:= aParam[9]
Local cNotaOri := aParam[8]
Local aErros 	:= {}
Local cDoc		:= ""
Local cField 	:= ""
Local cId		:= ""

RpcSetType(3)
RpcSetEnv(_cEmp,_cFil)

Begin Transaction
	aErros := StaticCall(U_MATA410,GerPedVen,cDoc,aCabec,aItens) 
	
	If Len(aErros) == 0
		cFiltro := " AND C5_XJOBFLG='J' AND C5_XNUMZZB='"+cNumPedOri+"' "
		GetPedido(@cNumPed,cFiltro)
		aRetNf := StaticCall(U_MATA410,PrepNfs,Nil,Nil,cNumPed,_cSerie)
		
		If Empty(aRetNf[1])
			cNota := StaticCall(U_MATA410,GetNFiscal,aCabec)
		Else
			cNota := aRetNf[1] 
		EndIf
		If Empty(cNota)
			DisarmTransaction()
			aAdd(aErros,{"ExecAuto","Problema na geraÁ„o da nota fiscal."})
		Else
			UpdMirror(cNota,_cSerie,cNotaOri,_cSerieOri)
		EndIf
	EndIf
	 
End Transaction

Return {aErros,cNota,_cSerie}

Static Function UpdMirror(cNota,_cSerie,cNotaOri,_cSerieOri)
Local cQuery := ""
Local lUpd := .F.

If SF2->F2_FILIAL == xFilial("SF2") .And. SF2->F2_DOC == PadR(cNota,TamSX3("F2_DOC")[1]) .And. SF2->F2_SERIE == PadR(_cSerie,TamSX3("F2_SERIE")[1])	
	lUpd := .T.
Else
	SF2->(DbSetOrder(1))
	If SF2->(DbSeek(xFilial("SF2")+PadR(cNota,TamSX3("F2_DOC")[1])+PadR(_cSerie,TamSX3("F2_SERIE")[1])))
		lUpd := .T.
	EndIf
End


Return lUpd


Static Function GetPedido(cNumPed,cFiltro)
Local cQuery := ""
Local _cAlias := GetNextAlias()

DEFAULT cFiltro := ""
cQuery := " SELECT C5_NUM "
cQuery += " FROM " + RetSqlName("SC5") + " SC5 "
cQuery += " WHERE "
cQuery += " SC5.D_E_L_E_T_='' "
cQuery += cFiltro

dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), _cAlias, .F., .F.)
(_cAlias)->(DbGoTop())
If !(_cAlias)->(Eof())
	cNumPed := (_cAlias)->C5_NUM
EndIf

Return 

Static Function LoadField(nTipo,aField,aTrigger)
Local oStruct 
Local n := 0
Local aColumn := {}

DEFAULT aField := {}
DEFAULT aTrigger := {}

If Len(aField) == 0
	aAdd(aField,{'Cod.Empresa'	 ,'TMP_EMP' , 'TMP_EMP'	  	, 'C', 02 , 0,FwBuildFeature(STRUCT_FEATURE_VALID,"!(M->TMP_EMP==FwCodEmp())") , , {}, .F., , .F., .F., .T., , ,'X_SM01'})
	aAdd(aField,{'Cod.Filial'	 ,'TMP_FIL' , 'TMP_FIL'		, 'C', 12 , 0, , , {}, .F., , .F., .F., .T., , ,''})
	aAdd(aField,{'Nome'	 		 ,'TMP_NOME', 'TMP_NOME'		, 'C', 40 , 0, , , {}, .F., , .F., .F., .T., , ,''}) 
	aAdd(aField,{'Serie Espelho' ,'TMP_SERIE', 'TMP_SERIE'	, 'C', TAMSX3("F2_SERIE")[1] , 0, , , {}, .F., , .F., .F., .T., , ,''})
	aAdd(aTrigger,{'TMP_EMP','TMP_FIL',{|| .T.},{|| SM0->M0_CODFIL}})
	aAdd(aTrigger,{'TMP_EMP','TMP_NOME',{|| .T.},{|| SM0->M0_NOME}})
EndIf
If nTipo == 0
	If Select("TMP") > 0
		TMP->(DbCloseArea())
	EndIf
	aEval(aField,{|x| aAdd(aColumn,{x[3],x[4],x[5],x[6]})})
	cArq	:= CriaTrab(aColumn,.T.)
	dbUseArea(.T.,"DBFCDX",cArq,"TMP",.T.,.F.)	
ElseIf nTipo == 1 
	oStruct := FWFormModelStruct():New()
	oStruct:AddTable('TMP',,'TMP_FIELD')
	aEval(aField,{|x|  oStruct:AddField(x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8],x[9],x[10],x[11],x[12],x[13],x[14],x[15],x[16])})
	aEval(aTrigger,{|x| oStruct:AddTrigger(x[1],x[2],x[3],x[4])})
ElseIf nTipo == 2
	n:= 0
	oStruct := FWFormViewStruct():New()
	aEval(aField,{|x| n++ ,oStruct:AddField( x[3],cValToChar(n),x[1],x[1],, 'Get' ,,,x[17],,,,,,,,, )})
EndIf

Return oStruct
