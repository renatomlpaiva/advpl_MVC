#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

User Function GDC_MVC()
Local oBrowse
Local _cAliasCab := "SA1"
Local cTitulo := "GDC - Saldo de Contratos"
Local cPerg := "GDC_MVC"

Private cCampanha := ""
Private cAliasCtr := ""
Private cCliente  := ""
Private cLoja	    := ""

//AjustaSX1(cPerg)
//Pergunte(cPerg,.F.)
//SetKey(VK_F12,{||  Pergunte(cPerg,.T.)})

oBrowse := FWmBrowse():New()

oBrowse:SetAlias(_cAliasCab)
oBrowse:SetDescription(cTitulo)

/*oBrowse:AddLegend("ZZY->ZZY_STATUS == 'B'","BR_VERDE"	,"Baixado com suscesso" )
oBrowse:AddLegend("ZZY->ZZY_STATUS == 'I'","BR_AZUL"		,"Não Importado - Critica da rotina")
oBrowse:AddLegend("ZZY->ZZY_STATUS == 'E'","BR_VERMELHO","Cancelamento / Estorno de baixa")
oBrowse:AddLegend("ZZY->ZZY_STATUS == '1'","BR_AMARELO"	,"Não Importado - Critica do sistema")
*/


oBrowse:Activate()

Return Nil


Static Function MenuDef()
Local aRotinas := {}

aAdd(aRotinas,{'Imprimir','U_GDCPRINT'	,0,MODEL_OPERATION_VIEW	 ,0,NIL})
aAdd(aRotinas,{'Visualizar','VIEWDEF.GDC_MVC'	,0,MODEL_OPERATION_VIEW	 ,0,NIL})

Return aRotinas
//Return FWMVCMenu('GDC_MVC')

Static Function ModelDef()
Local oModel   := Nil
Local oSetSA1  := FWFormStruct(1, 'SA1')
Local oSetZZF  := FWFormStruct(1, 'ZZF')
Local oSetZZB  := FWFormStruct(1, 'ZZB')
Local oSetZZG  := FWFormStruct(1, 'ZZG')
Local oSetZZH  := FWFormStruct(1, 'ZZH')
Local oSetZZI  := FWFormStruct(1, 'ZZI')
Local oSetZZJ  := FWFormStruct(1, 'ZZJ')
Local aZZBRel  := {}
Local aZZB_ZZF := {}
Local aZZB_ZZG := {}
Local aZZB_ZZH := {}
Local aZZB_ZZJ := {}

Local aZZI_IN  := {}
Local aZZI_OUT := {}
     
