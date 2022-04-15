unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,Vcl.Dialogs,
  FireDAC.Comp.Client, FireDAC.Comp.UI, Datasnap.DBClient, Datasnap.Provider,
  Vcl.StdCtrls;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    qryPedido: TFDQuery;
    dspPedido: TDataSetProvider;
    qryPedidonr_pedido: TIntegerField;
    qryPedidocodigo_cliente: TIntegerField;
    qryPedidodt_pedido: TDateField;
    cdsPedido: TClientDataSet;
    cdsPedidonr_pedido: TIntegerField;
    cdsPedidocodigo_cliente: TIntegerField;
    cdsPedidodt_pedido: TDateField;
    dsQryPedido: TDataSource;
    qryItemPedido: TFDQuery;
    qryItemPedidonr_pedido: TIntegerField;
    qryItemPedidocodigo_produto: TIntegerField;
    qryItemPedidoqtde: TIntegerField;
    qryItemPedidovalor_produto: TBCDField;
    qryItemPedidoPRECO_VENDA: TBCDField;
    qryItemPedidoDESCRICAO: TStringField;
    cdsItemPedido: TClientDataSet;
    cdsPedidoqryItemPedido: TDataSetField;
    cdsItemPedidonr_pedido: TIntegerField;
    cdsItemPedidocodigo_produto: TIntegerField;
    cdsItemPedidoqtde: TIntegerField;
    cdsItemPedidovalor_produto: TBCDField;
    cdsItemPedidoPRECO_VENDA: TBCDField;
    cdsItemPedidoDESCRICAO: TStringField;
    qryPedidovalor_total: TBCDField;
    cdsPedidovalor_total: TBCDField;
    qryItemPedidovalor_total: TBCDField;
    cdsItemPedidovalor_total: TBCDField;
    cdsItemPedidototal_calc: TFloatField;
    qryPedidonome: TStringField;
    cdsPedidonome: TStringField;
    FDTransaction: TFDTransaction;
    qryItemPedidoid_item: TIntegerField;
    cdsItemPedidoid_item: TIntegerField;
    procedure cdsPedidoAfterInsert(DataSet: TDataSet);
    procedure cdsItemPedidoAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsItemPedidoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function funGeraProximoCodigo(pNomeTabela:String):Integer;
    procedure prcBuscaPedido(pNrPedido,pCdCliente:String);
    procedure prcRemovePedido(pNrPedido:String);

    function funCampoObrigatorios(qryFoco : TClientDataSet):Boolean;
    function funBuscaCliente(pCdCliente:String; var pCombo:TComboBox; var nmCliente:String):Boolean;

    function funBuscaDadosProduto(pCdProduto:string; var pNomeProduto:String; var pPrecoVendaProduto:Extended):Boolean;

  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

procedure TDM.cdsItemPedidoAfterInsert(DataSet: TDataSet);
begin
 cdsItemPedidoid_item.AsInteger := funGeraProximoCodigo('PEDIDO_ITEM');
 cdsItemPedidonr_pedido.AsInteger := cdsPedidonr_pedido.AsInteger;
end;

procedure TDM.cdsItemPedidoCalcFields(DataSet: TDataSet);
begin
 cdsItemPedidototal_calc.AsFloat :=
  (cdsItemPedidovalor_produto.AsFloat * cdsItemPedidoqtde.AsInteger);
end;

procedure TDM.cdsPedidoAfterInsert(DataSet: TDataSet);
begin
 cdsPedidonr_pedido.AsInteger := funGeraProximoCodigo('PEDIDO');
 cdsPedidodt_pedido.AsDateTime := Date;
 cdsPedidovalor_total.AsFloat := 0;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
 DM.prcBuscaPedido('-1','-1');
end;

function TDM.funBuscaCliente(pCdCliente:String; var pCombo:TComboBox; var nmCliente:String):Boolean;
var
 qryAux : TFDQuery;
begin
 Result := False;
 nmCliente := '';
 if TRIM(pCdCliente) = '' then
  pCdCliente := '-1';

 pCombo.Items.Clear;
 qryAux := TFDQuery.Create(Nil);
 try
  qryAux.Connection := FDConnection;
  qryAux.Close;
  qryAux.SQL.Text :=
     ' select b.nr_pedido, a.nome'
   + ' from cliente a '
   + ' left join pedido b on (a.codigo = b.codigo_cliente)'
   + ' where a.codigo = ' + pCdCliente;
   qryAux.Open;
   if not qryAux.IsEmpty then
   begin
     Result := True;
     qryAux.First;
     nmCliente := qryAux.FieldByName('nome').AsString;
     while not qryAux.Eof do
     begin
       pCombo.Items.Add(qryAux.FieldByName('nr_pedido').AsString);
       qryAux.Next;
     end;
   end;
 finally
  qryAux.Free;
 end;
