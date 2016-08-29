unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AppEvnts, ExtCtrls;

type
  TWorkPlaceForm = class(TForm)
    ApplicationEvents: TApplicationEvents;
    rdAttracsOffice: TRadioButton;
    rdIndolaOffice: TRadioButton;
    rdJorvasOffice: TRadioButton;
    rdOutOfOffice: TRadioButton;
    rdUnkown: TRadioButton;
    TrayIcon: TTrayIcon;
    procedure DecideConnection(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
  public
    procedure AfterConstruction; override;
  end;

var
  WorkPlaceForm: TWorkPlaceForm;

implementation

uses
  ActiveX,
  ComObj,
  IsConnected,
  Registry,
  ListTypes;

{$R *.dfm}

procedure TWorkPlaceForm.AfterConstruction;
begin
  inherited;
  case GetTypes of
    INDOLAOFFICE:
      rdIndolaOffice.Checked := True;
    JORVASOFFICE:
      rdAttracsOffice.Checked := True;
    ATTRACSOFFICE:
      rdAttracsOffice.Checked := True;
    OUTOFOFFICE:
      rdOutOfOffice.Checked := True;
    UNKNOWN:
      rdUnkown.Checked := True;
  end;
end;

procedure TWorkPlaceForm.ApplicationEventsMinimize(Sender: TObject);
begin
  Hide;
  WindowState := wsMinimized;
  TrayIcon.Visible := True;
  TrayIcon.ShowBalloonHint;
end;

procedure TWorkPlaceForm.DecideConnection(Sender: TObject);
begin
  case GetTypes of
    INDOLAOFFICE:
      rdIndolaOffice.Checked := True;
    OUTOFOFFICE:
      rdOutOfOffice.Checked := True;
    UNKNOWN:
      rdUnkown.Checked := True;
  end;
end;

procedure TWorkPlaceForm.TrayIconClick(Sender: TObject);
begin
  TrayIcon.Visible := False;
  Show;
  WindowState := wsNormal;
  Application.BringToFront;
end;

end.
