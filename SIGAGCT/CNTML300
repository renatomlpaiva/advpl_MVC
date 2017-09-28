#INCLUDE "Protheus.ch"
#INCLUDE 'FWMVCDef.ch'

User Function CNTML300()
Return

Static Function ModelDef()

Return FWLoadModel("CNTA300")

Static Function ViewDef()
Local oModel			:= FWLoadModel("CNTML300")
Local oView			:= FWFormView():New()
Local oStruCN9		:= FWFormStruct(2,'CN9')
Local oStruCNC		:= FWFormStruct(2,'CNC')
Local oStruCN8		:= FWFormStruct(2,'CN8')
Local oStruCNI		:= FWFormStruct(2,'CNI')
Local oStruCNA		:= FWFormStruct(2,'CNA')
Local oStruCNB		:= FWFormStruct(2,'CNB')
Local oStruCNF		:= FWFormStruct(2,'CNF')
Local oStruCNH		:= FWFormStruct(2,'CNH')
Local oStruCNK		:= FWFormStruct(2,'CNK')
Local oStruCNX		:= FWFormStruct(2,'CNX')
Local oStruCNZ		:= FWFormStruct(2,'CNZ')
Local oStruCNS		:= FWFormStruct(2,'CNS')
Local oStruCNV		:= FWFormStruct(2,'CNV')
Local oStruCNW		:= FWFormStruct(2,'CNW')
Local oStruCNT		:= FWFormStruct(2,'CNT')
Local oStruCND		:= FWFormStruct(2,'CND')
Local oStruSC7		:= FWFormStruct(2,'SC7')
Local oStruSC5		:= FWFormStruct(2,'SC5')
Local cVisuMed       := SuperGetMV("MV_CTRMED",.F.,"1")


Local oCalcCNF 		:= FWCalcStruct(oModel:GetModel('CALC_CNF'))
Local oStruTCNS		:= FWFormViewStruct():New()
Local lFisico 		:= Cn300RetSt("FISICO",1)
Local lContab		:= Cn300RetSt("CONTABIL",1)
Local lMedeve		:= Cn300RetSt("MEDEVE",1)
Local lFixo			:= Cn300RetSt("FIXO",1)
Local lRemovCrg		:= .F.
Local lRemovCtb		:= .F.
Local lVisuCau		:= .T.
Local lVisuPla		:= .T.
Local lVisuCro		:= .T.
Local lVisuDoc		:= .T.
Local lVisuAll		:= .F.
Local cOper			:= ''

//-- Adiciona campos header do cronograma fisico
oStruTCNS:AddField("TCNS_PARC"							,;	// [01]  C   Nome do Campo
				"01"										,;	// [02]  C   Ordem
				STR0046 									,;	// [03]  C   Titulo do campo
				STR0048									,;	// [04]  C   Descricao do campo
				NIL											,;	// [05]  A   Array com Help
				"C"											,;	// [06]  C   Tipo do campo
				""											,;	// [07]  C   Picture
				NIL											,;	// [08]  B   Bloco de Picture Var
				NIL											,;	// [09]  C   Consulta F3
				.F.											,;	// [10]  L   Indica se o campo È alteravel
				NIL											,;	// [11]  C   Pasta do campo
				NIL											,;	// [12]  C   Agrupamento do campo
				NIL											,;	// [13]  A   Lista de valores permitido do campo (Combo)
				NIL											,;	// [14]  N   Tamanho maximo da maior opÁ„o do combo
				NIL											,;	// [15]  C   Inicializador de Browse
				.T.											,;	// [16]  L   Indica se o campo È virtual
				NIL											,;	// [17]  C   Picture Variavel
				NIL											)	// [18]  L   Indica pulo de linha apÛs o campo

oStruTCNS:AddField("TCNS_VTOT"							,;	// [01]  C   Nome do Campo
				"02"										,;	// [02]  C   Ordem
				STR0054	 								,;	// [03]  C   Titulo do campo
				STR0055									,;	// [04]  C   Descricao do campo
				NIL											,;	// [05]  A   Array com Help
				"N"											,;	// [06]  C   Tipo do campo
				PesqPict("CNF","CNF_VLPREV")			,;	// [07]  C   Picture
				NIL											,;	// [08]  B   Bloco de Picture Var
				NIL											,;	// [09]  C   Consulta F3
				.F.											,;	// [10]  L   Indica se o campo È alteravel
				NIL											,;	// [11]  C   Pasta do campo
				NIL											,;	// [12]  C   Agrupamento do campo
				NIL											,;	// [13]  A   Lista de valores permitido do campo (Combo)
				NIL											,;	// [14]  N   Tamanho maximo da maior opÁ„o do combo
				NIL											,;	// [15]  C   Inicializador de Browse
				.T.											,;	// [16]  L   Indica se o campo È virtual
				NIL											,;	// [17]  C   Picture Variavel
				NIL											)	// [18]  L   Indica pulo de linha apÛs o campo