oModel := MPFormModel():New('GDC_MVCM')
oModel:AddFields('SA1_GDC',/*cOwner*/,oSetSA1)
oModel:AddGrid('ZZB_ZZF'		,'SA1_GDC',oSetZZF,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZB_GDC'		,'ZZB_ZZF',oSetZZB,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZB_GDC_G'	,'ZZB_ZZF',oSetZZB,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZB_ZZG'		,'ZZB_ZZF',oSetZZG,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence     
oModel:AddGrid('ZZB_ZZG_G'	,'ZZB_ZZF',oSetZZG,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence     
oModel:AddGrid('ZZB_ZZH'		,'ZZB_ZZF',oSetZZH,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZB_ZZH_G'	,'ZZB_ZZF',oSetZZH,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZB_ZZJ'		,'ZZB_ZZF',oSetZZJ,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZB_ZZJ_G'	,'ZZB_ZZF',oSetZZJ,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZI_IN' 		,'ZZB_ZZF',oSetZZI,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZI_IN_G' 	,'ZZB_ZZF',oSetZZI,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZI_OUT'		,'ZZB_ZZF',oSetZZI,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
oModel:AddGrid('ZZI_OUT_G'	,'ZZB_ZZF',oSetZZI,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence

//oModel:AddGrid('ZZB_ZZF','ZZB_ZZG',oSetZZF,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
//oModel:AddGrid('ZZB_ZZF','ZZB_ZZH',oSetZZF,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
//oModel:AddGrid('ZZB_ZZF','ZZB_ZZI',oSetZZF,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence


aAdd(aZZBRel, {'ZZB_CLIENT','ZZF_CLIENT'} )
aAdd(aZZBRel, {'ZZB_LOJACL','ZZF_LOJACL'}) 

aAdd(aZZB_ZZF, {'ZZF_CLIENT','A1_COD'})
aAdd(aZZB_ZZF, {'ZZF_LOJACL','A1_LOJA'})

aAdd(aZZB_ZZG, {'ZZG_CLIENT','ZZF_CLIENT'})
aAdd(aZZB_ZZG, {'ZZG_LOJACL','ZZF_LOJACL'})
aAdd(aZZB_ZZG, {'ZZG_NUMERO','ZZF_NUMERO'})

aAdd(aZZB_ZZH, {'ZZH_CLIENT','ZZF_CLIENT'})
aAdd(aZZB_ZZH, {'ZZH_LOJACL','ZZF_LOJACL'})
aAdd(aZZB_ZZH, {'ZZH_NUMERO','ZZF_NUMERO'})

aAdd(aZZB_ZZJ, {'ZZJ_CLIENT','ZZF_CLIENT'})
aAdd(aZZB_ZZJ, {'ZZJ_LOJACL','ZZF_LOJACL'})
aAdd(aZZB_ZZJ, {'ZZJ_NUMERO','ZZF_NUMERO'})

aAdd(aZZI_IN, {'ZZI_CLIENT','ZZF_CLIENT'})
aAdd(aZZI_IN, {'ZZI_LOJACL','ZZF_LOJACL'})
aAdd(aZZI_IN, {'ZZI_NUMDES','ZZF_NUMERO'})

aAdd(aZZI_OUT, {'ZZI_CLIENT','ZZF_CLIENT'})
aAdd(aZZI_OUT, {'ZZI_LOJACL','ZZF_LOJACL'})
aAdd(aZZI_OUT, {'ZZI_NUMORI','ZZF_NUMERO'})

oModel:SetRelation('ZZB_ZZF', aZZB_ZZF, ZZF->(IndexKey(6))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_ZZF'):SetUniqueLine({"ZZF_FILIAL","ZZF_NUM","ZZF_NUMERO","ZZF_FLAG","ZZF_CLIENT","ZZF_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_GDC', aZZBRel, ZZB->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_GDC'):SetUniqueLine({"ZZB_FILIAL","ZZB_TPVEND","ZZB_NUM","ZZB_CLIENT","ZZB_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_GDC'):SetLoadFilter({{'ZZB_CLIENT'   ,'ZZF_CLIENT'},{'ZZB_LOJACL','ZZF_LOJACL'},{'ZZB_NUM','ZZF_NUM'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_GDC_G', aZZBRel, ZZB->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_GDC_G'):SetUniqueLine({"ZZB_FILIAL","ZZB_TPVEND","ZZB_NUM","ZZB_CLIENT","ZZB_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_GDC_G'):SetLoadFilter({{'ZZB_CLIENT'   ,'ZZF_CLIENT'},{'ZZB_LOJACL','ZZF_LOJACL'},{'ZZB_NUM','ZZF_NUM'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_ZZG', aZZB_ZZG, ZZG->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_ZZG'):SetUniqueLine({"ZZG_FILIAL","ZZG_NUM","ZZG_CLIENT","ZZG_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_ZZG'):SetLoadFilter({{'ZZG_CLIENT'   ,'ZZF_CLIENT'},{'ZZG_LOJACL','ZZF_LOJACL'},{'ZZG_NUMERO','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_ZZG_G', aZZB_ZZG, ZZG->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_ZZG_G'):SetUniqueLine({"ZZG_FILIAL","ZZG_NUM","ZZG_CLIENT","ZZG_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_ZZG_G'):SetLoadFilter({{'ZZG_CLIENT'   ,'ZZF_CLIENT'},{'ZZG_LOJACL','ZZF_LOJACL'},{'ZZG_NUMERO','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_ZZH', aZZB_ZZH, ZZH->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_ZZH'):SetUniqueLine({"ZZH_FILIAL","ZZH_NUM","ZZH_CLIENT","ZZH_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_ZZH'):SetLoadFilter({{'ZZH_CLIENT'   ,'ZZF_CLIENT'},{'ZZH_LOJACL','ZZF_LOJACL'},{'ZZH_NUMERO','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_ZZH_G', aZZB_ZZH, ZZH->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_ZZH_G'):SetUniqueLine({"ZZH_FILIAL","ZZH_NUM","ZZH_CLIENT","ZZH_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_ZZH_G'):SetLoadFilter({{'ZZH_CLIENT'   ,'ZZF_CLIENT'},{'ZZH_LOJACL','ZZF_LOJACL'},{'ZZH_NUMERO','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZI_IN', aZZI_IN, ZZI->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZI_IN'):SetUniqueLine({"ZZI_FILIAL","ZZI_NUM","ZZI_CLIENT","ZZI_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZI_IN'):SetLoadFilter({{'ZZI_CLIENT'   ,'ZZF_CLIENT'},{'ZZI_LOJACL','ZZF_LOJACL'},{'ZZI_NUMDES','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZI_IN_G', aZZI_IN, ZZI->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZI_IN_G'):SetUniqueLine({"ZZI_FILIAL","ZZI_NUM","ZZI_CLIENT","ZZI_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZI_IN_G'):SetLoadFilter({{'ZZI_CLIENT'   ,'ZZF_CLIENT'},{'ZZI_LOJACL','ZZF_LOJACL'},{'ZZI_NUMDES','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZI_OUT', aZZI_OUT, ZZI->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZI_OUT'):SetUniqueLine({"ZZI_FILIAL","ZZI_NUM","ZZI_CLIENT","ZZI_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZI_OUT'):SetLoadFilter({{'ZZI_CLIENT'   ,'ZZF_CLIENT'},{'ZZI_LOJACL','ZZF_LOJACL'},{'ZZI_NUMORI','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZI_OUT_G', aZZI_OUT, ZZI->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZI_OUT_G'):SetUniqueLine({"ZZI_FILIAL","ZZI_NUM","ZZI_CLIENT","ZZI_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZI_OUT_G'):SetLoadFilter({{'ZZI_CLIENT'   ,'ZZF_CLIENT'},{'ZZI_LOJACL','ZZF_LOJACL'},{'ZZI_NUMORI','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_ZZJ', aZZB_ZZJ, ZZJ->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_ZZJ'):SetUniqueLine({"ZZJ_FILIAL","ZZJ_NUM","ZZJ_CLIENT","ZZJ_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_ZZJ'):SetLoadFilter({{'ZZJ_CLIENT'   ,'ZZF_CLIENT'},{'ZZJ_LOJACL','ZZF_LOJACL'},{'ZZJ_NUMERO','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:SetRelation('ZZB_ZZJ_G', aZZB_ZZJ, ZZJ->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
oModel:GetModel('ZZB_ZZJ_G'):SetUniqueLine({"ZZJ_FILIAL","ZZJ_NUM","ZZJ_CLIENT","ZZJ_LOJACL"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:GetModel('ZZB_ZZJ_G'):SetLoadFilter({{'ZZJ_CLIENT'   ,'ZZF_CLIENT'},{'ZZJ_LOJACL','ZZF_LOJACL'},{'ZZJ_NUMERO','ZZF_NUMERO'}})
oModel:SetPrimaryKey({})

oModel:AddCalc('TOT_CONTRA' , 'SA1_GDC', 'ZZB_ZZF', 'ZZF_VALOR' , 'XX_CONTRA' , 'SUM', , , "Total Contrato:" )
oModel:AddCalc('TOT_ADITIVO', 'SA1_GDC', 'ZZB_ZZF', 'ZZF_VLADIT', 'XX_ADITIVO', 'SUM', , , "Total Aditivo:" )
oModel:AddCalc('TOT_MEDICAO', 'SA1_GDC', 'ZZB_ZZF', 'ZZF_VLMEDI', 'XX_MEDICAO', 'SUM', , , "Total Medicao:" )
oModel:AddCalc('TOT_TRF_IN' , 'SA1_GDC', 'ZZB_ZZF', 'ZZF_VLREC' , 'XX_TRF_IN' , 'SUM', , , "Total Trf. In:" )
oModel:AddCalc('TOT_TRF_OUT', 'SA1_GDC', 'ZZB_ZZF', 'ZZF_VLENV' , 'XX_TRF_OUT', 'SUM', , , "Total Trf. Out:" )
oModel:AddCalc('TOT_ESTORNO', 'SA1_GDC', 'ZZB_ZZF', 'ZZF_VLEST' , 'XX_ESTORNO', 'SUM', , , "Total Estorno:" )

oModel:SetDescription("Saldo de Contratos")
oModel:GetModel('SA1_GDC'):SetDescription('Cliente')
oModel:GetModel('ZZB_ZZF'):SetDescription('Contrato')
oModel:GetModel('ZZB_ZZG'):SetDescription('Aditivos')
oModel:GetModel('ZZB_ZZG_G'):SetDescription('Aditivos')
oModel:GetModel('ZZB_ZZH'):SetDescription('Medicoes')
oModel:GetModel('ZZB_ZZH_G'):SetDescription('Medicoes')
oModel:GetModel('ZZB_ZZJ'):SetDescription('Estorno')
oModel:GetModel('ZZB_ZZJ_G'):SetDescription('Estorno')
oModel:GetModel('ZZI_IN'):SetDescription('Transferencia In')
oModel:GetModel('ZZI_IN_G'):SetDescription('Transferencia In')
oModel:GetModel('ZZI_OUT'):SetDescription('Transferencia Out')
oModel:GetModel('ZZI_OUT_G'):SetDescription('Transferencia Out')
oModel:GetModel('ZZB_GDC'):SetDescription('Pre-Pedido')
Return oModel


Static Function ViewDef()
Local oView    := Nil
Local oModel   := FWLoadModel('GDC_MVC')
Local oSetSA1  := FWFormStruct(2, 'SA1')
Local oSetZZF  := FWFormStruct(2, 'ZZF')
Local oSetZZB  := FWFormStruct(2, 'ZZB')
Local oSetZZG  := FWFormStruct(2, 'ZZG')
Local oSetZZH  := FWFormStruct(2, 'ZZH')
Local oSetZZI  := FWFormStruct(2, 'ZZI')
Local oSetZZJ  := FWFormStruct(2, 'ZZJ')
Local oSetTot1 := FWCalcStruct(oModel:GetModel('TOT_CONTRA'))
Local oSetTot2 := FWCalcStruct(oModel:GetModel('TOT_ADITIVO'))
Local oSetTot3 := FWCalcStruct(oModel:GetModel('TOT_MEDICAO'))
Local oSetTot4 := FWCalcStruct(oModel:GetModel('TOT_TRF_IN'))
Local oSetTot5 := FWCalcStruct(oModel:GetModel('TOT_TRF_OUT'))
Local oSetTot6 := FWCalcStruct(oModel:GetModel('TOT_ESTORNO'))
     
oView := FWFormView():New()
oView:SetModel(oModel)

oView:AddField('VIEW_SA1'   	,oSetSA1,'SA1_GDC')
oView:AddGrid('VIEW_ZZF'    	,oSetZZF,'ZZB_ZZF')
oView:AddGrid('VIEW_ZZF_G'  	,oSetZZF,'ZZB_ZZF')
oView:AddGrid('VIEW_ZZG'    	,oSetZZG,'ZZB_ZZG')
oView:AddGrid('VIEW_ZZG_G'   	,oSetZZG,'ZZB_ZZG_G')
oView:AddGrid('VIEW_ZZH'    	,oSetZZH,'ZZB_ZZH')
oView:AddGrid('VIEW_ZZH_G'    	,oSetZZH,'ZZB_ZZH_G')
oView:AddGrid('VIEW_ZZJ'    	,oSetZZJ,'ZZB_ZZJ')
oView:AddGrid('VIEW_ZZJ_G'    	,oSetZZJ,'ZZB_ZZJ_G')
oView:AddGrid('VIEW_ZZI_IN' 	,oSetZZI,'ZZI_IN')
oView:AddGrid('VIEW_ZZI_IN_G' 	,oSetZZI,'ZZI_IN_G')
oView:AddGrid('VIEW_ZZI_OUT'	,oSetZZI,'ZZI_OUT')
oView:AddGrid('VIEW_ZZI_OUT_G'	,oSetZZI,'ZZI_OUT_G')
oView:AddGrid('VIEW_ZZB'    	,oSetZZB,'ZZB_GDC')
oView:AddField('VIEW_TOT_1'		,oSetTot1,'TOT_CONTRA')
oView:AddField('VIEW_TOT_2'		,oSetTot2,'TOT_ADITIVO')
oView:AddField('VIEW_TOT_3'		,oSetTot3,'TOT_MEDICAO')
oView:AddField('VIEW_TOT_4'		,oSetTot4,'TOT_TRF_IN')
oView:AddField('VIEW_TOT_5'		,oSetTot5,'TOT_TRF_OUT')
oView:AddField('VIEW_TOT_6'		,oSetTot6,'TOT_ESTORNO')

oView:CreateHorizontalBox( 'CABEC', 20)
oView:CreateHorizontalBox( 'ROW1', 73)
oView:CreateHorizontalBox( 'ROW2', 07)

oView:CreateFolder( 'FOLDER', 'ROW1')
oView:AddSheet('FOLDER','ABA01','Todos')
oView:AddSheet('FOLDER','ABA02','Contrato')
oView:AddSheet('FOLDER','ABA03','Aditivo')
oView:AddSheet('FOLDER','ABA04','Medição')
oView:AddSheet('FOLDER','ABA05','Transferencia')
oView:AddSheet('FOLDER','ABA06','Transferencia')
oView:AddSheet('FOLDER','ABA07','Estorno')
oView:AddSheet('FOLDER','ABA08','Outros')

oView:CreateHorizontalBox( 'BOXFORM1_ROW1', 34, , , 'FOLDER', 'ABA01')
oView:CreateHorizontalBox( 'BOXFORM1_ROW2', 33, , , 'FOLDER', 'ABA01')
oView:CreateHorizontalBox( 'BOXFORM1_ROW3', 33, , , 'FOLDER', 'ABA01')
oView:CreateHorizontalBox( 'BOXFORM2', 100, , , 'FOLDER', 'ABA02')
oView:CreateHorizontalBox( 'BOXFORM3', 100, , , 'FOLDER', 'ABA03')
oView:CreateHorizontalBox( 'BOXFORM4', 100, , , 'FOLDER', 'ABA04')
oView:CreateHorizontalBox( 'BOXFORM5', 100, , , 'FOLDER', 'ABA05')
oView:CreateHorizontalBox( 'BOXFORM6', 100, , , 'FOLDER', 'ABA06')
oView:CreateHorizontalBox( 'BOXFORM7', 100, , , 'FOLDER', 'ABA07')
oView:CreateHorizontalBox( 'BOXFORM8', 100, , , 'FOLDER', 'ABA08')

oView:CreateVerticalBox('BOXFORM_C0L1_ROW1',50,'BOXFORM1_ROW1',,'FOLDER', 'ABA01')
oView:CreateVerticalBox('BOXFORM_C0L2_ROW1',50,'BOXFORM1_ROW1',,'FOLDER', 'ABA01')
oView:CreateVerticalBox('BOXFORM_C0L1_ROW2',50,'BOXFORM1_ROW2',,'FOLDER', 'ABA01')
oView:CreateVerticalBox('BOXFORM_C0L2_ROW2',50,'BOXFORM1_ROW2',,'FOLDER', 'ABA01')
oView:CreateVerticalBox('BOXFORM_C0L1_ROW3',50,'BOXFORM1_ROW3',,'FOLDER', 'ABA01')
oView:CreateVerticalBox('BOXFORM_C0L2_ROW3',50,'BOXFORM1_ROW3',,'FOLDER', 'ABA01')

oView:CreateVerticalBox('TOT_COL1',16.66,'ROW2')
oView:CreateVerticalBox('TOT_COL2',16.67,'ROW2')
oView:CreateVerticalBox('TOT_COL3',16.67,'ROW2')
oView:CreateVerticalBox('TOT_COL4',16.67,'ROW2')
oView:CreateVerticalBox('TOT_COL5',16.67,'ROW2')
oView:CreateVerticalBox('TOT_COL6',16.66,'ROW2')

oView:SetOwnerView('VIEW_SA1'   ,'CABEC')
oView:SetOwnerView('VIEW_TOT_1'	,'TOT_COL1')
oView:SetOwnerView('VIEW_TOT_2'	,'TOT_COL2')
oView:SetOwnerView('VIEW_TOT_3'	,'TOT_COL3')
oView:SetOwnerView('VIEW_TOT_4'	,'TOT_COL4')
oView:SetOwnerView('VIEW_TOT_5'	,'TOT_COL5')
oView:SetOwnerView('VIEW_TOT_6'	,'TOT_COL6')

oView:SetOwnerView('VIEW_ZZF_G'   	,'BOXFORM_C0L1_ROW1')
oView:SetOwnerView('VIEW_ZZG_G'   	,'BOXFORM_C0L2_ROW1')
oView:SetOwnerView('VIEW_ZZH_G'   	,'BOXFORM_C0L1_ROW2')
oView:SetOwnerView('VIEW_ZZJ_G'   	,'BOXFORM_C0L2_ROW2')
oView:SetOwnerView('VIEW_ZZI_IN_G' ,'BOXFORM_C0L1_ROW3')
oView:SetOwnerView('VIEW_ZZI_OUT_G','BOXFORM_C0L2_ROW3')

oView:SetOwnerView('VIEW_ZZF'    	,'BOXFORM2')
oView:SetOwnerView('VIEW_ZZG'    	,'BOXFORM3')
oView:SetOwnerView('VIEW_ZZH'    	,'BOXFORM4')
oView:SetOwnerView('VIEW_ZZI_IN'   ,'BOXFORM5')
oView:SetOwnerView('VIEW_ZZI_OUT'  ,'BOXFORM6')
oView:SetOwnerView('VIEW_ZZJ'    	,'BOXFORM7')
oView:SetOwnerView('VIEW_ZZB'    	,'BOXFORM8')
     
oView:EnableTitleView('VIEW_ZZF'    	,'Contrato')
oView:EnableTitleView('VIEW_ZZF_G'    	,'Contrato')
oView:EnableTitleView('VIEW_ZZG'    	,'Aditivos')
oView:EnableTitleView('VIEW_ZZG_G'    	,'Aditivos')
oView:EnableTitleView('VIEW_ZZH'    	,'Mediçoes')
oView:EnableTitleView('VIEW_ZZH_G'    	,'Mediçoes')
oView:EnableTitleView('VIEW_ZZJ'    	,'Estorno')
oView:EnableTitleView('VIEW_ZZJ_G'    	,'Estorno')
oView:EnableTitleView('VIEW_ZZI_IN' 	,'Transferencia In')
oView:EnableTitleView('VIEW_ZZI_IN_G' 	,'Transferencia In')
oView:EnableTitleView('VIEW_ZZI_OUT'	,'Transferencia Out')
oView:EnableTitleView('VIEW_ZZI_OUT_G'	,'Transferencia Out')
oView:EnableTitleView('VIEW_ZZB'    	,'Pre-Pedio')

oView:SetViewProperty("VIEW_ZZF"		, "ENABLENEWGRID")
//oView:SetViewProperty("VIEW_ZZF_G"		, "ENABLENEWGRID")
oView:SetViewProperty("VIEW_ZZG"		, "ENABLENEWGRID")
//oView:SetViewProperty("VIEW_ZZG_G"		, "ENABLENEWGRID")
oView:SetViewProperty("VIEW_ZZH"		, "ENABLENEWGRID")
//oView:SetViewProperty("VIEW_ZZH_G"		, "ENABLENEWGRID")
//oView:SetViewProperty("VIEW_ZZI_IN_G"	, "ENABLENEWGRID")
oView:SetViewProperty("VIEW_ZZI_IN"	, "ENABLENEWGRID")
oView:SetViewProperty("VIEW_ZZI_OUT"	, "ENABLENEWGRID")
//oView:SetViewProperty("VIEW_ZZI_OUT_G"	, "ENABLENEWGRID")
oView:SetViewProperty("VIEW_ZZJ"		, "ENABLENEWGRID")
//oView:SetViewProperty("VIEW_ZZJ_G"		, "ENABLENEWGRID")


oView:SetViewProperty("VIEW_ZZF"		, "GRIDFILTER", {.T.}) 
oView:SetViewProperty("VIEW_ZZG"		, "GRIDFILTER", {.T.})
oView:SetViewProperty("VIEW_ZZH"		, "GRIDFILTER", {.T.})
oView:SetViewProperty("VIEW_ZZI_IN"	, "GRIDFILTER", {.T.})
oView:SetViewProperty("VIEW_ZZI_OUT"	, "GRIDFILTER", {.T.})
oView:SetViewProperty("VIEW_ZZJ"		, "GRIDFILTER", {.T.})

oView:SetViewProperty("VIEW_ZZF", "GRIDDOUBLECLICK", {{|oFormulario,cFieldName,nLineGrid,nLineModel| MyDoubleClick(oFormulario,cFieldName,nLineGrid,nLineModel)}}) 

oView:AddUserButton("Cancelar","MAGIC_BMP",{|| GDCFUNCTION('4',oView)},"Cancela proposta")
oView:AddUserButton("Liberar","MAGIC_BMP",{|| GDCFUNCTION('3',oView)},"Libera Contrato/Aditivo")
oView:AddUserButton("Transferência de saldo","MAGIC_BMP",{|| U_GDCXTRF(oView)},"Transferência de saldo")

oView:SetProgressBar(.T.)

Return oView

Static Function MyDoubleClick(oFormulario,cFieldName,nLineGrid,nLineModel)
/*ALERT("cFieldName - "+cFieldName)
ALERT("nLineGrid - "+Alltrim(str(nLineGrid)))
alert("nLineModel - " + Alltrim(str(nLineModel)))
alert(OFORMULARIO:OBROWSE:ODATA:ASHOW[nLineGrid][ASCAN(oFormulario:aFieldId,{|x| Upper(Alltrim(x))=="ZZF_NUMERO"})])
*/

cCampanha:= OFORMULARIO:OBROWSE:ODATA:ASHOW[nLineGrid][ASCAN(oFormulario:aFieldId,{|x| Upper(Alltrim(x))=="ZZF_NUMERO"})]
cCliente := OFORMULARIO:OBROWSE:ODATA:ASHOW[nLineGrid][ASCAN(oFormulario:aFieldId,{|x| Upper(Alltrim(x))=="ZZF_CLIENT"})]
cLoja	  := OFORMULARIO:OBROWSE:ODATA:ASHOW[nLineGrid][ASCAN(oFormulario:aFieldId,{|x| Upper(Alltrim(x))=="ZZF_LOJACL"})]
cAliasCtr:= SubStr(cFieldName,1,3)
Return .T.

User Function GDCPRINT()
Local oReport
Local cPerg := "GDC_REL"
AjustaSX1(cPerg)
If TRepInUse()	//verifica se relatorios personalizaveis esta disponivel	
	Pergunte(cPerg,.F.)	
	oReport := ReportDef(cPerg)	
	oReport:PrintDialog()	
EndIf
	
Return Nil

Static Function ReportDef(cPerg)
Local oReport
Local oSection1
Local oSection11
Local oSection12
Local oSection2
Local cNumPict := X3Picture("ZZB_PARC1")

oReport := TReport():New("GDC","Movimento GDC",cPerg,{|oReport| PrintReport(oReport)},"Este relatorio ira imprimir o movimento com seus totais do GDC.")
oReport:SetLandScape(.T.)
oReport:DisableOrientation()
oReport:SetTotalInLine(.F.)


oSection1 := TRSection():New(oReport,"Campanha",{"ZZB","ZZF","SA1"})
oSection1:SetHeaderPage(.T.)
TRCell():New(oSection1,"ZZF_NUMERO","ZZF",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| Iif(MV_PAR07 == 1,(_cAlias)->ZZF_NUMERO,"") })
TRCell():New(oSection1,"ZZF_CAMPAN","ZZF",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| Iif(MV_PAR07 == 1,(_cAlias)->ZZF_CAMPAN,"") })
TRCell():New(oSection1,"ZZB_CLIENT","ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ZZB_CLIENT})
TRCell():New(oSection1,"ZZB_LOJACL","ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ZZB_LOJACL})
TRCell():New(oSection1,"A1_NOME"	,"SA1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->A1_NOME})

oSection11 := TRSection():New(oSection1,"Movimento",{"ZZB","ZZF","ZZG","ZZH","ZZI","ZZJ"})
oSection11:SetHeaderPage(.T.)

//TRCell():New(oSection11,"ZZB_TPINST","ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ZZB_TPINST})
TRCell():New(oSection11,"ZZB_DATA"	,"ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| SToD((_cAlias)->ZZB_DATA)})
TRCell():New(oSection11,"ZZB_SERIE","ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ZZB_SERIE})
TRCell():New(oSection11,"ZZB_TPVEND","ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ZZB_TPVEND})
TRCell():New(oSection11,"ZZB_PEDWEB","ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ZZB_PEDWEB})
TRCell():New(oSection11,"NVALCONTRA","ZZB","Contrato"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->CONTRATO },"RIGHT",,"RIGHT")
TRCell():New(oSection11,"NVALADITIVO","ZZB","Aditivo"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ADITIVO},"RIGHT",,"RIGHT")
TRCell():New(oSection11,"NVALMEDICAO","ZZB","Medicao"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->MEDICAO},"RIGHT",,"RIGHT")
TRCell():New(oSection11,"NVALTRANSFO","ZZB","Transfere Out"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->TRANSF_OUT},"RIGHT",,"RIGHT")
TRCell():New(oSection11,"NVALTRANSFI","ZZB","Transfere In"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->TRANSF_IN},"RIGHT",,"RIGHT")
TRCell():New(oSection11,"NVALESTORN","ZZB","Estorno"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ESTORNO},"RIGHT",,"RIGHT")
TRCell():New(oSection11,"NVALSALDO","ZZB","Saldo"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nValSaldo },"RIGHT",,"RIGHT")

TRFunction():New(oSection11:Cell("NVALCONTRA"),"NTOTCONTRA","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection11:Cell("NVALADITIVO"),"NTOTADITIVO","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection11:Cell("NVALMEDICAO"),"NTOTMEDICAO","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection11:Cell("NVALTRANSFO"),"NTOTTRANSFO","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection11:Cell("NVALTRANSFI"),"NTOTTRANSFI","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection11:Cell("NVALESTORN"),"NTOTESTORN","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)

oSection11:SetTotalInLine(.F.)

oReport:GetFunction("NTOTCONTRA"):SetEndReport(.F.)
oReport:GetFunction("NTOTADITIVO"):SetEndReport(.F.)
oReport:GetFunction("NTOTMEDICAO"):SetEndReport(.F.)
oReport:GetFunction("NTOTTRANSFO"):SetEndReport(.F.)
oReport:GetFunction("NTOTTRANSFI"):SetEndReport(.F.)
oReport:GetFunction("NTOTESTORN"):SetEndReport(.F.)

oSection12 := TRSection():New(oSection1,"Saldo",{"ZZB","ZZF","ZZG","ZZH","ZZI","ZZJ"})
oSection12:SetHeaderPage(.T.)
TRCell():New(oSection12,"ZZB_TPVEND","ZZB",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| Iif(MV_PAR07 == 1,(_cAlias)->ZZB_TPVEND,"") })
TRCell():New(oSection12,"NVALCONTRA","ZZB","Contrato"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->CONTRATO },"RIGHT",,"RIGHT")
TRCell():New(oSection12,"NVALADITIVO","ZZB","Aditivo"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ADITIVO},"RIGHT",,"RIGHT")
TRCell():New(oSection12,"NVALMEDICAO","ZZB","Medicao"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->MEDICAO},"RIGHT",,"RIGHT")
TRCell():New(oSection12,"NVALTRANSFO","ZZB","Transfere Out"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->TRANSF_OUT},"RIGHT",,"RIGHT")
TRCell():New(oSection12,"NVALTRANSFI","ZZB","Transfere In"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->TRANSF_IN},"RIGHT",,"RIGHT")
TRCell():New(oSection12,"NVALESTORN","ZZB","Estorno"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| (_cAlias)->ESTORNO},"RIGHT",,"RIGHT")
TRCell():New(oSection12,"NVALSALDO","ZZB","Saldo"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{||  (_cAlias)->SALDO},"RIGHT",,"RIGHT")

TRFunction():New(oSection12:Cell("NVALCONTRA"),"NSALCONTRA","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection12:Cell("NVALADITIVO"),"NSALADITIVO","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection12:Cell("NVALMEDICAO"),"NSALMEDICAO","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection12:Cell("NVALTRANSFO"),"NSALTRANSFO","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection12:Cell("NVALTRANSFI"),"NSALTRANSFI","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)
TRFunction():New(oSection12:Cell("NVALESTORN"),"NSALESTORN","SUM"/*cFunction*/,/*oBreak*/,/*cTitle*/,cNumPict/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/)

oSection12:SetTotalInLine(.F.)

oReport:GetFunction("NTOTCONTRA"):SetEndSection(.T.)
oReport:GetFunction("NTOTADITIVO"):SetEndSection(.T.)
oReport:GetFunction("NTOTMEDICAO"):SetEndSection(.T.)
oReport:GetFunction("NTOTTRANSFO"):SetEndSection(.T.)
oReport:GetFunction("NTOTTRANSFI"):SetEndSection(.T.)
oReport:GetFunction("NTOTESTORN"):SetEndSection(.T.)

oReport:GetFunction("NSALCONTRA"):SetEndReport(.F.)
oReport:GetFunction("NSALADITIVO"):SetEndReport(.F.)
oReport:GetFunction("NSALMEDICAO"):SetEndReport(.F.)
oReport:GetFunction("NSALTRANSFO"):SetEndReport(.F.)
oReport:GetFunction("NSALTRANSFI"):SetEndReport(.F.)
oReport:GetFunction("NSALESTORN"):SetEndReport(.F.)

oSection2 := TRSection():New(oReport,"Total Geral")
TRCell():New(oSection2,"NTOTALCTA",,"Total Contratos"/*Titulo*/	,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nTotalCTA},"RIGHT",,"RIGHT")
TRCell():New(oSection2,"NTOTALADT",,"Total Aditivo"/*Titulo*/		,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nTotalADT},"RIGHT",,"RIGHT")
TRCell():New(oSection2,"NTOTALMED",,"Total Medicao"/*Titulo*/		,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nTotalMED},"RIGHT",,"RIGHT")
TRCell():New(oSection2,"NTOTALTRFO",,"Total Transf. Saida"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nTotalTRFO},"RIGHT",,"RIGHT")
TRCell():New(oSection2,"NTOTALTRFI",,"Total Transf. Entrada"/*Titulo*/,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nTotalTRFI},"RIGHT",,"RIGHT")
TRCell():New(oSection2,"NTOTALEST",,"Total Estorno"/*Titulo*/		,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nTotalEST},"RIGHT",,"RIGHT")
TRCell():New(oSection2,"NTOTALSLD",,"Total do Saldo em Capanha"/*Titulo*/	,cNumPict/*Picture*/,25/*Tamanho*/,/*lPixel*/,/*CodeBlock*/{|| nTotalCTA+nTotalADT+nTotalEST-nTotalMED},"RIGHT",,"RIGHT")

Return oReport

Static Function PrintReport(oReport)
Local oSection1 	:= oReport:Section(1)
Local oSection11	:= oReport:Section(1):Section(1)
Local oSection12	:= oReport:Section(1):Section(2)
Local oSection2 	:= oReport:Section(2)
Local oSectionD 
Local cQuery 		:= ""
Local _cNumero 	:= ""
Local _cCampanha 	:= ""
Local _cCliente 	:= ""
Local _cLoja 		:= ""
Local lPrint 		:= .F.
Local nRecCount 	:= 0
Local cFlagZZF 	:= IF(MV_PAR08==1,"3","4")
Local cFlag		:= IF(MV_PAR08==1,"='3' "," NOT IN('1','2') ")
Local cFlagZZB	:= IF(MV_PAR08==1,"='5' "," NOT IN('1','2','3') ")

PRIVATE _cAlias := GetNextAlias()
PRIVATE nTotalCTA := 0
PRIVATE nTotalADT := 0
PRIVATE nTotalMED := 0
PRIVATE nTotalTRFO:= 0
PRIVATE nTotalTRFI:= 0
PRIVATE nTotalEST := 0
PRIVATE nValSaldo := 0

oSectionD := If(MV_PAR06==1, oSection11, oSection12)
If(MV_PAR06==1, oSection12:Disable(), oSection11:Disable())

If MV_PAR07 == 2
	oSection1:Cell("ZZF_NUMERO"):Disable()
	oSection1:Cell("ZZF_CAMPAN"):Disable()
EndIf

cQuery := " SELECT "

If MV_PAR06 == 2

	If MV_PAR07 == 1//1=Campanha - 2=Cliente
		cQuery += " ZZF_NUMERO,ZZF_CAMPAN,ZZB_TPVEND, A1_NOME,ZZB_CLIENT,ZZB_LOJACL "
		cQuery += " , SUM(ISNULL([1],0)) AS CONTRATO,  SUM(ISNULL([2],0)) AS ADITIVO,  SUM(ISNULL([3],0)) AS MEDICAO,  SUM(ISNULL([4_O],0)) AS TRANSF_OUT,  SUM(ISNULL([4_I],0)) AS TRANSF_IN, SUM(ISNULL([5],0)) AS ESTORNO "
		cQuery += " , ROUND(SUM(ISNULL([1],0))+SUM(ISNULL([2],0))-SUM(ISNULL([3],0))-SUM(ISNULL([4_O],0))+SUM(ISNULL([4_I],0))+SUM(ISNULL([5],0)),3) AS SALDO "
	Else
		cQuery += " A1_NOME,ZZB_CLIENT,ZZB_LOJACL, "
		cQuery += " SUM(ISNULL([1],0)) AS CONTRATO, "
		cQuery += " SUM(ISNULL([2],0)) AS ADITIVO, "
		cQuery += " SUM(ISNULL([3],0)) AS MEDICAO, "
		cQuery += " SUM(ISNULL([4_O],0)) AS TRANSF_OUT, "
		cQuery += " SUM(ISNULL([4_I],0)) AS TRANSF_IN, "
		cQuery += " SUM(ISNULL([5],0)) AS ESTORNO, "
		cQuery += " ROUND(SUM(ISNULL([1],0))+SUM(ISNULL([2],0))-SUM(ISNULL([3],0))-SUM(ISNULL([4_O],0))+SUM(ISNULL([4_I],0))+SUM(ISNULL([5],0)),3) AS SALDO "
	EndIf

Else 
	cQuery += " ZZF_NUMERO,ZZF_CAMPAN,ZZB_TPVEND, A1_NOME,ZZB_CLIENT,ZZB_LOJACL,ZZB_DATA,ZZB_SERIE,ZZB_PEDWEB,TIPO "
	cQuery += " , ISNULL([1],0) AS CONTRATO,  ISNULL([2],0) AS ADITIVO,  ISNULL([3],0) AS MEDICAO,  ISNULL([4_O],0) AS TRANSF_OUT,  ISNULL([4_I],0) AS TRANSF_IN, ISNULL([5],0) AS ESTORNO "
	cQuery += " , ROUND(ISNULL([1],0)+ISNULL([2],0)-ISNULL([3],0)-ISNULL([4_O],0)+ISNULL([4_I],0)+ISNULL([5],0),3) AS SALDO "
EndIf
cQuery += " FROM (SELECT  A1_COD,A1_LOJA,A1_NOME,ZZF_NUMERO,ZZB_TPINST,ZZB_PARC1,ZZF_CAMPAN,ZZB_TPVEND,ZZB_CLIENT,ZZB_LOJACL,ZZB_DATA,ZZB_SERIE,ZZB_PEDWEB,ZZB_TPINST TIPO "
cQuery += " FROM ( "
cQuery += " SELECT ZZF_NUMERO,ZZF_CAMPAN,'' ZZG_NUMERO, '' ZZH_NUMERO, '' ZZI_NUMORI,'' ZZI_NUMDES,'' ZZJ_NUMERO,ZZB_TPINST,ZZB_DATA,ZZB_SERIE,ZZB_TPVEND,ZZB_PEDWEB,ZZF_VALOR ZZB_PARC1,ZZB_CLIENT,ZZB_LOJACL
cQuery += " FROM " + RetSqlName("ZZB") + " ZZB
cQuery += " JOIN " + RetSqlName("ZZC") + " ZZC ON()
cQuery += " JOIN " + RetSqlName("ZZF") + " ZZF ON(ZZF.D_E_L_E_T_='' AND ZZF_NUM=ZZB_CONTRA AND ZZF_CLIENT=ZZB_CLIENT AND ZZF_LOJACL=ZZB_LOJACL AND ZZB_TPINST='1' "
cQuery += " AND ZZF_FLAG='" + cFlagZZF + "' "
cQuery += if(Empty(MV_PAR03),''," AND ZZF_CLIENT='" + Alltrim(MV_PAR03) + "' ")
cQuery += if(Empty(MV_PAR04),''," AND ZZF_LOJACL='" + Alltrim(MV_PAR04) + "' ")
cQuery += if(Empty(MV_PAR05),''," AND ZZF_NUMERO='" + Alltrim(MV_PAR05) + "' ")
cQuery += " ) "
cQuery += " WHERE ZZB.D_E_L_E_T_='' AND ZZB_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' "
cQuery += " AND ZZB_FLAG"+ cFlagZZB
cQuery += " UNION ALL
cQuery += " SELECT ZZF_NUMERO,ZZF_CAMPAN,ZZG_NUMERO,'' ZZH_NUMERO,'' ZZI_NUMORI,'' ZZI_NUMDES,'' ZZJ_NUMERO,ZZB_TPINST ,ZZB_DATA,ZZB_SERIE,ZZB_TPVEND,ZZB_PEDWEB,ZZG_VALOR ZZB_PARC1,ZZB_CLIENT,ZZB_LOJACL
cQuery += " FROM " + RetSqlName("ZZB") + " ZZB
cQuery += " JOIN " + RetSqlName("ZZG") + " ZZG ON(ZZG.D_E_L_E_T_='' AND ZZG_NUM=ZZB_CONTRA AND ZZG_CLIENT=ZZB_CLIENT AND ZZG_LOJACL=ZZB_LOJACL AND ZZB_TPINST='2' "
cQuery += " AND ZZG_FLAG"+ cFlag
cQuery += if(Empty(MV_PAR03),''," AND ZZG_CLIENT='" + Alltrim(MV_PAR03) + "' ")
cQuery += if(Empty(MV_PAR04),''," AND ZZG_LOJACL='" + Alltrim(MV_PAR04) + "' ")
cQuery += if(Empty(MV_PAR05),''," AND ZZG_NUMERO='" + Alltrim(MV_PAR05) + "' ")
cQuery += " ) "
cQuery += " JOIN " + RetSqlName("ZZF") + " ZZF ON(ZZF.D_E_L_E_T_='' AND ZZG_NUMERO=ZZF_NUMERO AND ZZG_CLIENT=ZZF_CLIENT AND ZZG_LOJACL=ZZF_LOJACL
cQuery += " AND ZZF_FLAG='" + cFlagZZF + "' "
cQuery += ") "
cQuery += " WHERE ZZB.D_E_L_E_T_='' AND ZZB_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' "
cQuery += " AND ZZB_FLAG"+ cFlagZZB
cQuery += " UNION ALL
cQuery += " SELECT ZZF_NUMERO,ZZF_CAMPAN,'' ZZG_NUMERO,ZZH_NUMERO,'' ZZI_NUMORI,'' ZZI_NUMDES,'' ZZJ_NUMERO,ZZB_TPINST ,ZZB_DATA,ZZB_SERIE,ZZB_TPVEND,ZZB_PEDWEB,ZZH_VALOR ZZB_PARC1,ZZB_CLIENT,ZZB_LOJACL
cQuery += " FROM " + RetSqlName("ZZB") + " ZZB
cQuery += " JOIN " + RetSqlName("ZZH") + " ZZH ON(ZZH.D_E_L_E_T_='' AND ZZH_NUM=ZZB_CONTRA AND ZZH_CLIENT=ZZB_CLIENT AND ZZH_LOJACL=ZZB_LOJACL AND ZZB_TPINST='3' "
cQuery += " AND ZZH_FLAG"+ cFlag
cQuery += if(Empty(MV_PAR03),''," AND ZZH_CLIENT='" + Alltrim(MV_PAR03) + "' ")
cQuery += if(Empty(MV_PAR04),''," AND ZZH_LOJACL='" + Alltrim(MV_PAR04) + "' ")
cQuery += if(Empty(MV_PAR05),''," AND ZZH_NUMERO='" + Alltrim(MV_PAR05) + "' ")
cQuery += " ) "
cQuery += " JOIN " + RetSqlName("ZZF") + " ZZF ON(ZZF.D_E_L_E_T_='' AND ZZH_NUMERO=ZZF_NUMERO AND ZZH_CLIENT=ZZF_CLIENT AND ZZH_LOJACL=ZZF_LOJACL
cQuery += " AND ZZF_FLAG='" + cFlagZZF + "' "
cQuery += ") "
cQuery += " WHERE ZZB.D_E_L_E_T_='' AND ZZB_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' "
cQuery += " AND ZZB_FLAG"+ cFlagZZB
cQuery += " UNION ALL
cQuery += " SELECT ZZF_NUMERO,ZZF_CAMPAN,'' ZZG_NUMERO,'' ZZH_NUMERO,ZZI_NUMORI,ZZI_NUMDES,'' ZZJ_NUMERO,ZZB_TPINST+'_O' ZZB_TPINST ,ZZB_DATA,ZZB_SERIE,ZZB_TPVEND,ZZB_PEDWEB,ZZI_VALOR ZZB_PARC1,ZZB_CLIENT,ZZB_LOJACL
cQuery += " FROM " + RetSqlName("ZZB") + " ZZB
cQuery += " JOIN " + RetSqlName("ZZI") + " ZZI ON(ZZI.D_E_L_E_T_='' AND ZZI_NUM=ZZB_CONTRA AND ZZI_CLIENT=ZZB_CLIENT AND ZZI_LOJACL=ZZB_LOJACL AND ZZB_TPINST='4' "
cQuery += " AND ZZI_FLAG"+ cFlag
cQuery += if(Empty(MV_PAR03),''," AND ZZI_CLIENT='" + Alltrim(MV_PAR03) + "' ")
cQuery += if(Empty(MV_PAR04),''," AND ZZI_LOJACL='" + Alltrim(MV_PAR04) + "' ")
cQuery += if(Empty(MV_PAR05),''," AND ZZI_NUMORI='" + Alltrim(MV_PAR05) + "' ")
cQuery += " ) "
cQuery += " JOIN " + RetSqlName("ZZF") + " ZZF ON(ZZF.D_E_L_E_T_='' AND ZZI_NUMORI=ZZF_NUMERO AND ZZI_CLIENT=ZZF_CLIENT AND ZZI_LOJACL=ZZF_LOJACL
cQuery += " AND ZZF_FLAG='" + cFlagZZF + "' "
cQuery += ") "
cQuery += " WHERE ZZB.D_E_L_E_T_='' AND ZZB_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' "
cQuery += " AND ZZB_FLAG"+ cFlagZZB
cQuery += " UNION ALL
cQuery += " SELECT ZZF_NUMERO,ZZF_CAMPAN,'' ZZG_NUMERO,'' ZZH_NUMERO,ZZI_NUMORI,ZZI_NUMDES,'' ZZJ_NUMERO,ZZB_TPINST+'_I' ZZB_TPINST ,ZZB_DATA,ZZB_SERIE,ZZB_TPVEND,ZZB_PEDWEB,ZZI_VALOR ZZB_PARC1,ZZB_CLIENT,ZZB_LOJACL
cQuery += " FROM " + RetSqlName("ZZB") + " ZZB
cQuery += " JOIN " + RetSqlName("ZZI") + " ZZI ON(ZZI.D_E_L_E_T_='' AND ZZI_NUM=ZZB_CONTRA AND ZZI_CLIENT=ZZB_CLIENT AND ZZI_LOJACL=ZZB_LOJACL AND ZZB_TPINST='4' "
cQuery += " AND ZZI_FLAG"+ cFlag
cQuery += if(Empty(MV_PAR03),''," AND ZZI_CLIENT='" + Alltrim(MV_PAR03) + "' ")
cQuery += if(Empty(MV_PAR04),''," AND ZZI_LOJACL='" + Alltrim(MV_PAR04) + "' ")
cQuery += if(Empty(MV_PAR05),''," AND ZZI_NUMDES='" + Alltrim(MV_PAR05) + "' ")
cQuery += " ) "
cQuery += " JOIN " + RetSqlName("ZZF") + " ZZF ON(ZZF.D_E_L_E_T_='' AND ZZI_NUMDES=ZZF_NUMERO AND ZZI_CLIENT=ZZF_CLIENT AND ZZI_LOJACL=ZZF_LOJACL
cQuery += " AND ZZF_FLAG='" + cFlagZZF + "' "
cQuery += ") "
cQuery += " WHERE ZZB.D_E_L_E_T_='' AND ZZB_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' "
cQuery += " AND ZZB_FLAG"+ cFlagZZB
cQuery += " UNION ALL
cQuery += " SELECT ZZF_NUMERO,ZZF_CAMPAN,'' ZZG_NUMERO,'' ZZH_NUMERO,'' ZZI_NUMORI,'' ZZI_NUMDES,ZZJ_NUMERO,ZZB_TPINST ,ZZB_DATA,ZZB_SERIE,ZZB_TPVEND,ZZB_PEDWEB,ZZJ_VALOR ZZB_PARC1,ZZB_CLIENT,ZZB_LOJACL
cQuery += " FROM " + RetSqlName("ZZB") + " ZZB
cQuery += " JOIN " + RetSqlName("ZZJ") + " ZZJ ON(ZZJ.D_E_L_E_T_='' AND ZZJ_NUM=ZZB_CONTRA AND ZZJ_CLIENT=ZZB_CLIENT AND ZZJ_LOJACL=ZZB_LOJACL AND ZZB_TPINST='5' "
cQuery += " AND ZZJ_FLAG"+ cFlag
cQuery += if(Empty(MV_PAR03),''," AND ZZJ_CLIENT='" + Alltrim(MV_PAR03) + "' ")
cQuery += if(Empty(MV_PAR04),''," AND ZZJ_LOJACL='" + Alltrim(MV_PAR04) + "' ")
cQuery += if(Empty(MV_PAR05),''," AND ZZJ_NUMERO='" + Alltrim(MV_PAR05) + "' ")
cQuery += " ) "
cQuery += " JOIN " + RetSqlName("ZZF") + " ZZF ON(ZZF.D_E_L_E_T_='' AND ZZJ_NUMERO=ZZF_NUMERO AND ZZJ_CLIENT=ZZF_CLIENT AND ZZJ_LOJACL=ZZF_LOJACL
cQuery += " AND ZZF_FLAG='" + cFlagZZF + "' "
cQuery += ") "
cQuery += " WHERE ZZB.D_E_L_E_T_='' AND ZZB_DATA BETWEEN '" + DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "' "
cQuery += " AND ZZB_FLAG"+ cFlagZZB
cQuery += " ) AS TMP
cQuery += " JOIN SA1010 SA1 ON(SA1.D_E_L_E_T_='' AND A1_COD=ZZB_CLIENT AND A1_LOJA=ZZB_LOJACL)
cQuery += " ) AS TMP2 "
cQuery += " PIVOT(SUM(ZZB_PARC1) FOR ZZB_TPINST IN([1],[2],[3],[4_O],[4_I],[5])) AS PVT "

If MV_PAR06 == 2

	If MV_PAR07 == 1//1=Campanha - 2=Cliente
   		cQuery += " GROUP BY ZZF_NUMERO,ZZF_CAMPAN,ZZB_TPVEND, A1_NOME,ZZB_CLIENT,ZZB_LOJACL " 	
	 	cQuery += " ORDER BY ZZF_NUMERO,ZZB_TPVEND "	
 	Else
		cQuery += " GROUP BY A1_NOME,ZZB_CLIENT,ZZB_LOJACL "
 		cQuery += " ORDER BY A1_NOME,ZZB_CLIENT,ZZB_LOJACL "
 	EndIf

Else
	cQuery += " ORDER BY ZZB_CLIENT,ZZF_NUMERO,ZZB_DATA,TIPO,[1],[2],[3],[4_O],[4_I],[5] "
EndIf 


If Select(_cAlias) > 0
	(_cAlias)->(DbCloseArea())
EndIf

oReport:SetMeter(nRecCount)
		
dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), _cAlias, .F., .F.)
(_cAlias)->(DBGOTOP())

