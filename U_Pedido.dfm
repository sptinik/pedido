object frm_pedido: Tfrm_pedido
  Left = 0
  Top = 0
  ActiveControl = edt_cod_cliente
  BorderStyle = bsSingle
  Caption = 'Pedido'
  ClientHeight = 527
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 109
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object Label4: TLabel
    Left = 263
    Top = 61
    Width = 64
    Height = 13
    Caption = 'Data Emiss'#227'o'
  end
  object Label3: TLabel
    Left = 176
    Top = 61
    Width = 23
    Height = 13
    Caption = 'Hora'
  end
  object Label2: TLabel
    Left = 8
    Top = 61
    Width = 87
    Height = 13
    Caption = 'Numero do Pedido'
  end
  object Label6: TLabel
    Left = 8
    Top = 189
    Width = 38
    Height = 13
    Caption = 'Produto'
  end
  object Label7: TLabel
    Left = 8
    Top = 243
    Width = 56
    Height = 13
    Caption = 'Quantidade'
  end
  object Label10: TLabel
    Left = 104
    Top = 243
    Width = 37
    Height = 13
    Caption = 'Unitario'
  end
  object Label11: TLabel
    Left = 193
    Top = 243
    Width = 24
    Height = 13
    Caption = 'Total'
  end
  object Label15: TLabel
    Left = 472
    Top = 482
    Width = 74
    Height = 13
    Caption = 'Total do Pedido'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 665
    Height = 49
    Align = alTop
    Color = clGrayText
    ParentBackground = False
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 10
      Width = 111
      Height = 23
      Caption = 'Tela Pedido'
      Color = clCream
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 166
    Width = 648
    Height = 16
    Align = alCustom
    Color = clGrayText
    ParentBackground = False
    TabOrder = 9
  end
  object edt_cod_cliente: TEdit
    Left = 8
    Top = 128
    Width = 65
    Height = 21
    TabOrder = 2
    OnExit = edt_cod_clienteExit
    OnKeyDown = edt_cod_clienteKeyDown
    OnKeyPress = edt_cod_clienteKeyPress
  end
  object edt_desc_cliente: TEdit
    Left = 79
    Top = 128
    Width = 375
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object edt_hora: TEdit
    Left = 176
    Top = 80
    Width = 65
    Height = 21
    Enabled = False
    TabOrder = 10
  end
  object edt_dt_emissao: TEdit
    Left = 263
    Top = 80
    Width = 82
    Height = 21
    Enabled = False
    TabOrder = 11
  end
  object edt_numero_pedido: TEdit
    Left = 8
    Top = 80
    Width = 137
    Height = 21
    Enabled = False
    TabOrder = 12
  end
  object edt_cod_produto: TEdit
    Left = 8
    Top = 208
    Width = 65
    Height = 21
    Enabled = False
    TabOrder = 3
    OnKeyDown = edt_cod_produtoKeyDown
    OnKeyPress = edt_cod_produtoKeyPress
  end
  object edt_desc_produto: TEdit
    Left = 79
    Top = 208
    Width = 375
    Height = 21
    Enabled = False
    TabOrder = 8
  end
  object edt_quant: TEdit
    Left = 8
    Top = 262
    Width = 65
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 4
    Text = '1'
    OnExit = edt_quantExit
  end
  object edt_unit: TEdit
    Left = 104
    Top = 262
    Width = 65
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 5
    Text = '0,00'
  end
  object edt_total: TEdit
    Left = 193
    Top = 262
    Width = 65
    Height = 21
    Alignment = taRightJustify
    Enabled = False
    TabOrder = 13
    Text = '0,00'
  end
  object btn_Gravar: TButton
    Left = 276
    Top = 258
    Width = 178
    Height = 29
    Caption = 'Incluir Produto'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = btn_GravarClick
  end
  object Panel3: TPanel
    Left = 0
    Top = 302
    Width = 648
    Height = 16
    Align = alCustom
    Color = clGrayText
    ParentBackground = False
    TabOrder = 14
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 324
    Width = 640
    Height = 139
    DataSource = DM.ds_pedidos_produtos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'produtos_id_prod'
        Title.Alignment = taCenter
        Title.Caption = 'Codigo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Caption = 'Descri'#231#227'o'
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'qtde'
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlr_unit'
        Title.Alignment = taRightJustify
        Title.Caption = 'Unti'#225'rio'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vlr_total'
        Title.Alignment = taRightJustify
        Title.Caption = 'Total R$'
        Visible = True
      end>
  end
  object Edit1: TEdit
    Left = 552
    Top = 479
    Width = 96
    Height = 21
    Alignment = taRightJustify
    TabOrder = 15
    Text = '0,00'
  end
end
