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

implementation

end.

