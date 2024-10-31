unit zxing_laz_test;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, FileUtil,
  FPImage,FPReadPNG,FPReadBMP,FPReadJPEG,FPReadTiff,FPReadGif,
  Generics.Collections,
  ZXing.DecodeHintType,
  ZXing.ScanManager,
  ZXing.BarcodeFormat,
  ZXing.ResultPoint,
  ZXing.ReadResult;

type

  { TZXingDelphiTest }

  TZXingDelphiTest= class(TTestCase)
  private
    function GetImage(Filename: string): TFPCustomImage;
    function Decode(Filename: String; CodeFormat: TBarcodeFormat; additionalHints: TDictionary<TDecodeHintType, TObject> = nil): TReadResult;
  public
    class var fLastFilename: string;
    class procedure AssertNotNull(aResult: TReadResult; msg:string); overload;
    class procedure AssertNull(aResult: TReadResult; msg:string); overload;
    class procedure AssertTrue(aCondition: boolean; msg: string); overload;
    class procedure AssertEquals(Expected, Actual: unicodestring; ignorecase:boolean); overload;
    class procedure AssertContains(str, substr: string; ignorecase:boolean);
  published
    procedure AllCode39;
    procedure AllUpcA;
    procedure AllUpcE;
    procedure AllQRCode;
    procedure All_PURE_QRCode;
  end;

implementation

function TZXingDelphiTest.GetImage(Filename:string):TFPCustomImage;
var
  fs: string;
begin
  fLastFilename := filename;
  fs := ExpandFileName(ProgramDirectoryWithBundle + 'Images/' + filename);
  result := TFPMemoryImage.Create(10, 10);
  result.LoadFromFile(fs);
end;

function TZXingDelphiTest.Decode(Filename:String;CodeFormat:TBarcodeFormat;
  additionalHints:TDictionary<TDecodeHintType,TObject>):TReadResult;
var
  img: TFPCustomImage;
  ScanManager: TScanManager;
begin
  img := GetImage(Filename);
  try
    ScanManager := TScanManager.Create(CodeFormat, additionalHints);
    result := ScanManager.Scan(img);
  finally
    FreeAndNil(img);
    FreeAndNil(ScanManager);
  end;
end;

class procedure TZXingDelphiTest.AssertNotNull(aResult:TReadResult;msg:string);
begin
  AssertNotNull(fLastFilename+':'+msg, aResult);
end;

class procedure TZXingDelphiTest.AssertNull(aResult: TReadResult; msg: string);
begin
  AssertNull(fLastFilename+':'+msg, aResult);
end;

class procedure TZXingDelphiTest.AssertTrue(aCondition:boolean;msg:string);
begin
  AssertTrue(msg, aCondition);
end;

class procedure TZXingDelphiTest.AssertEquals(Expected,Actual:unicodestring;
  ignorecase:boolean);
begin
  AssertEquals('---', Expected, Actual);
end;

class procedure TZXingDelphiTest.AssertContains(str, substr: string;
  ignorecase: boolean);
begin
  AssertTrue(pos(substr, str)>0);
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

procedure TZXingDelphiTest.AllUpcA;
var
  result: TReadResult;
begin
  try
    result := Decode('upca.png', TBarcodeFormat.UPC_A);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('123456789012'), 'upca result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('upcaHiddenInBottom.png', TBarcodeFormat.UPC_A);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('123456789012'), 'upca result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('upca 2.gif', TBarcodeFormat.UPC_A);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('725272730706'), 'upca 1 result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('upca 3.gif', TBarcodeFormat.UPC_A);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('232323232312'), 'upca 2 result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;
end;

procedure TZXingDelphiTest.AllUpcE;
var
  result: TReadResult;
