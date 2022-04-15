object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Tela de Vendas'
  ClientHeight = 496
  ClientWidth = 789
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 789
    Height = 105
    Align = alTop
    TabOrder = 0
    object Label5: TLabel
      Left = 732
      Top = 1
      Width = 56
      Height = 103
      Align = alRight
      Caption = 'Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitHeight = 19
    end
    object Label6: TLabel
      Left = 8
      Top = 2
      Width = 69
      Height = 13
      Caption = 'C'#243'digo Cliente'
    end
    object GroupBox1: TGroupBox
      Left = 7
      Top = 42
      Width = 402
      Height = 54
      Caption = 'Pedidos>'
      TabOrder = 1
      object cPedido: TComboBox
        Left = 5
        Top = 20
        Width = 108
        Height = 21
        Style = csDropDownList
        TabOrder = 0
      end
      object eNomeCliente: TEdit
        Left = 119
        Top = 19
        Width = 268
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      Left = 103
      Top = 12
      Width = 307
      Height = 38
      TabOrder = 2
      object bitBuscaPedido: TBitBtn
        Left = 1
        Top = 1
        Width = 75
        Height = 36
        Align = alLeft
        Caption = 'Busca Pedido'
        TabOrder = 0
        OnClick = bitBuscaPedidoClick
      end
      object bitGravar: TBitBtn
        Left = 76
        Top = 1
        Width = 75
        Height = 36
        Align = alLeft
        Caption = 'Gravar'
        TabOrder = 1
        OnClick = bitGravarClick
      end
      object bitCancelar: TBitBtn
        Left = 231
        Top = 1
        Width = 75
        Height = 36
        Align = alRight
        Caption = 'Cancelar'
        TabOrder = 2
        OnClick = bitcancelarClick
      end
    end
    object eCliente: TEdit
      Left = 8
      Top = 21
      Width = 89
      Height = 21
      MaxLength = 4
      TabOrder = 0
      OnChange = eClienteChange
      OnKeyPress = eClienteKeyPress
    end
  end
  object pnpDados: TPanel
    Left = 0
    Top = 105
    Width = 789
    Height = 56
    Align = alTop
    Enabled = False
    TabOrder = 1
    object Label1: TLabel
      Left = 12
      Top = 6
      Width = 50
      Height = 13
      Caption = 'Nr. Pedido'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 89
      Top = 6
      Width = 23
      Height = 13
      Caption = 'Data'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 224
      Top = 6
      Width = 33
      Height = 13
      Caption = 'Cliente'
      FocusControl = DBEdit3
    end
    object DBEdit1: TDBEdit
      Left = 8
      Top = 25
      Width = 75
      Height = 21
      Color = clBtnFace
      DataField = 'nr_pedido'
      DataSource = dsCdsPedido
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 86
      Top = 24
      Width = 134
      Height = 21
      Color = clBtnFace
      DataField = 'dt_pedido'
      DataSource = dsCdsPedido
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 223
      Top = 24
      Width = 65
      Height = 21
      Color = clBtnFace
      DataField = 'codigo_cliente'
      DataSource = dsCdsPedido
      MaxLength = 4
      TabOrder = 2
    end
    object DBEdit5: TDBEdit
      Left = 294
      Top = 24
      Width = 490
      Height = 21
      Color = clBtnFace
      DataField = 'nome'
      DataSource = dsCdsPedido
      ReadOnly = True
      TabOrder = 3
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 161
    Width = 789
    Height = 29
    Align = alTop
    Caption = 'Produtos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 218
    Width = 789
    Height = 244
    Align = alClient
    DataSource = dsCdsItemPedido
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo_produto'
        Title.Caption = 'C'#243'digo'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 148
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'qtde'
        Title.Caption = 'Qtde.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_produto'
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 98
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor_total'
        Width = 138
        Visible = True
      end>
  end
  object Panel4: TPanel
    Left = 0
    Top = 190
    Width = 789
    Height = 28
    Align = alTop
    TabOrder = 4
    object bitNovoProduto: TBitBtn
      Left = 1
      Top = 1
      Width = 32
      Height = 26
      Align = alLeft
      Caption = '+'
      TabOrder = 0
      OnClick = bitNovoProdutoClick
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 462
    Width = 789
    Height = 34
    Align = alBottom
    Enabled = False
    TabOrder = 5
    object Label4: TLabel
      Left = 607
      Top = 12
      Width = 99
      Height = 13
      Caption = 'Valor total do Pedido'
      FocusControl = DBEdit3
    end
    object DBEdit4: TDBEdit
      Left = 712
      Top = 6
      Width = 65
      Height = 21
      Color = clBtnFace
      DataField = 'valor_total'
      DataSource = dsCdsPedido
      ReadOnly = True
      TabOrder = 0
    end
  end
  object dsCdsPedido: TDataSource
    DataSet = DM.cdsPedido
    OnDataChange = dsCdsPedidoDataChange
    Left = 584
    Top = 40
  end
  object dsCdsItemPedido: TDataSource
    DataSet = DM.cdsItemPedido
    Left = 672
    Top = 41
  end
end
