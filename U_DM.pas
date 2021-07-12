unit U_DM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, System.IniFiles, vcl.forms, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    conexao: TFDConnection;
    mysql_link: TFDPhysMySQLDriverLink;
    WaitCursor: TFDGUIxWaitCursor;
    SQL_clientes: TFDQuery;
    TB_clientes: TFDTable;
    TB_clientesid_cli: TFDAutoIncField;
    TB_clientesnome: TStringField;
    TB_clientescidade: TStringField;
    TB_clientesuf: TStringField;
    ds_clientes: TDataSource;
    SQL_pedidos_dados: TFDQuery;
    ds_pedidos_dados: TDataSource;
    TB_pedidos_dados: TFDTable;
    SQL_pedido: TFDQuery;
    SQL_pedidoNumeroPedido: TIntegerField;
    ds_pedido: TDataSource;
    SQL_Produtos: TFDQuery;
    TB_Produtos: TFDTable;
    ds_Produtos: TDataSource;
    TB_Produtosid_prod: TFDAutoIncField;
    TB_Produtosdescricao: TStringField;
    TB_Produtospreco_venda: TFloatField;
    ds_pedidos_produtos: TDataSource;
    SQL_pedidos_produtos: TFDQuery;
    SQL_AUX: TFDQuery;
    ds_total_pedido: TDataSource;
    SQL_pedidos_produtositem: TFDAutoIncField;
    SQL_pedidos_produtosqtde: TStringField;
    SQL_pedidos_produtosvlr_unit: TFloatField;
    SQL_pedidos_produtosvlr_total: TFloatField;
    SQL_pedidos_produtosnum_pedido: TIntegerField;
    SQL_pedidos_produtosprodutos_id_prod: TIntegerField;
    SQL_pedidos_produtosDescricao: TStringField;
    procedure conexaoBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.conexaoBeforeConnect(Sender: TObject);
var
  SERVER, DATABASE, USER, SENHA, LIB: string;
  PORTA: integer;
  CONF: TIniFile;
begin

  // setando os dados do arquivo ini
  SetCurrentDir(ExtractFilePath(Application.ExeName));
  CONF := TIniFile.Create(GetCurrentDir + '\conf.ini');

  LIB := GetCurrentDir + '\libmysql.dll';


  DATABASE := CONF.ReadString('banco','database','');
  SERVER   := CONF.ReadString('banco','server','');
  USER     := CONF.ReadString('banco','user','');
  SENHA    := CONF.ReadString('banco','senha','');
  PORTA    := StrToInt(CONF.ReadString('banco','porta',''));

  { dados da conexão do banco de dados dinâmico }

  // fecha conexao
  conexao.Connected := False;

  // passo os parâmetros
  mysql_link.VendorLib := LIB;
  mysql_link.DriverID := 'MySQL';
  conexao.DriverName := 'MySQL';

  conexao.Params.Add('Database='+DATABASE);
  conexao.Params.Add('Server='+SERVER);
  conexao.Params.Add('User_name='+USER);
  conexao.Params.Add('Password='+SENHA);
  conexao.Params.Add('Port='+IntToStr(PORTA));

 end;
end.