//-- Adiciona campos de arrasto e redistribuiÁ„o de saldos para o cronograma cont·bil
oStruCN9:AddField("CN9_ARRASC"								,;	// [01]  C   Nome do Campo
				"01"										,;	// [02]  C   Ordem
				"Arrasto" 									,;	// [03]  C   Titulo do campo
				"Arrasto"									,;	// [04]  C   Descricao do campo
				{STR0135}									,;	// [05]  A   Array com Help
				"C"											,;	// [06]  C   Tipo do campo
				"@!"										,;	// [07]  C   Picture
				NIL											,;	// [08]  B   Bloco de Picture Var
				NIL											,;	// [09]  C   Consulta F3
				.T.											,;	// [10]  L   Indica se o campo È alteravel
				"4"											,;	// [11]  C   Pasta do campo
				"GRP4"										,;	// [12]  C   Agrupamento do campo
				{'1=Sim','2=N„o'}							,;	// [13]  A   Lista de valores permitido do campo (Combo)
				NIL											,;	// [14]  N   Tamanho maximo da maior opÁ„o do combo
				NIL											,;	// [15]  C   Inicializador de Browse
				.T.											,;	// [16]  L   Indica se o campo È virtual
				NIL											,;	// [17]  C   Picture Variavel
				NIL											)	// [18]  L   Indica pulo de linha apÛs o campo
				
oStruCN9:AddField("CN9_REDVAC"								,;	// [01]  C   Nome do Campo
				"02"										,;	// [02]  C   Ordem
				"Redist. Val." 								,;	// [03]  C   Titulo do campo
				"RedistribuiÁ„o de Valores"					,;	// [04]  C   Descricao do campo
				{STR0136} 									,;	// [05]  A   Array com Help
				"C"											,;	// [06]  C   Tipo do campo
				"@!"										,;	// [07]  C   Picture
				NIL											,;	// [08]  B   Bloco de Picture Var
				NIL											,;	// [09]  C   Consulta F3
				.T.											,;	// [10]  L   Indica se o campo È alteravel
				"4"											,;	// [11]  C   Pasta do campo
				"GRP4"										,;	// [12]  C   Agrupamento do campo
				{'1=Sim','2=N„o'}							,;	// [13]  A   Lista de valores permitido do campo (Combo)
				NIL											,;	// [14]  N   Tamanho maximo da maior opÁ„o do combo
				NIL											,;	// [15]  C   Inicializador de Browse
				.T.											,;	// [16]  L   Indica se o campo È virtual
				NIL											,;	// [17]  C   Picture Variavel
				NIL											)	// [18]  L   Indica pulo de linha apÛs o campo

//-- Monta o modelo da interface do formulario
oView:SetModel(oModel)

cOper := oModel:GetOperation()

//View do contrato
oView:AddField('VIEW_CN9',oStruCN9,'CN9MASTER')
oView:AddGrid('VIEW_CNC',oStruCNC,'CNCDETAIL')

//Array com os modelos que o usu·rio pode ver
If Len(aVldUsr) > 0
	If aVldUsr[1] == .T.
		lVisuAll	:= .T.
	Else
		If !INCLUI
			lVisuCau := .F.
			lVisuPla := .F.
			lVisuCro := .F.
			lVisuDoc := .F.
		EndIf
		aVisuAC	:= CN300VisAc()
		lVisuCau	:= aVisuAC[1]
		lVisuPla	:= aVisuAC[2]
		lVisuCro	:= aVisuAC[3]
		lVisuDoc	:= aVisuAC[4]
	EndIf
EndIf

//Bloco de AddGrid
If lVisuAll .Or. lVisuCau
	oView:AddGrid('VIEW_CN8',oStruCN8,'CN8DETAIL')
	oView:AddGrid('VIEW_CNI',oStruCNI,'CNIDETAIL')
	oView:AddGrid('VIEW_CNT',oStruCNT,'CNTDETAIL')
