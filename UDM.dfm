object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 297
  Width = 546
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=teste_wk_db'
      'User_Name=root'
      'Password=root'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction
    Left = 448
    Top = 80
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    VendorLib = 'C:\Users\francelin\Desktop\DelphiExe\libmysql.dll'
    Left = 448
    Top = 136
  end
  object qryPedido: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'select a.nr_pedido,a.codigo_cliente,a.dt_pedido,a.valor_total, '
      '       b.nome '
      'from pedido a '
      'inner join cliente b on (a.codigo_cliente=b.codigo)'
      'where a. nr_pedido=-1')
    Left = 56
    Top = 32
    object qryPedidonr_pedido: TIntegerField
      FieldName = 'nr_pedido'
      Origin = 'nr_pedido'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryPedidocodigo_cliente: TIntegerField
      FieldName = 'codigo_cliente'
      Origin = 'codigo_cliente'
      Required = True
    end
    object qryPedidodt_pedido: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'dt_pedido'
      Origin = 'dt_pedido'
    end
    object qryPedidovalor_total: TBCDField
      FieldName = 'valor_total'
      Precision = 10
      Size = 2
    end
    object qryPedidonome: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 80
    end
  end
  object dspPedido: TDataSetProvider
    DataSet = qryPedido
    Options = [poIncFieldProps, poAllowCommandText, poUseQuoteChar]
    Left = 24
    Top = 32
  end
  object cdsPedido: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedido'
    AfterInsert = cdsPedidoAfterInsert
    Left = 88
    Top = 32
    object cdsPedidonr_pedido: TIntegerField
      DisplayLabel = 'Nr. Pedido'
      FieldName = 'nr_pedido'
      Origin = 'nr_pedido'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsPedidocodigo_cliente: TIntegerField
      DisplayLabel = 'C'#243'digo Cliente'
      FieldName = 'codigo_cliente'
      Origin = 'codigo_cliente'
      Required = True
    end
    object cdsPedidodt_pedido: TDateField
      DisplayLabel = 'Data Pedido'
      FieldName = 'dt_pedido'
      Origin = 'dt_pedido'
      Required = True
    end
    object cdsPedidovalor_total: TBCDField
      FieldName = 'valor_total'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object cdsPedidonome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 80
    end
    object cdsPedidoqryItemPedido: TDataSetField
      FieldName = 'qryItemPedido'
    end
  end
  object dsQryPedido: TDataSource
    DataSet = qryPedido
    Left = 56
    Top = 80
  end
  object qryItemPedido: TFDQuery
    Active = True
    MasterSource = dsQryPedido
    MasterFields = 'nr_pedido'
    DetailFields = 'nr_pedido'
    Connection = FDConnection
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'SELECT A.*, B.PRECO_VENDA, B.DESCRICAO'
      'FROM PEDIDO_ITEM A, PRODUTO B'
      'WHERE A.CODIGO_PRODUTO=B.CODIGO'
      'AND A.NR_PEDIDO=:NR_PEDIDO')
    Left = 96
    Top = 80
    ParamData = <
      item
        Name = 'NR_PEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryItemPedidoid_item: TIntegerField
      FieldName = 'id_item'
      Origin = 'id_item'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryItemPedidonr_pedido: TIntegerField
      FieldName = 'nr_pedido'
      Origin = 'nr_pedido'
      Required = True
    end
    object qryItemPedidocodigo_produto: TIntegerField
      FieldName = 'codigo_produto'
      Origin = 'codigo_produto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryItemPedidoqtde: TIntegerField
      FieldName = 'qtde'
      Origin = 'qtde'
      Required = True
    end
    object qryItemPedidovalor_produto: TBCDField
      FieldName = 'valor_produto'
      Origin = 'valor_produto'
      Required = True
      Precision = 10
      Size = 2
    end
    object qryItemPedidovalor_total: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Precision = 10
      Size = 2
    end
    object qryItemPedidoPRECO_VENDA: TBCDField
      AutoGenerateValue = arDefault
      FieldName = 'PRECO_VENDA'
      Origin = 'preco_venda'
      ProviderFlags = []
      ReadOnly = True
      Precision = 10
      Size = 2
    end
    object qryItemPedidoDESCRICAO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'DESCRICAO'
      Origin = 'descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 80
    end
  end
  object cdsItemPedido: TClientDataSet
    Aggregates = <>
    DataSetField = cdsPedidoqryItemPedido
    Params = <>
    AfterInsert = cdsItemPedidoAfterInsert
    OnCalcFields = cdsItemPedidoCalcFields
    Left = 128
    Top = 80
    object cdsItemPedidoid_item: TIntegerField
      FieldName = 'id_item'
      Required = True
    end
    object cdsItemPedidonr_pedido: TIntegerField
      DisplayLabel = 'Nr. Pedido'
      FieldName = 'nr_pedido'
      Origin = 'nr_pedido'
      Required = True
    end
    object cdsItemPedidocodigo_produto: TIntegerField
      DisplayLabel = 'C'#243'digo do Produto'
      FieldName = 'codigo_produto'
      Origin = 'codigo_produto'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsItemPedidoqtde: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'qtde'
      Origin = 'qtde'
      Required = True
    end
    object cdsItemPedidovalor_produto: TBCDField
      DisplayLabel = 'Valor do Produto'
      FieldName = 'valor_produto'
      Origin = 'valor_produto'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object cdsItemPedidovalor_total: TBCDField
      DisplayLabel = 'Valor Total'
      FieldName = 'valor_total'
      Origin = 'valor_total'
      Required = True
      currency = True
      Precision = 10
      Size = 2
    end
    object cdsItemPedidoPRECO_VENDA: TBCDField
      FieldName = 'PRECO_VENDA'
      Origin = 'preco_venda'
      ProviderFlags = []
      currency = True
      Precision = 10
      Size = 2
    end
    object cdsItemPedidoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Origin = 'descricao'
      ProviderFlags = []
      Size = 80
    end
    object cdsItemPedidototal_calc: TFloatField
      FieldKind = fkCalculated
      FieldName = 'total_calc'
      currency = True
      Calculated = True
    end
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 448
    Top = 24
  end
end
