program Pedido;

uses
  Vcl.Forms,
  U_Pedido in 'U_Pedido.pas' {frm_pedido},
  U_DM in 'U_DM.pas' {DM: TDataModule},
  Cliente in 'Classe\Cliente.pas',
  Produto in 'Classe\Produto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_pedido, frm_pedido);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
