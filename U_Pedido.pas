unit U_Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, U_DM;

type
  Tfrm_pedido = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Label5: TLabel;
    edt_cod_cliente: TEdit;
    edt_desc_cliente: TEdit;
    edt_hora: TEdit;
    edt_dt_emissao: TEdit;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    edt_numero_pedido: TEdit;
    Label6: TLabel;
    edt_cod_produto: TEdit;
    edt_desc_produto: TEdit;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edt_quant: TEdit;
    edt_unit: TEdit;
    edt_total: TEdit;
    btn_Gravar: TButton;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Label15: TLabel;
    Edit1: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edt_cod_clienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_cod_clienteExit(Sender: TObject);
    procedure edt_cod_clienteKeyPress(Sender: TObject; var Key: Char);
    procedure edt_cod_produtoKeyPress(Sender: TObject; var Key: Char);
    procedure edt_cod_produtoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edt_quantExit(Sender: TObject);
    function RemoveCaracteres(const chrs: array of Char;
      const texto: string): string;
    function ReplaceSTR(var s: string; oldPattern, newPattern: string): string;
    procedure btn_GravarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Total;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_pedido: Tfrm_pedido;

implementation

uses
  Cliente, Produto;

{$R *.dfm}

procedure Tfrm_pedido.Total;
var
  VlrTotal: Real;
begin

  with DM.SQL_AUX do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SUM(vlr_total) TOTAL FROM pedidos_produtos ' +
      'WHERE NUM_PEDIDO = :NUM_PEDIDO');
    ParamByName('NUM_PEDIDO').AsInteger := StrToInt(edt_numero_pedido.Text);
    Open;

    if RecordCount > 0 then
      Edit1.Text := FormatFloat(',0.00',
        StrToFloat(FieldByName('Total').AsString));

    VlrTotal := FieldByName('Total').AsFloat;
  end;

  with DM.SQL_AUX do
  begin
    Close;
    SQL.Clear;
    SQL.Add('Update pedidos_dados_gerais set valor_total = ' +
      FloatToStr(VlrTotal) + ' WHERE NUM_PEDIDO = :NUM_PEDIDO ');
    ParamByName('NUM_PEDIDO').AsInteger := StrToInt(edt_numero_pedido.Text);
    ExecSQL;
    Close;
  end;

  with DM.SQL_pedidos_produtos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select pp.*, p.Descricao from pedidos_produtos pp ' +
      '        left join Produtos p on p.id_prod = pp.produtos_id_prod ' +
      'WHERE NUM_PEDIDO = :NUM_PEDIDO ' + 'order by item ');
    ParamByName('NUM_PEDIDO').AsInteger := StrToInt(edt_numero_pedido.Text);
    Open;
  end;

end;

procedure Tfrm_pedido.btn_GravarClick(Sender: TObject);
begin
  with DM.SQL_pedidos_produtos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO pedidos_produtos (qtde, vlr_unit, vlr_total, num_pedido, produtos_id_prod) VALUES (:qtde, :vlr_unit, :vlr_total, :num_pedido, :produtos_id_prod) ');
    ParamByName('qtde').AsString := edt_quant.Text;
    ParamByName('vlr_unit').AsFloat :=
      StrToFloat(RemoveCaracteres(['.'], Trim(edt_unit.Text)));
    ParamByName('vlr_total').AsFloat :=
      StrToFloat(RemoveCaracteres(['.'], Trim(edt_total.Text)));
    ParamByName('num_pedido').AsInteger := StrToInt(edt_numero_pedido.Text);
    ParamByName('produtos_id_prod').AsInteger := StrToInt(edt_cod_produto.Text);
    ExecSQL;
  end;

  Total;

  edt_cod_produto.Text := '';
  edt_desc_produto.Text := '';
  edt_quant.Text := '1';
  edt_unit.Text := '0,00';
  edt_total.Text := '0,00';

  edt_cod_produto.SetFocus;
end;

procedure Tfrm_pedido.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    with DM.SQL_AUX do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM pedidos_produtos where item = :item ');
      ParamByName('item').Value := DM.SQL_pedidos_produtos.FieldByName('item')
        .AsInteger;
      ExecSQL;

      Total;
    end;
  end;
end;

