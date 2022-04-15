unit UPrincipalItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls;

type
  TModoTela = (tpInsert,tpEdit);
  TFPrincipalItens = class(TForm)
    Panel1: TPanel;
    bitCancela: TBitBtn;
    bitOK: TBitBtn;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit4: TDBEdit;
    Label3: TLabel;
    DBEdit6: TDBEdit;
    Label5: TLabel;
    DBEdit3: TDBEdit;
    procedure bitCancelaClick(Sender: TObject);
    procedure bitOKClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
  private
    { Private declarations }
    vOK : Boolean;
    vValorTotalAntigo : Extended;
  public
    { Public declarations }
  end;

  function funCriaTelaItensPedido(pModoTela:TModoTela):Boolean;

var
  FPrincipalItens: TFPrincipalItens;

implementation

{$R *.dfm}

uses UDM, UPrincipal;

function funCriaTelaItensPedido(pModoTela:TModoTela):Boolean;
var
 Form : TFPrincipalItens;
begin
  Form := TFPrincipalItens.Create(Nil);
  try
   Form.vOK := False;
   Form.vValorTotalAntigo := 0;
   if pModoTela = tpEdit then
     Form.vValorTotalAntigo := DM.cdsItemPedidovalor_total.AsFloat;
   Form.ShowModal;
   Result := Form.vOK;
   if Result = True then
   begin
    if pModoTela = tpInsert then
    begin
      Dm.cdsPedidovalor_total.AsFloat :=
         (Dm.cdsPedidovalor_total.AsFloat + Dm.cdsItemPedidovalor_total.AsFloat);
    end else
    begin
      Dm.cdsPedidovalor_total.AsFloat :=
         (Dm.cdsPedidovalor_total.AsFloat - Form.vValorTotalAntigo) +
         (Dm.cdsItemPedidovalor_total.AsFloat);
    end;
   end;
  finally
   Form.Free;
  end;
end;

procedure TFPrincipalItens.bitCancelaClick(Sender: TObject);
begin
  vOK := False;
  Close;
end;

procedure TFPrincipalItens.bitOKClick(Sender: TObject);
begin
 dm.cdsItemPedidovalor_total.AsFloat := dm.cdsItemPedidototal_calc.AsFloat;
 if Dm.funCampoObrigatorios(Dm.cdsItemPedido) = True then
 begin

   if (dm.cdsItemPedidovalor_produto.AsFloat <= 0) or (dm.cdsItemPedidoqtde.AsFloat <= 0) then
   begin
     ShowMessage('Informe um valor válido para a quantidade e o preço do produto!');
   end else
   begin
     vOK := True;
     Close;
   end;

 end;
end;

procedure TFPrincipalItens.DBEdit1Exit(Sender: TObject);
var
 vNome : String;
 vPreco : Extended;
begin

 if TRIM(DBEdit1.Text) <> '' then
 begin
   if Dm.funBuscaDadosProduto(Dm.cdsItemPedidocodigo_produto.AsString,vNome,vPreco) = True then
   begin
     Dm.cdsItemPedidovalor_produto.AsFloat := vPreco;
     Dm.cdsItemPedidoDESCRICAO.AsString := vNome;
   end;
 end;

end;

end.
