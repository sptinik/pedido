unit Produto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI, System.IniFiles, vcl.forms;

type

  TProduto = class

    Private
    FId_Prod: Longint;
    FDescricao: String;
    FPreco_Venda: Currency;
    procedure SetPreco_Venda(const Value: Currency);
    procedure SetId_Prod(const Value: Longint);
    procedure SetDescricao(const Value: String);

    Public

      Constructor Create (Conn:TFDConnection);    // declaração do metodo construtor
      Destructor  Destroy; Override; // declaração do metodo destrutor

      Property Id_Prod : Longint read FId_Prod write SetId_Prod;
      Property Descricao   : String read FDescricao write SetDescricao;
      Property Preco_Venda : Currency read FPreco_Venda write SetPreco_Venda;

       Function Retorna_Dados_Produto (Pesquisa:String; Var Id_Prod:Longint; Var Descricao:String; Var Preco_Venda:Currency; VAR Qryprodutos: TFDQuery; vResult : String): Longint;


  end;

implementation

  var Conexao : TFDConnection;

{ TProduto }

constructor TProduto.Create(Conn: TFDConnection);
begin

  if not Assigned(Conexao) then
    Conexao := TFDConnection.Create(nil);

  Conexao := Conn;

end;

destructor TProduto.Destroy;
begin
  inherited;
end;

function TProduto.Retorna_Dados_Produto (Pesquisa:String; Var Id_Prod:Longint; Var Descricao:String; Var Preco_Venda:Currency; VAR Qryprodutos: TFDQuery; vResult : String): Longint;
Var
  Qry : TFDQuery;
  ISNumber : Boolean;
begin

  vResult :='';

  Qry := TFDQuery.Create(nil);
  Qry.Connection := Conexao;
  try

    try
     if StrToInt(Pesquisa)>0 then
       ISNumber := True;
    except
       ISNumber := False;
    end;

    if ISNumber then
     Qry.SQL.Add('Select id_prod, descricao, preco_venda from produtos where id_prod = '+Pesquisa);

    try

      Qry.Open;
      Result := Qry.RecordCount;

      Qryprodutos.SQL.Text  := Qry.SQL.Text;
      Qryprodutos.Open;


      if Result = 0 then
        vResult := 'Registro não encontrado na base de dados';

      if Result = 1 then begin

        Id_Prod     := Qry.Fields[0].AsInteger;
        Descricao   := Qry.Fields[1].AsString;
        Preco_Venda := Qry.Fields[2].AsCurrency;

      end;

    except
      vResult := 'erro ao abrir a query';
    end;


  finally
    Qry.Free;
  end;

end;

procedure TProduto.SetPreco_Venda(const Value: Currency);
begin
  FPreco_Venda := Value;
end;

procedure TProduto.SetId_Prod(const Value: Longint);
begin
  FId_Prod := Value;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
