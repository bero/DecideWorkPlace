program DecideWorkingPlace;

uses
  Forms,
  Main in 'Main.pas' {Form2},
  NETWORKLIST_TLB in 'NETWORKLIST_TLB.pas',
  ListTypes in 'ListTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'DecideWorkingPlace';
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
