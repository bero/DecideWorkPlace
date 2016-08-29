unit ListTypes;

interface

uses
  ActiveX,
  NETWORKLIST_TLB,
  ComObj;

type
  TConnectType = (INDOLAOFFICE, JORVASOFFICE, ATTRACSOFFICE, OUTOFOFFICE, UNKNOWN);

function GetTypes: TConnectType;
function GetFirstNetWorkName: TConnectType;
function FindNetworkFromIni(const aSectionName, aRealNetWork: String): Boolean;
function IsOnDomain(DomainType: NLM_DOMAIN_TYPE): Boolean;

implementation

uses
  SysUtils,
  Classes,
  Dialogs,
  Windows, IniFiles;

const
  cnDistanceWork = 'DistanceWork';
  cnIndolaOffice = 'IndolaOffice';
  cnJorvasOffice = 'JorvasOffice';
  cnAttracsOffice = 'AttracsOffice';
  cnDomain = 'DomainNetWork';
  cnNetworkName = 'NetworkName';
  cnDummy = 'Dummy';
var
  Inifile: TMemIniFile;

function GetTypes: TConnectType;
begin
  CoInitialize(nil);
  try
    Result := GetFirstNetWorkName;
  finally
    CoUninitialize;
  end;
end;

function IsOnDomain(DomainType: NLM_DOMAIN_TYPE): Boolean;
begin
  Result := DomainType = NLM_DOMAIN_TYPE_DOMAIN_NETWORK;
end;

function GetFirstNetWorkName: TConnectType;
var
  NetworkListManager: INetworkListManager;
  EnumNetworkConnections: IEnumNetworkConnections;
  NetworkConnection : INetworkConnection;
  vNetworkName: String;
  vIsOnDomain: Boolean;
  pceltFetched: ULONG;
begin
  NetworkListManager := CoNetworkListManager.Create;
  EnumNetworkConnections :=  NetworkListManager.GetNetworkConnections();
  EnumNetworkConnections.Next(1, NetworkConnection, pceltFetched);
  Result := UNKNOWN;
  if pceltFetched > 0  then
  begin
    vNetworkName := NetworkConnection.GetNetwork.GetName;
    vIsOnDomain := IsOnDomain(NetworkConnection.GetDomainType);

    if (Inifile.ReadBool(cnIndolaOffice, cnDomain, False) = vIsOnDomain) and
             FindNetworkFromIni(cnIndolaOffice, vNetworkName) then
      Result := INDOLAOFFICE
    else if (Inifile.ReadBool(cnJorvasOffice, cnDomain, False) = vIsOnDomain) and
             FindNetworkFromIni(cnJorvasOffice, vNetworkName) then
      Result := JORVASOFFICE
    else if (Inifile.ReadBool(cnAttracsOffice, cnDomain, False) = vIsOnDomain) and
             FindNetworkFromIni(cnAttracsOffice, vNetworkName) then
      Result := ATTRACSOFFICE
    else if (Inifile.ReadBool(cnDistanceWork, cnDomain, False) = vIsOnDomain) and
             FindNetworkFromIni(cnDistanceWork, vNetworkName) then
      Result := OUTOFOFFICE;
  end;
end;

function FindNetworkFromIni(const aSectionName, aRealNetWork: String): Boolean;
var
  vSettingValue: String;
  vList: TStringList;
  i: Integer;
begin
  Result := False;
  vSettingValue := Inifile.ReadString(aSectionName, cnNetworkName, cnDummy);
  vList := TStringList.Create;
  vlist.StrictDelimiter := True;
  try
    vList.CommaText := vSettingValue;
    for i := 0 to vList.Count - 1 do
      if vList[i] = aRealNetWork then
      begin
        Result := True;
        break;
      end;
  finally
    FreeAndNil(vList);
  end;
end;

initialization
  Inifile := TMemIniFile.Create('DecideWorkPlace.ini');

Finalization
  FreeAndNil(Inifile);
  
end.
