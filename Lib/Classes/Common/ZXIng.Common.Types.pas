unit ZXIng.Common.Types;

{$IFDEF FPC}{$Mode Delphi}{$ENDIF}

interface

uses
  {$IFDEF FRAMEWORK_VCL}
  System.SysUtils,
  System.Generics.Collections,
  {$ENDIF}
  {$IFDEF FRAMEWORK_LCL}
  SysUtils,
  Generics.Collections;
  {$ENDIF}

type
  {$IFDEF FPC}
  TBytesArray = array of Byte;
  TIntArray = array of Integer;
  T2DIntArray = array of TIntArray;
  {$ELSE}
  TBytesArray = TArray<Byte>;
  TIntArray = TArray<Integer>;
  T2DIntArray = TArray<TArray<Integer>>;
  {$ENDIF}

  procedure SaveStringToFile(aFilename, s:String);

implementation

uses classes;

procedure SaveStringToFile(aFilename, s:String);
var
  st: TStringStream;
begin
  st := TStringStream.Create(s);
  try
    st.SaveToFile(aFilename);
  finally
    st.Free;
  end;
end;

end.