procedure Tfrm_pedido.edt_cod_clienteExit(Sender: TObject);
begin
  if edt_cod_cliente.Text <> '' then
  begin
    if edt_desc_cliente.Text = '' then
        Exit;
    with DM.SQL_pedidos_dados do
    begin
      btn_Gravar.Enabled := True;
      edt_cod_produto.Enabled := True;
      edt_quant.Enabled := True;
      edt_unit.Enabled := True;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO pedidos_dados_gerais (valor_total, clientes_id, data_emissao) VALUES(:valor_total, :clientes_id, :data_emissao)');
      ParamByName('valor_total').Value := '0.00';
      ParamByName('data_emissao').Value := Now;
      ParamByName('clientes_id').Value := edt_cod_cliente.Text;
      ExecSQL;
    end;

    DM.SQL_pedido.Active := True;

    with DM.SQL_pedido do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT MAX(num_pedido) as NumeroPedido FROM pedidos_dados_gerais');
      Open;

      if RecordCount = 1 then
        edt_numero_pedido.Text := DM.SQL_pedidoNumeroPedido.AsString;
    end;

    edt_cod_produto.SetFocus;
  end;
end;

procedure Tfrm_pedido.edt_cod_clienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Cliente: TCliente;
  Nome, Result: String;
  QtdRegistro, Codigo: Longint;

begin

  DM.SQL_clientes.Fields.Clear;

  case Key of

    VK_RETURN:
      begin

        Cliente := TCliente.Create(DM.conexao);

        try

          QtdRegistro := Cliente.Retorna_Cliente(edt_cod_cliente.Text, Codigo,
            Nome, DM.SQL_clientes, Result);

          if QtdRegistro = 0 then
          begin
            ShowMessage('cliente não encontrato');
            edt_cod_cliente.SetFocus;
          end;

          if QtdRegistro = 1 then
          begin
            edt_cod_cliente.Text := FormatFloat('0000', Codigo);
            edt_desc_cliente.Text := Nome;
          end;

        finally
          Cliente.Free;
        end;

      end;

  end;

end;

procedure Tfrm_pedido.edt_cod_clienteKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key in ['0' .. '9'] = false) and (Word(Key) <> vk_back)) then
    Key := #0;
end;

procedure Tfrm_pedido.edt_cod_produtoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Produto: TProduto;
  Nome, Result: String;
  QtdRegistro, Codigo: Longint;
  Preco: Currency;
begin

  DM.SQL_clientes.Fields.Clear;

  case Key of

    VK_RETURN:
      begin

        Produto := TProduto.Create(DM.conexao);

        try

          QtdRegistro := Produto.Retorna_Dados_Produto(edt_cod_produto.Text,
            Codigo, Nome, Preco, DM.SQL_Produtos, Result);

          if QtdRegistro = 0 then
          begin
            ShowMessage('produto não encontrato');
            edt_cod_produto.SetFocus;
          end;

          if QtdRegistro = 1 then
          begin
            edt_cod_produto.Text := FormatFloat('0000', Codigo);
            edt_desc_produto.Text := Nome;
            edt_unit.Text := FormatFloat('0,00', Preco);
          end;

        finally
          Produto.Free;
        end;

      end;

  end;

end;

procedure Tfrm_pedido.edt_cod_produtoKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key in ['0' .. '9'] = false) and (Word(Key) <> vk_back)) then
    Key := #0;
end;

procedure Tfrm_pedido.edt_quantExit(Sender: TObject);
var
  Total: Double;
begin

  Total := 0;

  Total := StrToFloat(Trim(edt_quant.Text)) *
    StrToFloat(RemoveCaracteres([',', '.'], Trim(edt_unit.Text)));

  edt_quant.Text := edt_quant.Text;

  edt_total.Text := FormatFloat(',0.00', Total);

end;

procedure Tfrm_pedido.FormCreate(Sender: TObject);
begin
  edt_hora.Text := FormatDateTime('hh:mm', Time);
  edt_dt_emissao.Text := FormatDateTime('dd/mm/yyyy', Date);
end;

procedure Tfrm_pedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Perform(WM_NEXTDLGCTL, 0, 0);
    Key := #0;
  end;
end;

function Tfrm_pedido.RemoveCaracteres(const chrs: array of Char;
  const texto: string): string;
var
  i: Integer;
begin
  Result := texto;
  for i := Low(chrs) to High(chrs) do
    Result := ReplaceSTR(Result, chrs[i], '');
end;

function Tfrm_pedido.ReplaceSTR(var s: string;
  oldPattern, newPattern: string): string;
begin
  s := StringReplace(s, oldPattern, newPattern, [rfReplaceAll, rfIgnoreCase]);
  Result := s;
end;

end.