end;

function TDM.funBuscaDadosProduto(pCdProduto: string; var pNomeProduto: String;
  var pPrecoVendaProduto: Extended): Boolean;
var
 qryAux : TFDQuery;
begin
 Result := False;
 qryAux := TFDQuery.Create(Nil);
 try
  qryAux.Connection := FDConnection;
  qryAux.Close;
  qryAux.SQL.Text :=
     ' select descricao, preco_venda '
   + ' from produto'
   + ' where codigo = ' + pCdProduto;
  qryAux.Open;
  if not qryAux.IsEmpty then
  begin
    Result := True;
    pNomeProduto := qryAux.FieldByName('descricao').AsString;
    pPrecoVendaProduto := qryAux.FieldByName('preco_venda').AsFloat;
  end else
  begin
    pNomeProduto := '';
    pPrecoVendaProduto := 0;
  end;

 finally
   qryAux.Free;
 end;
end;

function TDM.funGeraProximoCodigo(pNomeTabela: String): Integer;
var
 qryAux : TFDQuery;
begin
 Result := 0;
 qryAux := TFDQuery.Create(Nil);
 try
  qryAux.Connection := FDConnection;
  qryAux.Close;
  qryAux.SQL.Text :=
     ' update armazena_codigo set proximo_codigo = proximo_codigo + 1'
   + ' where nome_tabela = ' + QuotedStr(pNomeTabela);
  try
    qryAux.ExecSQL;
  except
   Result := -1;
  end;

  if Result <> -1 then
  begin
    qryAux.Close;
    qryAux.SQL.Text :=
       ' select proximo_codigo'
     + ' from armazena_codigo'
     + ' where nome_tabela = ' + QuotedStr(pNomeTabela);
    try
      qryAux.Open;
      Result := qryAux.FieldByName('proximo_codigo').AsInteger;
    except
      Result := -1;
    end;
  end;

 finally
  qryAux.Free;
 end;

end;

procedure TDM.prcBuscaPedido(pNrPedido,pCdCliente: String);
begin
 Dm.cdsPedido.Close;
 Dm.qryPedido.Close;
 Dm.qryPedido.SQL.Text :=
     ' select a.nr_pedido,a.codigo_cliente,a.dt_pedido,a.valor_total,'
   + '    b.nome'
   + ' from pedido a'
   + ' inner join cliente b on (a.codigo_cliente=b.codigo)'
   + ' where a. nr_pedido=' + pNrPedido
   + ' and a.codigo_cliente=' + pCdCliente;
 Dm.qryPedido.Open;
 Dm.cdsPedido.Open;
end;

procedure TDM.prcRemovePedido(pNrPedido: String);
var
 qryAux : TFDQuery;
 vControle : Boolean;
begin
 vControle := True;
 qryAux := TFDQuery.Create(Nil);
 try
  qryAux.Connection := FDConnection;
  qryAux.Transaction := FDTransaction;
  FDTransaction.StartTransaction;
  qryAux.SQL.Text :=
     ' delete from pedido_item where nr_pedido = ' + pNrPedido;
  try
    qryAux.ExecSQL;
  except
   on e:exception do
   begin
     ShowMessage('Erro ao tentar remover os item do Pedido!' + #13 + e.Message);
     FDTransaction.RollbackRetaining;
     vControle := False;
   end;
  end;
  if vControle = True then
  begin
    qryAux.Close;
    qryAux.SQL.Text :=
       ' delete from pedido where nr_pedido = ' + pNrPedido;
    try
     qryAux.ExecSQL;
    except
      ShowMessage('Erro ao tentar remover os item do Pedido!');
      FDTransaction.RollbackRetaining;
      vControle := False;
    end;
  end;

  if vControle = True then
  begin
    FDTransaction.CommitRetaining;
    prcBuscaPedido('-1','-1');
  end;

 finally
   qryAux.Free;
 end;

end;

function TDM.funCampoObrigatorios(qryFoco : TClientDataSet):Boolean;
var
 vCont : Integer;
begin
  Result := True;
  for vCont := 0 to qryFoco.FieldCount - 1 do
  begin
   if  TRIM(qryFoco.Fields[vCont].AsString) = '' then
   begin
    if qryFoco.Fields[vCont].Required = True then
    begin
      Result:=False;
      ShowMessage('É obrigatório o preenchimento do campo: ' + qryFoco.Fields[vCont].DisplayLabel + '.');
      qryFoco.Fields[vCont].FocusControl;
      Exit;
    end;

   end;
  end;

end;

end.
