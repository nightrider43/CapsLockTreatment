program TrataCapsLock;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, unTrataCapsLock
  { you can add units after this };

{$R *.res}
{
--- Atenção TEdit posionado em cima do TTimer no Form
}
begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmTrataCapsLock, frmTrataCapsLock);
  Application.Run;
end.

