unit zxing_laz_test;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, FileUtil,
  Graphics,
  Generics.Collections,
  ZXing.DecodeHintType,
  ZXing.ScanManager,
  ZXing.BarcodeFormat,
  ZXing.ResultPoint,
  ZXing.ReadResult;

type

  TZXingDelphiTest= class(TTestCase)
  private
    function GetImage(Filename: string): TBitmap;
    function Decode(Filename: String; CodeFormat: TBarcodeFormat; additionalHints: TDictionary<TDecodeHintType, TObject> = nil): TReadResult;
  public
    class var fLastFilename: string;
    class procedure AssertNotNull(aResult: TReadResult; msg:string); overload;
    class procedure AssertTrue(aCondition: boolean; msg: string); overload;
  published
    procedure AllCode39;
  end;

implementation

function TZXingDelphiTest.GetImage(Filename:string):TBitmap;
var
  pic: TPicture;
  fs: string;
begin
  pic := TPicture.Create;
  try
    fLastFilename := filename;
    fs := ExpandFileName(ProgramDirectoryWithBundle + 'Images/' + filename);
    pic.LoadFromFile(fs);
    result := TBitmap.Create;
    result.Assign(pic.Graphic);
  finally
    pic.Free;
  end;
end;

function TZXingDelphiTest.Decode(Filename:String;CodeFormat:TBarcodeFormat;
  additionalHints:TDictionary<TDecodeHintType,TObject>):TReadResult;
var
  bmp: TBitmap;
  ScanManager: TScanManager;
begin
  bmp := GetImage(Filename);
  try
    ScanManager := TScanManager.Create(CodeFormat, additionalHints);
    result := ScanManager.Scan(bmp);
  finally
    FreeAndNil(bmp);
    FreeAndNil(ScanManager);
  end;
end;

class procedure TZXingDelphiTest.AssertNotNull(aResult:TReadResult;msg:string);
begin
  AssertNotNull(fLastFilename+':'+msg, aResult);
end;

class procedure TZXingDelphiTest.AssertTrue(aCondition:boolean;msg:string);
begin
  AssertTrue(msg, aCondition);
end;

procedure TZXingDelphiTest.AllCode39;
var
  result: TReadResult;
begin
  try
    result := Decode('code39.png', TBarcodeFormat.CODE_39);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('1234567'), 'Code 39 result Text incorrect: ' + result.Text);
  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('code39 ABC 123456789.png', TBarcodeFormat.CODE_39);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('ABC 123456789'), 'Code 39 result Text incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('code39 Hello World.png', TBarcodeFormat.CODE_39);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('HELLO $WORLD$'), 'Code 39 result Text incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('code39HiddenInBottom.png', TBarcodeFormat.CODE_39);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('HELLO $WORLD$'), 'Code 39 result Text incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('Code 39 Axtel.png', TBarcodeFormat.CODE_39);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Contains('AXTEL'), 'Code 39 result Text incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;
end;



initialization

  RegisterTest(TZXingDelphiTest);
end.

