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
function IsOnDomain(DomainType: NLM_DOMAIN_TYPE): Boolean;

implementation

uses
  SysUtils,
  Classes,
  Dialogs,
  Windows, IniFiles;

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
const
  cnDistanceWork = 'DistanceWork';
  cnIndolaOffice = 'IndolaOffice';
  cnAttracsOffice = 'AttracsOffice';
  cnDomain = 'DomainNetWork';
  cnNetworkName = 'NetworkName';
  cnDummy = 'Dummy';
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
            (Inifile.ReadString(cnIndolaOffice, cnNetworkName, cnDummy) = vNetworkName) then
      Result := INDOLAOFFICE
    else if (Inifile.ReadBool(cnIndolaOffice, cnDomain, False) = vIsOnDomain) and
            (Inifile.ReadString(cnIndolaOffice, cnNetworkName, cnDummy) = vNetworkName) then
      Result := JORVASOFFICE
    else if (Inifile.ReadBool(cnAttracsOffice, cnDomain, False) = vIsOnDomain) and
            (Inifile.ReadString(cnAttracsOffice, cnNetworkName, cnDummy) = vNetworkName) then
      Result := ATTRACSOFFICE
    else if (Inifile.ReadBool(cnDistanceWork, cnDomain, False) = vIsOnDomain) and
       (Inifile.ReadString(cnDistanceWork, cnNetworkName, cnDummy) = vNetworkName)then
      Result := OUTOFOFFICE;
  end;
end;

initialization
  Inifile := TMemIniFile.Create('DecideWorkPlace.ini');

Finalization
  FreeAndNil(Inifile);
  
end.