EndIf
If lVisuAll .Or. lVisuPla
	oView:AddGrid('VIEW_CNA',oStruCNA,'CNADETAIL')
	oView:AddGrid('VIEW_CNB',oStruCNB,'CNBDETAIL')
	If lVisuCro
		oView:AddGrid('VIEW_CNF',oStruCNF,'CNFDETAIL')
		oView:AddGrid('VIEW_CNS',oStruCNS,'CNSDETAIL')
		oView:AddGrid('VIEW_CNV',oStruCNV,'CNVDETAIL')
		oView:AddGrid('VIEW_CNW',oStruCNW,'CNWDETAIL')
	EndIf
	oView:AddGrid('VIEW_CNZ',oStruCNZ,'CNZDETAIL')
		
	If cVisuMed == "1" .Or. cVisuMed == "2"			
		oView:AddGrid('VIEW_CND',oStruCND,'CNDDETAIL')
		If CNTGetFun() <> 'CNTA301'
			oView:AddGrid('VIEW_SC7',oStruSC7,'SC7DETAIL')
		Else
			oView:AddGrid('VIEW_SC5',oStruSC5,'SC5DETAIL')	
		EndIf
	EndIf
EndIf

oView:AddGrid('VIEW_CNH',oStruCNH,'CNHDETAIL')

If lVisuAll .Or. lVisuDoc
	oView:AddGrid('VIEW_CNK',oStruCNK,'CNKDETAIL')
EndIf

oView:AddGrid('VIEW_CNX',oStruCNX,'CNXDETAIL')

//Bloco com AddField (Planilha)

If lVisuAll .Or. (lVisuPla .And. lVisuCro)
	oView:AddField('VIEW_CLC1',oCalcCNF,'CALC_CNF')
	oView:AddField('VIEW_CLC2',oStruTCNS,'CALC_CNS')
EndIf


//-- Cria as 2 divisoes da interface
oView:CreateHorizontalBox('SUPERIOR',30)
oView:CreateHorizontalBox('INFERIOR',70)

//-- Cria a pasta e planilhas da Manutencao de Contratos
oView:CreateFolder('FLDCNT','INFERIOR')

oView:AddSheet('FLDCNT','GRDFORN',STR0022)	//"Fornecedores"

// Bloco com CreateFolder, AddSheet e CreateHorizontalBox
If lVisuAll .Or. lVisuPla
	oView:AddSheet('FLDCNT','GRDPLAN',STR0024)	//"Planilhas"
EndIf

If cVisuMed == "1" .Or. cVisuMed == "2"
	oView:AddSheet('FLDCNT','GRDMED',STR0125) 	//"MediÁıes" 
EndIf	

oView:AddSheet('FLDCNT','GRDMULT',STR0025)	//"Multas/BonificaÁıes"

If lVisuAll .Or. lVisuDoc
	oView:AddSheet('FLDCNT','GRDDOC',STR0026) 		//"Documentos"
EndIf

oView:AddSheet('FLDCNT','GRDADT',STR0027) 		//"Adiantamentos"


