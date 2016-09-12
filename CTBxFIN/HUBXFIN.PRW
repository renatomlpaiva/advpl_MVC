#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

User Function HUBXFIN()

Local oBrowse
Local _cAliasCab := "ZZW"
Local cTitulo := "Job - Contabil x Financeiro"

oBrowse := FWmBrowse():New()

oBrowse:SetAlias(_cAliasCab)
oBrowse:SetDescription(cTitulo)

oBrowse:AddLegend("ZZW->ZZW_DTINI <= Date() .And. Date() <= ZZW->ZZW_DTFIM" +;
					" .And. ZZW->ZZW_DTULT <= Date() .And. !Empty(ZZW->ZZW_DTULT)"	,"BR_VERDE"	,"Job Ativo" )
oBrowse:AddLegend("ZZW->ZZW_DTFIM < Date()"										,"BR_VERMELHO","Job Inativo")
oBrowse:AddLegend("ZZW->ZZW_DTINI > Date()"										,"BR_AZUL"		,"Job aguardando data de inicio.")
oBrowse:AddLegend("ZZW->ZZW_DTINI <= Date() .And. Date() <= ZZW->ZZW_DTFIM " + ;
					".And. (ZZW->ZZW_DTULT > Date() .Or. Empty(ZZW->ZZW_DTULT))","BR_AMARELO"	,"Cadastro ativo, mas processo ainda não iniciado.")


oBrowse:Activate()

Return Nil


Static Function MenuDef()
Return FWMVCMenu('HUBXFIN')

Static Function ModelDef()
Local oModel   := Nil
Local oSetCab  := FWFormStruct(1, 'ZZW')
//Local oSetDet  := FWFormStruct(1, 'SA1')
//Local oSetItm  := FWFormStruct(1, 'SE1')
//Local aZZRRel  := {}
//Local aSE1Rel  := {}

     
oModel := MPFormModel():New('HUBXFIN_M',,{|oModel| HUBXFINPOS(oModel)})
oModel:AddFields('ZZWCAB',/*cOwner*/,oSetCab)

//oModel:AddGrid('ZZRDET','ZZYCAB',oSetDet,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
//oModel:AddGrid('SE1TIT','ZZRDET',oSetItm,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
     
//aAdd(aZZRRel, {'ZZR_FILIAL', 'ZZY_FILIAL'} )
//aAdd(aZZRRel, {'ZZR_NUNQTR','ZZY_NUNQTR'}) 

//aAdd(aSE1Rel, {'E1_FILIAL','xFilial("SE1")'})
//aAdd(aSE1Rel, {'E1_XNSU','ZZR_NSU'})

     
//oModel:SetRelation('ZZRDET', aZZRRel, ZZR->(IndexKey(6))) //IndexKey -> quero a ordenação e depois filtrado
//oModel:GetModel('ZZRDET'):SetUniqueLine({"ZZR_FILIAL","ZZR_LINHA"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
oModel:SetPrimaryKey({"ZZW_CONTA","ZZW_CCUSTO","ZZW_ITMCTB","ZZW_CLVL","ZZW_PREFIX","ZZW_TIPO","ZZW_CLIENT","ZZW_LOJA","ZZW_PROCES","ZZW_DTINI","ZZW_DTFIM"})

//oModel:SetRelation('SE1TIT', aSE1Rel, SE1->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
//oModel:GetModel('SE1TIT'):SetUniqueLine({"E1_XNSU","E1_PREFIXO","E1_NUM","E1_PARCELA","E1_TIPO","E1_CLIENTE","E1_LOJA"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
//oModel:SetPrimaryKey({})
     
oModel:SetDescription("Cadastro de Parametros para Job - Contabil x Financeiro")
oModel:GetModel('ZZWCAB'):SetDescription('Cabecalho')
//oModel:GetModel('ZZRDET'):SetDescription('Itens')
//oModel:GetModel('SE1TIT'):SetDescription('Titulo')
Return oModel


Static Function ViewDef()
Local oView    := Nil
Local oModel   := FWLoadModel('HUBXFIN')
Local oSetCab  := FWFormStruct(2, 'ZZW')
//Local oSetDet  := FWFormStruct(2, 'ZZR')
//Local oSetItm  := FWFormStruct(2, 'SE1')
    
oView := FWFormView():New()
oView:SetModel(oModel)
     
oView:AddField('VIEW_ZZW',oSetCab,'ZZWCAB')
//oView:AddGrid('VIEW_ZZR',oSetDet,'ZZRDET')
//oView:AddGrid('VIEW_SE1',oSetItm,'SE1TIT')


oView:CreateHorizontalBox('CABEC',100)
//oView:CreateHorizontalBox('GRID',50)
//oView:CreateHorizontalBox('TITULO',20)
     
oView:SetOwnerView('VIEW_ZZW','CABEC')
//oView:SetOwnerView('VIEW_ZZR','GRID')
//oView:SetOwnerView('VIEW_SE1','TITULO')
     
//oView:EnableTitleView('VIEW_ZZW','Cabecalho')
//oView:EnableTitleView('VIEW_ZZR','Itens')
//oView:EnableTitleView('VIEW_SE1','Titulo')
Return oView

Static Function HUBXFINPOS(oModel)
Local lRet := .T.
Local aAllAreas := GetAllArea()
ZZW->(DbSetOrder(1))
ALERT('111111111111111>>'+M->(ZZW_CONTA+ZZW_CCUSTO+ZZW_ITMCTB+ZZW_CLVL+ZZW_PREFIX+ZZW_TIPO+ZZW_CLIENT+ZZW_LOJA))
If ZZW->(DbSeek(xFilial("ZZW")+M->(ZZW_CONTA+ZZW_CCUSTO+ZZW_ITMCTB+ZZW_CLVL+ZZW_CLIENT+ZZW_LOJA+ZZW_PREFIX+ZZW_TIPO)))
ALERT('TTTTTTTTTTTTT')
	lRet := .F.
else
alert('ababafbfaba')
EndIf
GetAllArea(aAllAreas)
Return lRet
