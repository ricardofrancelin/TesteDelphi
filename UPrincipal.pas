unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.Mask, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFPrincipal = class(TForm)
    Panel1: TPanel;
    pnpDados: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    dsCdsPedido: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    bitNovoProduto: TBitBtn;
    Panel5: TPanel;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    cPedido: TComboBox;
    eNomeCliente: TEdit;
    Panel2: TPanel;
    bitBuscaPedido: TBitBtn;
    bitGravar: TBitBtn;
    bitCancelar: TBitBtn;
    eCliente: TEdit;
    Label6: TLabel;
    dsCdsItemPedido: TDataSource;
    procedure dsCdsPedidoDataChange(Sender: TObject; Field: TField);
    procedure bitProximoClick(Sender: TObject);
    procedure bitGravarClick(Sender: TObject);
    procedure bitNovoProdutoClick(Sender: TObject);
    procedure bitBuscaPedidoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eClienteChange(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bitCancelarClick(Sender: TObject);
    procedure eClienteKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure prcGravar;
    procedure prcBuscaPedido;
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

uses UDM, UPrincipalItens;

procedure TFPrincipal.bitBuscaPedidoClick(Sender: TObject);
begin
  if TRIM(cPedido.Items.Strings[cPedido.ItemIndex])  <> '' then
    prcBuscaPedido
  else
   ShowMessage('Não existe pedido para o cliente selecionado!');
end;

procedure TFPrincipal.bitNovoProdutoClick(Sender: TObject);
begin

  if Dm.cdsPedido.IsEmpty then
  begin
    Dm.cdsPedido.Insert;
    Dm.cdsPedidocodigo_cliente.AsInteger := StrToInt(eCliente.Text);
  end;

  Dm.cdsItemPedido.Insert;
  if funCriaTelaItensPedido(tpInsert) = True then
  begin
    Dm.cdsItemPedido.Post;
  end else
  begin
    Dm.cdsItemPedido.Cancel;
  end;

end;

procedure TFPrincipal.bitProximoClick(Sender: TObject);
begin
 DM.cdsPedido.Next;
end;

procedure TFPrincipal.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 if key = VK_RETURN	 then
 begin
   if not Dm.cdsItemPedido.IsEmpty then
   begin
      Dm.cdsItemPedido.Edit;
      if funCriaTelaItensPedido(tpEdit) = True then
      begin
        Dm.cdsItemPedido.Post;
      end else
      begin
        Dm.cdsItemPedido.Cancel;
      end;
   end
 end else if key = VK_DELETE then
 begin
   if not Dm.cdsItemPedido.IsEmpty then
   begin
     if MessageDlg('Você tem certeza que deseja excluir o registro?',mtConfirmation,[mbyes,mbno],0) = mryes then
     begin
      try
        Dm.cdsPedido.Edit;
        dm.cdsPedidovalor_total.AsFloat :=
         (dm.cdsPedidovalor_total.AsFloat - dm.cdsItemPedidovalor_total.AsFloat);
        Dm.cdsItemPedido.Delete;
      except
         on e:Exception do
         begin
          ShowMessage('Erro ao tentar remover o item de pedido!' + #13 + e.Message);
         end;
       end;
     end;
   end
 end;

end;

procedure TFPrincipal.bitCancelarClick(Sender: TObject);
begin
 if MessageDlg('Você tem certeza que deseja cancelar o Pedido?',mtConfirmation,[mbyes,mbno],0) = mryes then
 begin
  if Dm.cdsPedido.State in [dsInsert,dsEdit] then
   Dm.cdsPedido.CancelUpdates
  else
    Dm.prcRemovePedido(DM.cdsPedidonr_pedido.AsString);
    eCliente.Clear;
 end;
end;

procedure TFPrincipal.bitGravarClick(Sender: TObject);
begin
  prcGravar;
  DM.prcBuscaPedido('-1','-1');
  eCliente.Clear;
end;

procedure TFPrincipal.dsCdsPedidoDataChange(Sender: TObject; Field: TField);
begin

 if Dm.cdsPedido.State in [dsInsert,dsEdit] then
 begin
  bitBuscaPedido.Visible := False;
  bitGravar.Visible := True;
  bitCancelar.Visible := True;
 end else
 begin
  bitBuscaPedido.Visible := True;
  bitGravar.Visible := False;
  if Dm.cdsPedido.RecordCount > 0 then
    bitCancelar.Visible := True
  else
    bitCancelar.Visible := False;
 end;

end;

procedure TFPrincipal.eClienteChange(Sender: TObject);
var
 vNome : string;
begin
 DM.prcBuscaPedido('-1','-1');
 if TRIM(eCliente.Text) <> '' then
 begin
   if DM.funBuscaCliente(eCliente.Text,cPedido,vNome) = True then
   begin
     eNomeCliente.Text := vNome;
     cPedido.ItemIndex := 0;
     bitBuscaPedido.Visible := True;
     bitNovoProduto.Visible := True;
   end else
   begin
     bitNovoProduto.Visible := False;
     bitBuscaPedido.Visible := False;
     bitNovoProduto.Visible := False;
     cPedido.Items.Clear;
     eNomeCliente.Clear;
   end;
 end else
 begin
   bitBuscaPedido.Visible := False;
   bitNovoProduto.Visible := False;
   cPedido.Items.Clear;
   eNomeCliente.Clear;
 end;


end;

procedure TFPrincipal.eClienteKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#13,#6,#7,#8,#9,#4,#5]) then
  key := #0;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  bitBuscaPedido.Visible := False;
  bitNovoProduto.Visible := False;
end;

procedure TFPrincipal.prcBuscaPedido;
begin
  Dm.prcBuscaPedido(cPedido.Items.Strings[cPedido.ItemIndex] ,eCliente.Text);
end;



procedure TFPrincipal.prcGravar;
begin
  try
    DM.cdsPedido.ApplyUpdates(-1);
    DM.cdsPedido.RefreshRecord;
  except
   on e:Exception do
   begin
    ShowMessage('Erro ao tentar realizar a operação!' + #13 + e.Message);
   end;
  end;
end;


end.