oView:CreateHorizontalBox('FORN' ,100,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDFORN')

If lVisuAll .Or. lVisuCau
	oView:AddSheet('FLDCNT','GRDCRT',STR0028) 		//"Caucıes Retidas"
	oView:CreateHorizontalBox('CARET',100,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDCRT')
	oView:AddSheet('FLDCNT','GRDCAUC',STR0023)	//"CauÁıes"
	oView:CreateHorizontalBox('CAUCAO',100,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDCAUC')
EndIf

If lVisuAll .Or. lVisuPla
	oView:CreateHorizontalBox('PLANCAB',30,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDPLAN')
	oView:CreateHorizontalBox('PLANITS',70,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDPLAN')
EndIf

//Cria as pastas MediÁıes e Pedidos

If cVisuMed == "1" .Or. cVisuMed == "2"
	oView:CreateHorizontalBox('MEDIT',30,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDMED')
	oView:CreateHorizontalBox('PEDIDO',70,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDMED')
EndIf	

oView:CreateHorizontalBox('MULTAS',100,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDMULT')

If lVisuAll .Or. lVisuDoc
	oView:CreateHorizontalBox('DOC',100,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDDOC')
EndIf

oView:CreateHorizontalBox('ADTO',100,/*owner*/,/*lUsePixel*/,'FLDCNT','GRDADT')


If lVisuAll .Or. lVisuCau
	//-- Cria a pasta e planilhas do caucao
	oView:CreateFolder('FLDCAUC','CAUCAO')

	oView:AddSheet('FLDCAUC','GRDCAB',STR0029)	//"CauÁ„o"
	oView:AddSheet('FLDCAUC','GRDITS',STR0030)	//"Notas Fiscais"

	oView:CreateHorizontalBox('CAUCCB',100,/*owner*/,/*lUsePixel*/,'FLDCAUC','GRDCAB')
	oView:CreateHorizontalBox('CAUCIT',100,/*owner*/,/*lUsePixel*/,'FLDCAUC','GRDITS')
EndIf

//-- Cria a pasta e planilhas das Planilhas
If lVisuAll .Or. lVisuPla
	oView:CreateFolder('FLDPLAN','PLANITS')

	oView:AddSheet('FLDPLAN','ABAITS',STR0031 ) 		//"Itens"
	oView:AddSheet('FLDPLAN','ABARAT',STR0032 ) 		//"Rateio It."
	If lVisuCro
		oView:AddSheet('FLDPLAN','ABACRG',STR0033 ) 		//"Cronog. Financ."
		oView:AddSheet('FLDPLAN','ABACRF',STR0034 ) 		//"Cronog. Fisico"
		oView:AddSheet('FLDPLAN','ABACCB',STR0035 ) 		//"Cronog. Contab."
	EndIf

	oView:CreateHorizontalBox('GRDITS',100,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABAITS')
	oView:CreateHorizontalBox('GRDRAT',100,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABARAT')
	If lVisuCro
		oView:CreateHorizontalBox('GRDCLC',30,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABACRG')
		oView:CreateHorizontalBox('GRDCRG',70,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABACRG')
		oView:CreateHorizontalBox('GRDCRC',30,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABACRF')
		oView:CreateHorizontalBox('GRDCRF',70,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABACRF')
		oView:CreateHorizontalBox('GRDCTB',40,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABACCB')
		oView:CreateHorizontalBox('GRDCBI',60,/*owner*/,/*lUsePixel*/,'FLDPLAN','ABACCB')
	EndIf
If cVisuMed == "1" .Or. cVisuMed == "2"	
	oView:CreateFolder('FLDMED','PEDIDO')
	oView:AddSheet('FLDMED','ABAPED',STR0126 ) 		//"Pedidos"
	oView:CreateHorizontalBox('GRDPED',100,/*owner*/,/*lUsePixel*/,'FLDMED','ABAPED')
EndIf
EndIf

//-- Relaciona o identificador (ID) da View com o "box" para exibiÁ„o

//Bloco SetOwnerView
oView:SetOwnerView('VIEW_CN9','SUPERIOR')
oView:SetOwnerView('VIEW_CNC','FORN')
If lVisuAll .Or. lVisuCau
	oView:SetOwnerView('VIEW_CN8','CAUCCB')
	oView:SetOwnerView('VIEW_CNI','CAUCIT')
	oView:SetOwnerView('VIEW_CNT','CARET')
EndIf
If lVisuAll .Or. lVisuPla
	oView:SetOwnerView('VIEW_CNA','PLANCAB')
	oView:SetOwnerView('VIEW_CNB','GRDITS')
If cVisuMed == "1" .Or. cVisuMed == "2"	
	oView:SetOwnerView('VIEW_CND','MEDIT')
			
	If CNTGetFun() <> 'CNTA301'
				oView:SetOwnerView('VIEW_SC7','GRDPED')
			Else
				oView:SetOwnerView('VIEW_SC5','GRDPED')
	EndIf		
EndIf
	If lVisuCro
		oView:SetOwnerView('CALC_CNF','GRDCLC')
		oView:SetOwnerView('VIEW_CNF','GRDCRG')
		oView:SetOwnerView('VIEW_CNS','GRDCRF')
		oView:SetOwnerView('CALC_CNS','GRDCRC')
		oView:SetOwnerView('VIEW_CNV','GRDCTB')
		oView:SetOwnerView('VIEW_CNW','GRDCBI')
	EndIf
	oView:SetOwnerView('VIEW_CNZ','GRDRAT')
EndIf
oView:SetOwnerView('VIEW_CNH','MULTAS')

If lVisuAll .Or. lVisuDoc
	oView:SetOwnerView('VIEW_CNK','DOC')
EndIf

oView:SetOwnerView('VIEW_CNX','ADTO')


//-- Campos incrementais
//Bloco addincrementFiel
If lVisuAll .Or. lVisuPla
	oView:AddIncrementField('VIEW_CNA','CNA_NUMERO')
	oView:AddIncrementField('VIEW_CNB','CNB_ITEM')
	oView:AddIncrementField('VIEW_CNZ','CNZ_ITEM')
	oView:AddIncrementField('VIEW_CNX','CNX_NUMERO')
EndIf
//-- Remove campos que nao devem ser exibidos em tela
If !Empty(cTipRevisa) .Or. !Empty(cAprTipRev)
	oStruCN9:SetProperty('CN9_TIPREV',MVC_VIEW_ORDEM,'00')

	oStruCN9:AddGroup( "GRP1" , "Par‚metros", "" , 2 )
	oStruCN9:AddGroup( "GRP2" , "RedistribuiÁ„o de Saldo", "" , 2)
	oStruCN9:AddGroup( "GRP3" , "Reajuste", "" , 2)
	oStruCN9:AddGroup( "GRP4" , "Par‚metros Cont·bil", "" , 2 )
	oStruCN9:AddGroup( "GRP5" , "ParalisaÁ„o", "" , 2 )
	oStruCN9:AddGroup( "GRP6" , "Reinicio", "" , 2 )
Else
	oStruCN9:RemoveField("CN9_TIPREV")
EndIf

//--Remove Campos exclusivos de cada revisao.
If (cTipRevisa <> DEF_REV_REAJU .And. cAprTipRev <> DEF_REV_REAJU) .And. !(cTipRevisa == DEF_REV_REALI .And. ColumnPos('CNB_RJRTO') > 0 .And. SuperGetMV('MV_APRRETR',.F.,.F.) )		
	oStruCN9:RemoveField("CN9_DREFRJ")
	oStruCN9:RemoveField("CN9_DTREAJ")
Else
	oStruCN9:SetProperty( "CN9_DTREAJ" , MVC_VIEW_GROUP_NUMBER, "GRP3" )	
	oStruCN9:SetProperty( "CN9_DREFRJ" , MVC_VIEW_GROUP_NUMBER, "GRP3" )
EndIf
If cTipRevisa <> DEF_REV_PARAL .And. cAprTipRev <> DEF_REV_PARAL .And. ;
   cTipRevisa <> DEF_REV_REINI .And. cAprTipRev <> DEF_REV_REINI
	oStruCN9:RemoveField("CN9_MOTPAR")
	oStruCN9:RemoveField("CN9_DESMTP")
	oStruCN9:RemoveField("CN9_DTFIMP")
	oStruCN9:RemoveField("CN9_DTREIN")
Else
	oStruCN9:SetProperty( "CN9_MOTPAR" , MVC_VIEW_GROUP_NUMBER, "GRP5" )
	oStruCN9:SetProperty( "CN9_DESMTP" , MVC_VIEW_GROUP_NUMBER, "GRP5" )
	oStruCN9:SetProperty( "CN9_DTFIMP" , MVC_VIEW_GROUP_NUMBER, "GRP5" )
	oStruCN9:SetProperty( "CN9_DTREIN" , MVC_VIEW_GROUP_NUMBER, "GRP6" )
EndIf
If lMedeve .Or. (cTipRevisa <> DEF_REV_ADITI .And. cTipRevisa <> DEF_REV_REALI .And. cTipRevisa <> DEF_REV_READE .And. cTipRevisa <> DEF_REV_REINI);
			.Or. (cTipRevisa == DEF_REV_REALI .And. lFisico )
	//-- Remove Campos de RedistribuiÁ„o e Arrasto.
	oStruCN9:RemoveField("CN9_QTDPAR");oStruCN9:RemoveField("CN9_TPCRON")
	oStruCN9:RemoveField("CN9_ARRAST");oStruCN9:RemoveField("CN9_REDVAL")
	oStruCN9:RemoveField("CN9_UDMES")
	lRemovCrg := .T.
Else
	oStruCN9:SetProperty( "CN9_TPCRON" , MVC_VIEW_GROUP_NUMBER, "GRP1" )
	oStruCN9:SetProperty( "CN9_ARRAST"  , MVC_VIEW_GROUP_NUMBER, "GRP1" )
	oStruCN9:SetProperty( "CN9_REDVAL" , MVC_VIEW_GROUP_NUMBER, "GRP1" )
	oStruCN9:SetProperty( "CN9_QTDPAR" , MVC_VIEW_GROUP_NUMBER, "GRP1" )
	oStruCN9:SetProperty( "CN9_UDMES" , MVC_VIEW_GROUP_NUMBER, "GRP1" )
EndIf
If lRemovCrg .Or. lFisico
//-- RedistribuiÁ„o de Saldo
	oStruCN9:RemoveField("CN9_CSLD")
	oStruCN9:RemoveField("CN9_CPARCA");oStruCN9:RemoveField("CN9_CPARCV")
	oStruCN9:RemoveField("CN9_MPLA")
Else
	oStruCN9:SetProperty( "CN9_CSLD"  , MVC_VIEW_GROUP_NUMBER, "GRP2" )
	oStruCN9:SetProperty( "CN9_CPARCA" , MVC_VIEW_GROUP_NUMBER, "GRP2" )
	oStruCN9:SetProperty( "CN9_CPARCV" , MVC_VIEW_GROUP_NUMBER, "GRP2" )
	oStruCN9:SetProperty( "CN9_MPLA" , MVC_VIEW_GROUP_NUMBER, "GRP2" )
EndIf

If lContab .And. ( cTipRevisa == DEF_REV_ADITI .Or. cTipRevisa == DEF_REV_REALI .Or. ;
					 cTipRevisa == DEF_REV_CONTA .Or. cTipRevisa == DEF_REV_READE .Or. cTipRevisa == DEF_REV_REINI )
	oStruCN9:SetProperty( "CN9_TPCROC" , MVC_VIEW_GROUP_NUMBER, "GRP4" )
	oStruCN9:SetProperty( "CN9_QTPARC" , MVC_VIEW_GROUP_NUMBER, "GRP4" )
Else
	oStruCN9:RemoveField("CN9_ARRASC")
	oStruCN9:RemoveField("CN9_REDVAC")
	oStruCN9:RemoveField("CN9_TPCROC")
	oStruCN9:RemoveField("CN9_QTPARC")
	oStruCNA:RemoveField("CNA_SADISC")

	lRemovCtb := .T.
EndIf

If lMedeve .Or. (cTipRevisa <> DEF_REV_ADITI .And. cTipRevisa <> DEF_REV_REALI .And. cTipRevisa <> DEF_REV_READE .And.;
				   cTipRevisa <> DEF_REV_REINI) .Or. (cTipRevisa == DEF_REV_REALI .And. lFisico)
	oStruCNA:RemoveField("CNA_SADIST")
EndIf

oStruCN9:RemoveField("CN9_VLREAJ");oStruCN9:RemoveField("CN9_NUMTIT")
oStruCN9:RemoveField("CN9_VLMEAC");oStruCN9:RemoveField("CN9_TXADM")
oStruCN9:RemoveField("CN9_FORMA");oStruCN9:RemoveField("CN9_DTENTR")
oStruCN9:RemoveField("CN9_LOCENT");oStruCN9:RemoveField("CN9_CODENT")
oStruCN9:RemoveField("CN9_DESLOC");oStruCN9:RemoveField("CN9_DESFIN")
oStruCN9:RemoveField("CN9_CONTFI");oStruCN9:RemoveField("CN9_DTINPR")
oStruCN9:RemoveField("CN9_PERPRO");oStruCN9:RemoveField("CN9_UNIPRO")
oStruCN9:RemoveField("CN9_VLRPRO");oStruCN9:RemoveField("CN9_DTINCP")
oStruCN9:RemoveField("CN9_FILCTR")

oStruCNC:RemoveField("CNC_CODED");oStruCNC:RemoveField("CNC_NUMPR")
oStruCNC:RemoveField("CNC_REVISA");oStruCNC:RemoveField("CNC_CLIENT")
oStruCNC:RemoveField("CNC_LOJACL");oStruCNC:RemoveField("CNC_NOMECL")

oStruCN8:RemoveField("CN8_CONTRA");oStruCN8:RemoveField("CN8_REVISA")
oStruCN8:RemoveField("CN8_CLIENT");oStruCN8:RemoveField("CN8_LOJACL")
oStruCN8:RemoveField("CN8_NOMCLI")

oStruCNA:RemoveField("CNA_CONTRA");oStruCNA:RemoveField("CNA_REVISA")
oStruCNA:RemoveField("CNA_CRONCT");oStruCNA:RemoveField("CNA_CLIENT")
oStruCNA:RemoveField("CNA_LOJACL");oStruCNA:RemoveField("CNA_CRONOG")
oStruCNA:RemoveField("CNA_ESPEL");oStruCNA:RemoveField("CNA_DTMXMD")
oStruCNA:RemoveField("CNA_CRONCT");oStruCNA:RemoveField("CNA_VLCOMS")

oStruCNB:RemoveField("CNB_CONTRA");oStruCNB:RemoveField("CNB_NUMERO")
oStruCNB:RemoveField("CNB_REVISA");oStruCNB:RemoveField("CNB_REALI")
oStruCNB:RemoveField("CNB_DTREAL");oStruCNB:RemoveField("CNB_VLTOTR")
oStruCNB:RemoveField("CNB_DTANIV");oStruCNB:RemoveField("CNB_CONORC")
oStruCNB:RemoveField("CNB_DTCAD");oStruCNB:RemoveField("CNB_DTPREV")
oStruCNB:RemoveField("CNB_RATEIO");oStruCNB:RemoveField("CNB_TIPO")
oStruCNB:RemoveField("CNB_ITSOMA");oStruCNB:RemoveField("CNB_PERC")
oStruCNB:RemoveField("CNB_FILHO");oStruCNB:RemoveField("CNB_PRCORI")
oStruCNB:RemoveField("CNB_SLDREC");oStruCNB:RemoveField("CNB_QTDORI")
oStruCNB:RemoveField("CNB_QTRDAC");oStruCNB:RemoveField("CNB_QTRDRZ")
oStruCNB:RemoveField("CNB_QTREAD");oStruCNB:RemoveField("CNB_VLREAD")
oStruCNB:RemoveField("CNB_VLRDGL");oStruCNB:RemoveField("CNB_PERCAL")
oStruCNB:RemoveField("CNB_SLDMED");oStruCNB:RemoveField("CNB_FLGCMS")
oStruCNB:RemoveField("CNB_TS");oStruCNB:RemoveField("CNB_IDENT")

oStruCNF:RemoveField("CNF_CONTRA");oStruCNF:RemoveField("CNF_REVISA")
oStruCNF:RemoveField("CNF_MAXPAR");oStruCNF:RemoveField("CNF_PERANT")
oStruCNF:RemoveField("CNF_PERIOD");oStruCNF:RemoveField("CNF_DIAPAR")
oStruCNF:RemoveField("CNF_CONDPG");oStruCNF:RemoveField("CNF_NUMPLA")

oStruCNK:RemoveField("CNK_CONTRA");oStruCNK:RemoveField("CNK_OBS")

oStruCNX:RemoveField("CNX_NUMMED");oStruCNX:RemoveField("CNX_LOJACL")
oStruCNX:RemoveField("CNX_NUMTIT");oStruCNX:RemoveField("CNX_PREFIX")
oStruCNX:RemoveField("CNX_CLIENT");oStruCNX:RemoveField("CNX_CONTRA")

oStruCNZ:RemoveField("CNZ_CONTRA");oStruCNZ:RemoveField("CNZ_CODPLA")
oStruCNZ:RemoveField("CNZ_REVISA");oStruCNZ:RemoveField("CNZ_NUMMED")
oStruCNZ:RemoveField("CNZ_FORNEC");oStruCNZ:RemoveField("CNZ_LJFORN")
oStruCNZ:RemoveField("CNZ_CLIENT");oStruCNZ:RemoveField("CNZ_LOJACL")
oStruCNZ:RemoveField("CNZ_ITCONT");oStruCNZ:RemoveField("CNZ_VALOR1")
oStruCNZ:RemoveField("CNZ_VALOR2");oStruCNZ:RemoveField("CNZ_VALOR3")
oStruCNZ:RemoveField("CNZ_VALOR4");oStruCNZ:RemoveField("CNZ_VALOR5")

oStruCNS:RemoveField("CNS_CONTRA");oStruCNS:RemoveField("CNS_REVISA")
oStruCNS:RemoveField("CNS_CRONOG");oStruCNS:RemoveField("CNS_PLANI")
oStruCNS:RemoveField("CNS_PARCEL");oStruCNS:RemoveField("CNS_ITOR")

oStruCNV:RemoveField("CNV_CONTRA");oStruCNV:RemoveField("CNV_REVISA")
oStruCNV:RemoveField("CNV_PLANIL")

oStruCNW:RemoveField("CNW_CONTRA");oStruCNW:RemoveField("CNW_REVISA")
oStruCNW:RemoveField("CNW_NUMERO");oStruCNW:RemoveField("CNW_DTLANC")

oStruCNT:RemoveField("CNT_CONTRA");oStruCNT:RemoveField("CNT_CLIENT")
oStruCNT:RemoveField("CNT_LOJACL")

oView:AddUserButton("Aprovacao",'BUDGET', {|| a120Posic("CN9",CN9->(Recno()),2,IIF(Alltrim(CN9->CN9_SITUAC) == '09',"RV","CT"),.F.)}) //"Aprovacao"
oView:AddUserButton("Visualizar Documento",'BUDGET', {||CN300VDoc()}) //Visualiza Documento

//-- Banco de Conhecimento e Tracker
If !lAdiant
	If IsInCallStack("CN300Visua")		
		oView:AddUserButton(STR0037,'CLIPS',{|| CN300Docum()})	//-- Conhecimento
		oView:AddUserButton(STR0036,'CLIPS',{|| CN100Hist(M->CN9_NUMERO)})	//-- HistÛrico
		oView:AddUserButton(STR0038,'CLIPS',{|| StaticCall(CNTA100,CN100Track)})	//-- Tracker
	ElseIf !IsInCallStack("CN300Delet") .And. Empty(cAprTipRev)
		If !Empty(cTipRevisa) // Somente na Revisao
			If !lRemovCrg
				oView:AddUserButton('Atualizar Cronograma Financeiro/FÌsico','CLIPS',{|| CN300AtCrs(oModel)})
				If !lFisico
					oView:AddUserButton('Redistribui Saldos','CLIPS',{|| CN300RdSld(oModel)})
				EndIf
			EndIf
			If !lRemovCtb
				oView:AddUserButton('Atualizar Cronograma Cont·bil','CLIPS',{|| CN300AtCont()})
			EndIf
			If cTipRevisa == DEF_REV_REAJU
				oView:AddUserButton('Executar Reajuste','CLIPS',{|| CN300REAJU(oModel)})
			EndIf
		ElseIf !IsInCallStack('MATA161') .And. (INCLUI .Or. Empty(CN9->CN9_NUMCOT))
			oView:AddUserButton(STR0039,'CLIPS',{|| CN300Solic()}) 		//-- Importar solicitaÁıes de compra
			oView:AddUserButton(STR0040,'CLIPS',{|| CN300Solic(.T.)}) 	//-- Importar sol. de compra pro item
			oView:AddUserButton(STR0041,'CLIPS',{|| CN300PedC()}) 		//-- Copiar dados de pedidos de compra
		EndIf
		If (cTipRevisa == DEF_REV_ADITI .Or. cTipRevisa == DEF_REV_REALI .Or. cTipRevisa == DEF_REV_READE .Or. cTipRevisa == DEF_REV_REINI);
		 .Or. Empty(cTipRevisa)

			//Se a revis„o tiver cronograma ou n„o estiver fazendo uma revis„o
			If !lRemovCrg .Or. Empty(cTipRevisa)
				//Se o usu·rio pode visualizar Cronograma
				If lVisuCro
					oView:AddUserButton(STR0042,'CLIPS',{|| CN300PrCF()}) 		//-- Incluir cronograma financeiro/fÌsico
					oView:AddUserButton(STR0043,'CLIPS',{|| CN300DelCrg()}) 		//-- Excluir cronograma financeiro/fÌsico
				EndIf
			EndIf

			//Se a revis„o tiver cronograma ou n„o estiver fazendo uma revis„o
			If !lRemovCtb .Or. Empty(cTipRevisa)
				//Se o usu·rio pode visualizar Cronograma
				If lVisuCro
					oView:AddUserButton(STR0044,'CLIPS',{|| CN300PrcCC()}) 		//-- Incluir cronograma cont·bil"
					oView:AddUserButton(STR0045,'CLIPS',{|| CN300DelCtb()}) 		//-- Excluir cronograma cont·bil"
				EndIf
			EndIf
		EndIf
	EndIf
EndIf

If FunName() $ "GCPA200*GCPA300" .OR. IsInCallStack('MATA161')
	//Bloco SetProperty
	If lVisuAll .Or. lVisuPla
		oStruCNA:SetProperty('*', MVC_VIEW_CANCHANGE, .F.) 				//Desabilita os campos
		oStruCNA:SetProperty('CNA_FLREAJ', MVC_VIEW_CANCHANGE, .T.)		//Habilita o campo

		oStruCNB:SetProperty('*', MVC_VIEW_CANCHANGE, .F.) 				//Desabilita os campos
	EndIf
EndIf
If cTipRevisa == DEF_REV_REALI .And. !lFixo
	oStruCN9:SetProperty("CN9_VLATU",	MVC_VIEW_CANCHANGE,.T.)	//Habilita o campo
EndIf
If cTipRevisa == DEF_REV_ADITI
	oStruCNB:SetProperty('CNB_VLTOT',	MVC_VIEW_CANCHANGE,.F.)	//Desabilita para ediÁ„o
EndIf

//oView:SetViewProperty( 'CNADETAIL', "CHANGELINE", {{ |oView, cViewID| a300ChgLine(oView, cViewID) }} )
Return oView