begin
  try
    result := Decode('upce.png', TBarcodeFormat.UPC_E);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('01234565'), 'upce result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('upceHiddenInBottom.png', TBarcodeFormat.UPC_E);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('01234565'), 'upce result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('upc-e_09999008.png', TBarcodeFormat.UPC_E);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('09999008'), 'upce result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('upc-e_09999992.png', TBarcodeFormat.UPC_E);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('09999992'), 'upce result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('upce 2.png', TBarcodeFormat.UPC_E);
    AssertNotNull(result, ' nil result ');
    AssertTrue(result.Text.Equals('01234565'), 'upce result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;
end;

procedure TZXingDelphiTest.AllQRCode;
var
  result: TReadResult;
begin

  try
    result := Decode('qrcode.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://google.com'), 'QR code result Text Incorrect: ' + result.Text);
  finally
    FreeAndNil(result);
  end;

  try
    // From here a test set from: http://datagenetics.com/blog/november12013/index.html
    // Please take a look of what QR can do for you
    // NOTE: some test are expected to fail and are setup as such.

    // !Cancelled for test. Does not work with zxing.net either.
    // Rotation does not work.
    // result := Decode('q3.png', TBarcodeFormat.QR_CODE);
    // AssertNotNull(result, ' Nil result ');
    // AssertTrue(result.Text.Equals('http://DataGenetics.com'),
    // 'QR code result Text Incorrect: ' + result.Text);

    result := Decode('q33.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');

    AssertTrue(result.Text.Equals('Never gonna give you up, ' + #$D + 'Never gonna let you down ' + #$D + 'Never gonna run around and desert you ' + #$D + 'Never gonna make you cry, ' + #$D +
      'Never gonna say goodbye ' + #$D + 'Never gonna tell a lie and hurt you'), 'QR code result Text Incorrect: ' + result.Text);



  finally
    FreeAndNil(result);
  end;

  result := Decode('problem-qr-android 64bit.png', TBarcodeFormat.QR_CODE);
  try
    AssertNotNull(result, ' Nil result ');
  	AssertTrue(result.Text.Contains('http://sintest/'), 'QR code result Text Incorrect: ' + result.Text);
  finally
  	FreeAndNil(result);
  end;

  result := Decode('problem-qr-IOS 64bit.png', TBarcodeFormat.QR_CODE);
  try
    AssertNotNull(result, ' Nil result ');
  	AssertTrue(result.Text.Contains('SPD*'), 'QR code result Text Incorrect: ' + result.Text);
  finally
  	FreeAndNil(result);
  end;


  try
    result := Decode('q1.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q2.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q2q.png', TBarcodeFormat.QR_CODE); // rotate 90 degrees
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q2m.png', TBarcodeFormat.QR_CODE); // rotate 120 degrees
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q4.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q5.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    // fails on example website but does work!
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q6.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q7.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q8.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q9.png', TBarcodeFormat.QR_CODE);
    AssertNull(result, ' Should be nil result. Missing possition block ');

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q10.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q11.png', TBarcodeFormat.QR_CODE);
    AssertNull(result, ' The code should not scan ');

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q12.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q13.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q14.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q15.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q16.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q17.png', TBarcodeFormat.QR_CODE);
    AssertNull(result, ' Should not scan ');

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q18.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q21.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q22.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q23.png', TBarcodeFormat.QR_CODE);
    AssertNull(result, ' to dizzy to scan');

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q25.png', TBarcodeFormat.QR_CODE);
    AssertNull(result, 'Should not scan');

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q28.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q29.png', TBarcodeFormat.QR_CODE);
    AssertNull(result, 'Should not scan');

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q30.png', TBarcodeFormat.QR_CODE);
    AssertNull(result, 'Should not be scanned');

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q31.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('q32.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('qr-1.jpg', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('1'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('qr-a1.jpg', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('a1'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('qr-1a.jpg', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('1a'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('qr-12.jpg', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('12'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('QRHiddenInBottom.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Equals('http://DataGenetics.com'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('big QR.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Contains('Version 40 QR Code can contain up to 1852 chars.'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('CarloTest.jpg', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Contains('gov.it'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('QR_Droid_2663.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Contains('Version 40 QR Code'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('utf8-test.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertEquals(#$0440#$0443#$0301#$0441#$0441#$043A#$0438#$0439#$20#$044F#$0437#$044B#$0301#$043A#$2C#$20'russkij'#$20'jazyk'#$20#$E8#$E0#$F2#$F9, result.Text, false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('contact information.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, 'Joe@bloggs.com', false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('Calendar.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, 'Christmas', false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('GeoLocation.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, '52.052490', false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('SMS.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, '0777777', false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('url.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, 'meetheed.com', false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('email.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, 'joe@bloggs.com', false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('phone.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, '077777777', false);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('Text.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result ');
    AssertContains(result.Text, 'just a lot of plain text', false);

  finally
    FreeAndNil(result);
  end;


   try
    result := Decode('QR-bug-overflow.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result');
    AssertContains(result.Text, '1653015096', false);

  finally
    FreeAndNil(result);
  end;


    try
    result := Decode('QRContainsHex10.png', TBarcodeFormat.QR_CODE);
    AssertNotNull(result, ' Nil result');
    AssertContains(result.Text, '140#104#20231123 09:00:00', false);
  finally
    FreeAndNil(result);
  end;

end;

procedure TZXingDelphiTest.All_PURE_QRCode;
var
  result: TReadResult;
  hints: TDictionary<TDecodeHintType, TObject>;
begin

  hints := TDictionary<TDecodeHintType, TObject>.Create();
  hints.Add(TDecodeHintType.PURE_BARCODE, nil);

  try
    result := Decode('problem-qr-android 64bit.png', TBarcodeFormat.QR_CODE, hints);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Contains('http://sintest/'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

  hints := TDictionary<TDecodeHintType, TObject>.Create();
  hints.Add(TDecodeHintType.PURE_BARCODE, nil);

  try
    result := Decode('beantest.jpg', TBarcodeFormat.QR_CODE, hints);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Contains('ivaservizi.'), 'QR code result Text Incorrect: ' + result.Text);

    hints := TDictionary<TDecodeHintType, TObject>.Create();
    hints.Add(TDecodeHintType.PURE_BARCODE, nil);

  finally
    FreeAndNil(result);
  end;

  try
    result := Decode('qr problem 1.jpg', TBarcodeFormat.QR_CODE, hints);
    AssertNotNull(result, ' Nil result ');
    AssertTrue(result.Text.Contains('gov.it/'), 'QR code result Text Incorrect: ' + result.Text);

  finally
    FreeAndNil(result);
  end;

end;


initialization

  RegisterTest(TZXingDelphiTest);
end.

