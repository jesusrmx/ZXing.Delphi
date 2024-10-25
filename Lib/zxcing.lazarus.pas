{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ZXCing.Lazarus;

{$warn 5023 off : no warning about unused units}
interface

uses
  ZXing.ScanManager, ZXIng.Common.Types, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ZXCing.Lazarus', @Register);
end.
