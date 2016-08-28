program DecideWorkingPlace;

uses
  Forms,
  Main in 'Main.pas' {WorkPlaceForm},
  NETWORKLIST_TLB in 'NETWORKLIST_TLB.pas',
  ListTypes in 'ListTypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'DecideWorkingPlace';
  Application.CreateForm(TWorkPlaceForm, WorkPlaceForm);
  Application.Run;
end.
