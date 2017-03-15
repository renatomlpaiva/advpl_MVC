#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

User Function ALTCOR2()
Local oBrowse
Local _cAliasCab := "SA1"
Local cTitulo := ""


oBrowse := FWmBrowse():New()

oBrowse:SetAlias(_cAliasCab)

oBrowse:Activate()

Return

Static Function MenuDef()
Local aRotinas := {}

aAdd(aRotinas,{'Visualizar','VIEWDEF.ALTCOR2'	,0,MODEL_OPERATION_VIEW	 ,0,NIL})

Return aRotinas
//Return FWMVCMenu('ALTCOLOR2')


Static Function ModelDef()
    Local oModel        := Nil
    Local oStPai        := FWFormStruct(1, 'SA1')
    Local oStFilho  := FWFormStruct(1, 'SE1')
    Local aSB1Rel       := {}
     
    //Criando o modelo e os relacionamentos
    oModel := MPFormModel():New('ALTCOR2M')
    oModel:AddFields('SA1CAB',/*cOwner*/,oStPai)
    oModel:AddGrid('SE1DET','SA1CAB',oStFilho,/*bLinePre*/, /*bLinePost*/,/*bPre - Grid Inteiro*/,/*bPos - Grid Inteiro*/,/*bLoad - Carga do modelo manualmente*/)  //cOwner é para quem pertence
     
    //Fazendo o relacionamento entre o Pai e Filho
    
    aAdd(aSB1Rel, {'E1_CLIENTE','A1_COD'}) 
    aAdd(aSB1Rel, {'E1_LOJA','A1_LOJA'})
     
    oModel:SetRelation('SE1DET', aSB1Rel, SE1->(IndexKey(1))) //IndexKey -> quero a ordenação e depois filtrado
    oModel:GetModel('SE1DET'):SetUniqueLine({"E1_FILIAL","E1_PREFIXO","E1_NUM","E1_PARCELA","E1_TIPO","E1_CLIENTE","E1_LOJA"})  //Não repetir informações ou combinações {"CAMPO1","CAMPO2","CAMPOX"}
    oModel:SetPrimaryKey({})
     
    //Setando as descrições
    oModel:SetDescription("TESTE")
    oModel:GetModel('SA1CAB'):SetDescription('Cliente')
    oModel:GetModel('SE1DET'):SetDescription('Financeiro')
Return oModel


Static Function ViewDef()
    Local oView     := Nil
    Local oModel        := FWLoadModel('ALTCOR2')
    Local oStPai        := FWFormStruct(2, 'SA1')
    Local oStFilho  := FWFormStruct(2, 'SE1')
     
    //Criando a View
    oView := FWFormView():New()
    oView:SetModel(oModel)
     
    //Adicionando os campos do cabeçalho e o grid dos filhos
    oView:AddField('VIEW_SA1',oStPai,'SA1CAB')
    oView:AddGrid('VIEW_SE1',oStFilho,'SE1DET')
     
    //Setando o dimensionamento de tamanho
    oView:CreateHorizontalBox('CABEC',30)
    oView:CreateHorizontalBox('GRID',70)
     
    //Amarrando a view com as box
    oView:SetOwnerView('VIEW_SA1','CABEC')
    oView:SetOwnerView('VIEW_SE1','GRID')
    
    oView:SetViewProperty("VIEW_SE1"		, "ENABLENEWGRID")
     
    //Habilitando título
    oView:EnableTitleView('VIEW_SA1','CLIENTE')
    oView:EnableTitleView('VIEW_SE1','FINANCEIRO')
    
Return oView




