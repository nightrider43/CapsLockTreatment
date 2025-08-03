unit unTrataCapsLock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Windows;

type

  { TfrmTrataCapsLock }

  TfrmTrataCapsLock = class(TForm)
    edtIndicaNumLock: TEdit;
    edtIndicaCapsLock: TEdit;
    Timer1: TTimer;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    // Variáveis para controlar o arrasto
    FDragging: Boolean;
    FDragStartPos: TPoint;
    FFormStartPos: TPoint;
    function IsCapsLockOn: Boolean;
    function IsNumLockOn: Boolean;
  public

  end;

var
  frmTrataCapsLock: TfrmTrataCapsLock;

implementation

{$R *.lfm}

{ TfrmTrataCapsLock }

function TfrmTrataCapsLock.IsCapsLockOn: Boolean;
begin
  Result := (GetKeyState(VK_CAPITAL) and 1) = 1;
end;

function TfrmTrataCapsLock.IsNumLockOn: Boolean;
begin
  Result := (GetKeyState(VK_NUMLOCK) and 1) = 1;
end;

procedure TfrmTrataCapsLock.Timer1Timer(Sender: TObject);
// Pelo que entendi o componente Timer gera interrupções a cada 200
// milisegundos e então este método é executado.
// Os 200 miliseundos são definidos nas propriedades do componente Timer
begin
  if IsCapsLockOn then
     begin
       edtIndicaCapsLock.Text := 'On';
       edtIndicaCapsLock.Color := clAqua;
     end
   else
      begin
        edtIndicaCapsLock.Text := 'Off';
        edtIndicaCapsLock.Color := clWindow;
      end;
   if IsNumLockOn then
      begin
        edtIndicaNumLock.Text := 'On';
        edtIndicaNumLock.Color := clAqua;
      end
    else
       begin
         edtIndicaNumLock.Text := 'Off';
         edtIndicaNumLock.Color := clWindow;
       end;
end;

procedure TfrmTrataCapsLock.FormCreate(Sender: TObject);
begin
  // Comentado temporariamente para teste
  // frmTrataCapsLock.Icon.LoadFromFile('icon_caps_lock.ico');

  // Inicializa as variáveis de controle do arrasto
  FDragging := False;
end;

procedure TfrmTrataCapsLock.FormActivate(Sender: TObject);
begin
  // Força a visibilidade do formulário
  Self.WindowState := wsNormal;
  Self.Left := 200;
  Self.Top := 200;
  Self.Visible := True;
  Self.Show;
  Self.BringToFront;
  FormStyle := fsNormal;
end;

// NOVOS MÉTODOS PARA IMPLEMENTAR O ARRASTO

procedure TfrmTrataCapsLock.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // Só inicia o arrasto se for o botão esquerdo do mouse
  if Button = mbLeft then
  begin
    FDragging := True;
    // Armazena a posição onde o mouse foi clicado no formulário
    FDragStartPos.X := X;
    FDragStartPos.Y := Y;
    // Armazena a posição atual do formulário na tela
    FFormStartPos.X := Self.Left;
    FFormStartPos.Y := Self.Top;
    // Captura o mouse para este formulário
    SetCapture(Handle);
  end;
end;

procedure TfrmTrataCapsLock.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  NewLeft, NewTop: Integer;
begin
  // Só move o formulário se estiver no modo de arrasto
  if FDragging then
  begin
    // Calcula a nova posição do formulário baseada no movimento do mouse
    NewLeft := FFormStartPos.X + (X - FDragStartPos.X);
    NewTop := FFormStartPos.Y + (Y - FDragStartPos.Y);

    // Move o formulário para a nova posição
    Self.Left := NewLeft;
    Self.Top := NewTop;
  end;
end;

procedure TfrmTrataCapsLock.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  // Para o arrasto quando o botão do mouse for solto
  if Button = mbLeft then
  begin
    FDragging := False;
    // Libera a captura do mouse
    ReleaseCapture;
  end;
end;

procedure TfrmTrataCapsLock.FormShow(Sender: TObject);
var ScreenHeight : Integer;
begin
  // Obtém a altura da tela principal
  ScreenHeight := GetSystemMetrics(SM_CYSCREEN);

  // Define a altura do formulário próximo à parte inferior da tela
  // Vamos deixar uma margem de 50 pixels acima da borda inferior
  Top := ScreenHeight - Height - 50;

  // Opcional: Posiciona horizontalmente
  Left := (Screen.Width - Width) div 4;
end;

end.
