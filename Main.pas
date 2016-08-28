unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button2: TButton;
    rdIndolaOffice: TRadioButton;
    rdOutOfOffice: TRadioButton;
    rdUnkown: TRadioButton;
    procedure DecideConnection(Sender: TObject);
  end;

var
  Form2: TForm2;

implementation

uses
  ActiveX,
  ComObj,
  IsConnected,
  ListTypes;

{$R *.dfm}


procedure TForm2.DecideConnection(Sender: TObject);
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

end.