(_cAlias)->(DbEval({|| nRecCount++ },{|| !(_cAlias)->(Eof())}))
(_cAlias)->(DBGOTOP())

oReport:SetMeter(nRecCount)
//If(MV_PAR06==1,oSection12:Disable(),oSection11:Disable())
While !(_cAlias)->(Eof())
	If oReport:Cancel()
		Exit
	EndIf
	
	If (MV_PAR07 == 1 .And. _cNumero == (_cAlias)->ZZF_NUMERO .And. _cCampanha == (_cAlias)->ZZF_CAMPAN .And. _cCliente == (_cAlias)->ZZB_CLIENT .And. _cLoja == (_cAlias)->ZZB_LOJACL) .Or.;
		(MV_PAR07 == 2 .And. _cCliente == (_cAlias)->ZZB_CLIENT .And. _cLoja == (_cAlias)->ZZB_LOJACL)	
		nValSaldo += (_cAlias)->(CONTRATO+ADITIVO+TRANSF_IN+ESTORNO-MEDICAO-TRANSF_OUT)
		oSectionD:Init()
		oSectionD:PrintLine()
		lPrint := .T.
	Else
		If !Empty(_cNumero)
			oSectionD:Finish()
			oSection1:Finish()
			nValSaldo := 0
		EndIf

		If MV_PAR07 == 1//1=Campanha - 2=Cliente
			_cNumero := (_cAlias)->ZZF_NUMERO 
			_cCampanha := (_cAlias)->ZZF_CAMPAN 
		EndIf
		_cCliente := (_cAlias)->ZZB_CLIENT
		_cLoja := (_cAlias)->ZZB_LOJACL

		nValSaldo += (_cAlias)->(CONTRATO+ADITIVO+TRANSF_IN+ESTORNO-MEDICAO-TRANSF_OUT)

		oSection1:Init()
		oSection1:PrintLine()
		oSectionD:Init()
		oSectionD:PrintLine()
		lPrint := .T.
	EndIf
	nTotalCTA += (_cAlias)->CONTRATO
	nTotalADT += (_cAlias)->ADITIVO
	nTotalMED += (_cAlias)->MEDICAO
	nTotalTRFI+= (_cAlias)->TRANSF_IN
	nTotalTRFO+= (_cAlias)->TRANSF_OUT
	nTotalEST += (_cAlias)->ESTORNO

	oReport:IncMeter()
