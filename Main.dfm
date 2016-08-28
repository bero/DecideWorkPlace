object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 269
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button2: TButton
    Left = 105
    Top = 8
    Width = 75
    Height = 25
    Caption = 'List type'
    TabOrder = 0
    OnClick = DecideConnection
  end
  object rdIndolaOffice: TRadioButton
    Left = 32
    Top = 48
    Width = 113
    Height = 17
    Caption = 'Indola Office'
    TabOrder = 1
  end
  object rdOutOfOffice: TRadioButton
    Left = 32
    Top = 71
    Width = 113
    Height = 17
    Caption = 'Out of office'
    TabOrder = 2
  end
  object rdUnkown: TRadioButton
    Left = 32
    Top = 94
    Width = 113
    Height = 17
    Caption = 'Unknown'
    TabOrder = 3
  end
end
