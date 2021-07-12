object DM: TDM
  OldCreateOrder = False
  Height = 458
  Width = 719
  object conexao: TFDConnection
    Params.Strings = (
      'Database=pedido'
      'User_Name=root'
      'Password=root'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    BeforeConnect = conexaoBeforeConnect
    Left = 40
    Top = 24
  end
  object mysql_link: TFDPhysMySQLDriverLink
    DriverID = 'MySQL'
    VendorLib = 'C:\Pedido\libmysql.dll'
    Left = 128
    Top = 25
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 240
    Top = 27
  end
  object SQL_clientes: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'select * from clientes')
    Left = 40
    Top = 136
  end
  object TB_clientes: TFDTable
    IndexFieldNames = 'id_cli'
    Connection = conexao
    UpdateOptions.UpdateTableName = 'clientes'
    TableName = 'clientes'
    Left = 192
    Top = 138
    object TB_clientesid_cli: TFDAutoIncField
      FieldName = 'id_cli'
      Origin = 'id_cli'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TB_clientesnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 45
    end
    object TB_clientescidade: TStringField
      FieldName = 'cidade'
      Origin = 'cidade'
      Required = True
      Size = 45
    end
    object TB_clientesuf: TStringField
      FieldName = 'uf'
      Origin = 'uf'
      Required = True
      FixedChar = True
      Size = 2
    end
  end
  object ds_clientes: TDataSource
    DataSet = SQL_clientes
    Left = 120
    Top = 136
  end
  object SQL_pedidos_dados: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'select * from pedidos_dados_gerais')
    Left = 96
    Top = 224
  end
  object ds_pedidos_dados: TDataSource
    DataSet = SQL_pedidos_dados
    Left = 240
    Top = 224
  end
  object TB_pedidos_dados: TFDTable
    Connection = conexao
    TableName = 'pedido.pedidos_dados_gerais'
    Left = 376
    Top = 224
  end
  object SQL_pedido: TFDQuery
    Connection = conexao
    SQL.Strings = (
      
        'SELECT MAX(num_pedido) AS NumeroPedido FROM pedidos_dados_gerais' +
        ';')
    Left = 24
    Top = 352
    object SQL_pedidoNumeroPedido: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'NumeroPedido'
      Origin = 'NumeroPedido'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object ds_pedido: TDataSource
    DataSet = SQL_pedido
    Left = 112
    Top = 352
  end
  object SQL_Produtos: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'select * from clientes')
    Left = 296
    Top = 144
  end
  object TB_Produtos: TFDTable
    IndexFieldNames = 'id_prod'
    Connection = conexao
    TableName = 'pedido.produtos'
    Left = 448
    Top = 146
    object TB_Produtosid_prod: TFDAutoIncField
      FieldName = 'id_prod'
      Origin = 'id_prod'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TB_Produtosdescricao: TStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 45
    end
    object TB_Produtospreco_venda: TFloatField
      FieldName = 'preco_venda'
      Origin = 'preco_venda'
      Required = True
    end
  end
  object ds_Produtos: TDataSource
    DataSet = SQL_Produtos
    Left = 376
    Top = 144
  end
  object ds_pedidos_produtos: TDataSource
    DataSet = SQL_pedidos_produtos
    Left = 360
    Top = 336
  end
  object SQL_pedidos_produtos: TFDQuery
    AggregatesActive = True
    Connection = conexao
    SQL.Strings = (
      'select pp.*, p.Descricao from pedidos_produtos pp'
      '        left join Produtos p on p.id_prod = pp.produtos_id_prod '
      'order by item')
    Left = 240
    Top = 336
    object SQL_pedidos_produtositem: TFDAutoIncField
      FieldName = 'item'
      Origin = 'item'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object SQL_pedidos_produtosqtde: TStringField
      FieldName = 'qtde'
      Origin = 'qtde'
      Required = True
      Size = 100
    end
    object SQL_pedidos_produtosvlr_unit: TFloatField
      FieldName = 'vlr_unit'
      Origin = 'vlr_unit'
      Required = True
      DisplayFormat = ',0.00'
    end
    object SQL_pedidos_produtosvlr_total: TFloatField
      FieldName = 'vlr_total'
      Origin = 'vlr_total'
      Required = True
      DisplayFormat = ',0.00'
    end
    object SQL_pedidos_produtosnum_pedido: TIntegerField
      FieldName = 'num_pedido'
      Origin = 'num_pedido'
      Required = True
    end
    object SQL_pedidos_produtosprodutos_id_prod: TIntegerField
      FieldName = 'produtos_id_prod'
      Origin = 'produtos_id_prod'
      Required = True
    end
    object SQL_pedidos_produtosDescricao: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'Descricao'
      Origin = 'Descricao'
      ProviderFlags = []
      ReadOnly = True
      Size = 45
    end
  end
  object SQL_AUX: TFDQuery
    Connection = conexao
    Left = 528
    Top = 280
  end
  object ds_total_pedido: TDataSource
    DataSet = SQL_AUX
    Left = 624
    Top = 280
  end
end