(_cAlias)->(DbSkip())
EndDo
oSectionD:Finish()
oSection1:Finish()
oSection2:Init()
oSection2:PrintLine()
oSection2:Finish()		

//oSection2:Disable()
If Select(_cAlias) > 0
	(_cAlias)->(DbCloseArea())
EndIf
Return


Static Function AjustaSX1(cPerg)
Local aArea   := GetArea()
Local aHelpPor:= {}
Local aHelpEng:= {}
Local aHelpSpa:= {} 

aHelpPor := {}
aAdd(aHelpPor,"Informe a data de referencia GDC.")
PutSX1(cPerg,"01","Data GDC de"		,"Data GDC de"		,"Data GDC de"		,"mv_ch1","D",8							,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
aHelpPor := {}
aAdd(aHelpPor,"Informe a data de referencia GDC.")
PutSX1(cPerg,"02","Data GDC ate"	,"Data GDC ate"		,"Data GDC ate"		,"mv_ch2","D",8							,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
aHelpPor := {}
aAdd(aHelpPor,"Informe cliente caso deseje filtrar.")
PutSX1(cPerg,"03","Cliente"			,"Cliente"			,"Cliente"			,"mv_ch3","C",TamSX3("A1_COD")[1]		,0,0,"G","","SA1","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
aHelpPor := {}
aAdd(aHelpPor,"Informe a loja do cliente caso deseje filtrar.")
PutSX1(cPerg,"04","Loja Cli."		,"Loja Cli."		,"Loja Cli."		,"mv_ch4","C",TamSX3("A1_LOJA")[1]		,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
aHelpPor := {}
aAdd(aHelpPor,"Informe o contrato caso deseje filtrar.")
PutSX1(cPerg,"05","Contrato GDC"	,"Contrato GDC"	,"Contrato GDC"	,"mv_ch5","C",TamSX3("ZZF_NUMERO")[1]	,0,0,"G","","ZZF","","","mv_par05","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
aHelpPor := {}
aAdd(aHelpPor,"Conta corrente - Analitico,")
aAdd(aHelpPor,"Saldo de campanha - Sintetico.")
PutSX1(cPerg,"06","Tipo de Rel."	,"Tipo de Rel."	,"Tipo de Rel."	,"mv_ch6","N",1,0,1,"C","","","","","mv_par06","Conta corrente","Conta corrente","Conta corrente","","Saldo campanha","Saldo campanha","Saldo campanha","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
aHelpPor := {}
aAdd(aHelpPor,"Impressao por cliente ou")
aAdd(aHelpPor,"por campanha.")
PutSX1(cPerg,"07","Tp de Agrupamento"	,"Tp de Agrupamento"	,"Tp de Agrupamento"	,"mv_ch7","N",1,0,1,"C","","","","","mv_par07","Campanha","Campanha","Campanha","","Cliente","Cliente","Cliente","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)
aHelpPor := {}
aAdd(aHelpPor,"Impressao campanhas ativa ")
aAdd(aHelpPor,"ou canceladas.")
PutSX1(cPerg,"08","Tp de Campanha"	,"Tp de Campanha"	,"Tp de Campanha"	,"mv_ch8","N",1,0,1,"C","","","","","mv_par08","Ativa","Ativa","Ativa","","Cancelada","Cancelada","Cancelada","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)


RestArea(aArea)
Return  


/*
VERSAO 11
O array aEnableButtons tem por padrão 14 posições:
1 - Copiar
2 - Recortar
3 - Colar
4 - Calculadora
5 - Spool
6 - Imprimir
7 - Confirmar
8 - Cancelar
9 - WalkTrhough
10 - Ambiente
11 - Mashup
12 - Help
13 - Formulário HTML
14 - ECM
*/
static Function GDCFUNCTION(cTipo,oView)
Local aSelect := {}
Local aAllAreas := GetAllAreas()
Local aButtons := {{.F.,Nil},{.F.,Nil},{.F.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,"Salvar"},{.T.,"Cancelar"},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil},{.T.,Nil}}
Local lRet := .T.

ZZF->(DbSetOrder(2))
If ZZF->(DbSeek(PadR(cCampanha,TamSX3("ZZF_NUMERO")[1]))) 
	If MsgYesNO("CONTRATO: "+ZZF->ZZF_NUMERO + CRLF + "Campanha: " + ZZF->ZZF_CAMPAN)
		RecLock("ZZF",.F.)
			ZZF->ZZF_FLAG := cTipo
		ZZF->(MsUnLock()) 
		
		ZZB->(DbSetOrder(4))
		If ZZB->(DbSeek(xFilial("ZZB")+ZZF->ZZF_NUM+"1")) .And. cTipo == "4"
			RecLock("ZZB",.F.)
				ZZB->ZZB_FLAG := "6"
			ZZB->(MsUnLock())	
		ElseIf ZZB->(DbSeek(xFilial("ZZB")+ZZF->ZZF_NUM+"1")) .And. cTipo == "3"
			MsgAlert("Houve algum problema na seleção do pedido do contrato."+CRLF+"Verifique se o mesmo consta como cancelado.")
		EndIf	
		//FWExecView('Cancelamento de Campanha','GDC_CANC', MODEL_OPERATION_VIEW,/*oDlg*/,/*bOk*/{|| MsgYesNo("Deseja realmente confirmar o cancelamento?")},/*nPercReducao*/,/*aEnableButtons*/,/*bCancel*/)
		
		//aSelect := oView:GetCurrentSelect()
		//alert(aSelect[1]+ CRLF + aSelect[2])
	EndIf
Else
	MsgAlert("Houve algum problema na seleção de contrato."+CRLF+"Faça a seleção novamente.")
EndIf
alert('1')
GetAllAreas(aAllAreas)
Return


Static Function Refresh(oView)
	oView:Refresh('VIEW_ZZG')
	oView:Refresh('VIEW_ZZH')
	oView:Refresh('VIEW_ZZJ')
	oView:Refresh('VIEW_ZZI_IN')
	oView:Refresh('VIEW_ZZI_OUT')
	oView:Refresh('VIEW_ZZG_G')
	oView:Refresh('VIEW_ZZH_G')
	oView:Refresh('VIEW_ZZJ_G')
	oView:Refresh('VIEW_ZZI_IN_G')
	oView:Refresh('VIEW_ZZI_OUT_G')	
Return
//---------------------------------------------------------------------------------------
/*/{Protheus.doc} GDCXTRF
Rotina de transferência de saldo entre contratos
@author  	Totvs
@since     	20/05/2017
@version  	P.11.8      
@return   	Nenhum
/*/
//---------------------------------------------------------------------------------------
User function GDCXTRF(oView)
Local oMdlAct	:= nil
Local oMdlZZBF:= nil
Local oMdlSA1G:= nil
Local cParSeqT:= ALLTRIM(GetMv("HB_SEQXTRF", .T.,"0000001"))
Local cProdTrf:= ALLTRIM(GetMv("HB_PRDXTRF", .T.,"PRCU000000000000000000000002IM"))
Local cIdeTrf := LEFT(cParSeqT,1) 					// Digito identificador
Local cSeqTrf := RIGHT(cParSeqT,LEN(cParSeqT)-1)	// Sequencial
Local lMenu	:= oView == NIL 						//Tratamento para chamada via menu
Local aParam	:= {}
Local aRet		:= {}
Local lSucesso:= .T.
Local cContOri:= SPACE(TAMSX3("ZZF_NUMERO")[1])
Local cCodxCli:= ""


IF lMenu
	cContOri:= SPACE(TAMSX3("ZZF_NUMERO")[1])
	cCodxCli:= SPACE(TAMSX3("A1_COD")[1])
ELSE
	oMdlAct	:= FWModelActive()
	oMdlZZBF	:= oMdlAct:GETMODEL("ZZB_ZZF")
	oMdlSA1G	:= oMdlAct:GETMODEL("SA1_GDC")
	cContOri	:= oMdlZZBF:GETVALUE("ZZF_NUMERO")
	cCodxCli	:= oMdlSA1G:GETVALUE("A1_COD")
	
	IF EMPTY(oMdlZZBF:GETVALUE("ZZF_NUMERO"))
		lSucesso:= .F.
		MSGALERT("O Cliente sem contrato!")
	Endif	
ENDIF
	
IF lSucesso	

	lSucesso:= .F.
	
	aAdd(aParam,{1,"Cliente",cCodxCli,"","U_VLDGDCX(0)","SA1",IF(lMenu,".T.",".F."),0,.F.})
	aAdd(aParam,{1,"Contrato origem",cContOri,"","U_VLDGDCX(1)","ZZFCLI",IF(lMenu,".T.",".F."),0,.F.})
	aAdd(aParam,{1,"Contrato Destino",SPACE(TAMSX3("ZZF_NUMERO")[1]),"","U_VLDGDCX(2)","ZZFCLI","",0,.F.}) 
	aAdd(aParam,{1,"Valor Transferência",0,PESQPICT("ZZF","ZZF_VALOR"),"U_VLDGDCX(3)","","",80,.F.})
	aAdd(aParam,{1,"Cond.Pagamento",SPACE(TAMSX3("ZZB_CONDPA")[1]),"","U_VLDGDCX(4)","SE4","",0,.F.})
	aAdd(aParam,{1,"Id Pedido",cIdeTrf + cSeqTrf,"","","",".F.",0,.F.})
	aAdd(aParam,{1,"Série NF",SPACE(TAMSX3("ZZB_SERIE")[1]),"","U_VLDGDCX(5)","01","",0,.F.})
	aAdd(aParam,{1,"Tipo Venda",SPACE(TAMSX3("ZZB_TPVEND")[1]),"","U_VLDGDCX(6)","ZZ3","",0,.F.})
	
	If ParamBox(aParam,"Transferência de saldos",@aRet)
		
		oObj:= WSWSINCPEDTR():New()
		oObj:oWSDADOSPEDIDOS:cC5BANCO  	:= ""
		oObj:oWSDADOSPEDIDOS:cC5CNLWEB	:= ""
		oObj:oWSDADOSPEDIDOS:cC5CONDPAG	:= aRet[5]	
		oObj:oWSDADOSPEDIDOS:cC5GRPWEB 	:= ""
		oObj:oWSDADOSPEDIDOS:cC5MENNOTA	:= "Transferência entre Contratos recarregável"
		oObj:oWSDADOSPEDIDOS:cC5PEDWEB 	:= aRet[6]	
		oObj:oWSDADOSPEDIDOS:cC5SERIE  	:= aRet[7]
		oObj:oWSDADOSPEDIDOS:cC5TPECOM 	:= ""
		oObj:oWSDADOSPEDIDOS:cC5TPEVEN 	:= aRet[8]
		oObj:oWSDADOSPEDIDOS:cC5XNSU  	:= ""
		
	  	oObj:oWSITENSPEDIDOS:OWSASTRITENS:= WSClassNew("WSINCPEDTR_ARRAYOFDADOSITETR") 	  	
	  	oObj:oWSITENSPEDIDOS:OWSASTRITENS:OWSDADOSITETR:={}
	  	AADD(oObj:oWSITENSPEDIDOS:OWSASTRITENS:OWSDADOSITETR,WSClassNew("WSINCPEDTR_DADOSITETR")) 
		oObj:oWSITENSPEDIDOS:OWSASTRITENS:OWSDADOSITETR[1]:nC6PRCVEN	:= aRet[4]
		oObj:oWSITENSPEDIDOS:OWSASTRITENS:OWSDADOSITETR[1]:cC6PRODUTO	:= cProdTrf
		oObj:oWSITENSPEDIDOS:OWSASTRITENS:OWSDADOSITETR[1]:nC6QTDVEN 	:= 1	
			  	
	  	oObj:oWSDADOSTRANSF:cCONTRATORI  := aRet[2]
		oObj:oWSDADOSTRANSF:cCONTRATDES  := aRet[3]	
		
		MsgRun("Processando Transferência, aguarde...","Transferência de saldos", {|| lSucesso:= oObj:PEDIDOSTR(oObj:oWSDADOSPEDIDOS,oObj:oWSITENSPEDIDOS,oObj:oWSDADOSTRANSF) })
		
		IF lSucesso
			//Atualiza parâmetro de sequência
			PUTMV("HB_SEQXTRF",cIdeTrf + SOMA1(cSeqTrf))			
			MSGINFO(	oObj:OWSPEDIDOSTRRESULT:CTRANSFPEDWEB	+ CRLF +;
						oObj:OWSPEDIDOSTRRESULT:CTRANSFSERWEB	+ CRLF +;
						oObj:OWSPEDIDOSTRRESULT:CTRANSFRESULT)					
		ELSE
			MSGALERT(PWSGetWSError())	
		ENDIF	
	Endif
ELSE
	MSGALERT("O Cliente sem contrato!")
Endif

RETURN
//---------------------------------------------------------------------------------------
/*/{Protheus.doc} TRFXVLD
Rotina de validação da tela de transferência de saldo
@author  	Totvs
@since     	20/05/2017
@version  	P.11.8      
@return   	Nenhum
/*/
//---------------------------------------------------------------------------------------
User function VLDGDCX(nValid)
Local lRet:= .T.

IF nValid == 0
	
	IF !EMPTY(MV_PAR01)
		DBSELECTAREA("SA1")
		SA1->(DBSETORDER(1))
		IF !SA1->(DBSEEK(XFILIAL("SA1")+MV_PAR01))
			lRet:= .F.
			MSGALERT("Informe um código de cliente válido!!")
		ELSE
			MV_PAR02:= SPACE(TAMSX3("ZZF_NUMERO")[1]) // Limpa contrato para nova seleção
			MV_PAR03:= SPACE(TAMSX3("ZZF_NUMERO")[1]) // Limpa contrato para nova seleção			
		ENDIF
	ENDIF
	
ELSEIF nValid == 1
	
	IF !EMPTY(MV_PAR02)
		DBSELECTAREA("ZZF")
		ZZF->(DBGOTOP())
		ZZF->(DBSETORDER(2))
		IF !ZZF->(DBSEEK(MV_PAR02))		
			lRet:= .F.
			MSGALERT("Informe um contrato válido!!")		
		ENDIF
	ENDIF
	
	IF lRet .AND. ZZF->ZZF_CLIENT != MV_PAR01
		lRet:= .F.
		MSGALERT("O contrato informado não pertence ao cliente "+MV_PAR01+"!!")
	ENDIF 	
	
ELSEIF nValid == 2

	IF !EMPTY(MV_PAR03)
		DBSELECTAREA("ZZF")
		ZZF->(DBGOTOP())
		ZZF->(DBSETORDER(2))
		IF !ZZF->(DBSEEK(MV_PAR03))
			lRet:= .F.
			MSGALERT("Informe um contrato válido!!")		
		ENDIF
	ENDIF	

	IF lRet .AND. MV_PAR02 == MV_PAR03
		lRet:= .F.
		MSGALERT("Para realizar a transferência utilizar um contrato diferente!!")
	ENDIF 	 
	
ELSEIF nValid == 3

	IF MV_PAR04 == 0
		lRet:= .F.
		MSGALERT("Informe um valor maior que zero!!")		
	ENDIF
	
ELSEIF nValid == 4

	IF !EMPTY(MV_PAR05)
		DBSELECTAREA("SE4")
		SE4->(DBSETORDER(1))
		IF !SE4->(DBSEEK(XFILIAL("SE4")+MV_PAR05))
			lRet:= .F.
			MSGALERT("Informe uma condição de pagamento válida!!")		
		ENDIF
	ENDIF
	
ELSEIF nValid == 5

	IF !EMPTY(MV_PAR07)
		DBSELECTAREA("SX5")
		SX5->(DBSETORDER(1))
		IF !SX5->(DBSEEK(XFILIAL("SX5")+"01"+MV_PAR07))
			lRet:= .F.
			MSGALERT("Informe uma série de nota válida!!")		
		ENDIF
	ENDIF	
	
ELSEIF nValid == 6

	IF !EMPTY(MV_PAR08)
		DBSELECTAREA("ZZ3")
		ZZ3->(DBSETORDER(1))
		IF !ZZ3->(DBSEEK(XFILIAL("ZZ3")+MV_PAR08))
			lRet:= .F.
			MSGALERT("Informe um tipo de venda valido!!")		
		ENDIF
	ENDIF	
	
ENDIF

RETURN lRet