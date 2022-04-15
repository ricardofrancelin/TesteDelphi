object FPrincipalItens: TFPrincipalItens
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Itens do Pedido'
  ClientHeight = 140
  ClientWidth = 358
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 38
    Height = 13
    Caption = 'Produto'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label3: TLabel
    Left = 95
    Top = 54
    Width = 64
    Height = 13
    Caption = 'Valor Unit'#225'rio'
  end
  object Label5: TLabel
    Left = 231
    Top = 54
    Width = 51
    Height = 13
    Caption = 'Valor Total'
  end
  object Panel1: TPanel
    Left = 0
    Top = 105
    Width = 358
    Height = 35
    Align = alBottom
    TabOrder = 4
    ExplicitLeft = -8
    ExplicitTop = 100
    object bitCancela: TBitBtn
      Left = 207
      Top = 1
      Width = 75
      Height = 33
      Align = alRight
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = bitCancelaClick
      ExplicitLeft = 384
      ExplicitTop = 5
      ExplicitHeight = 25
    end
    object bitOK: TBitBtn
      Left = 282
      Top = 1
      Width = 75
      Height = 33
      Align = alRight
      Caption = 'OK'
      TabOrder = 0
      OnClick = bitOKClick
      ExplicitLeft = 283
      ExplicitTop = -5
    end
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 27
    Width = 81
    Height = 21
    DataField = 'codigo_produto'
    DataSource = FPrincipal.dsCdsItemPedido
    MaxLength = 4
    TabOrder = 0
    OnExit = DBEdit1Exit
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 73
    Width = 81
    Height = 21
    DataField = 'qtde'
    DataSource = FPrincipal.dsCdsItemPedido
    MaxLength = 3
    TabOrder = 1
  end
  object DBEdit4: TDBEdit
    Left = 95
    Top = 73
    Width = 130
    Height = 21
    Color = clBtnFace
    DataField = 'valor_produto'
    DataSource = FPrincipal.dsCdsItemPedido
    MaxLength = 10
    ReadOnly = True
    TabOrder = 2
  end
  object DBEdit6: TDBEdit
    Left = 231
    Top = 73
    Width = 119
    Height = 21
    Color = clBtnFace
    DataField = 'total_calc'
    DataSource = FPrincipal.dsCdsItemPedido
    TabOrder = 3
  end
  object DBEdit3: TDBEdit
    Left = 95
    Top = 27
    Width = 255
    Height = 21
    Color = clBtnFace
    DataField = 'DESCRICAO'
    DataSource = FPrincipal.dsCdsItemPedido
    MaxLength = 4
    ReadOnly = True
    TabOrder = 5
  end
end
