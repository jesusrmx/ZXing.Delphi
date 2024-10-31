unit MainForm;

interface

uses
  SysUtils, Variants, Classes, Graphics, FileUtil,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TmainFrm = class(TForm)
    image: TImage;
    Log: TMemo;
    bottomPanel: TPanel;
    Splitter_38A8D14A: TSplitter;
    btnLoadFromFile: TButton;
    openDlg: TOpenDialog;
    procedure btnLoadFromFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainFrm: TmainFrm;

implementation
uses
    fpImage, FPReadPNG, FPReadGIF, FPReadJPEG,
     ZXing.ReadResult,
     ZXing.BarcodeFormat,
     ZXing.ScanManager;


{$R *.lfm}

procedure TmainFrm.btnLoadFromFileClick(Sender: TObject);
var  ReadResult: TReadResult;
     ScanManager: TScanManager;
     img: TFPMemoryImage;
     reader: TFPReaderJPEG;
     aFile: string;
begin
  //aFile := ExpandFileName(ProgramDirectoryWithBundle + '../../UnitTest/Images/EAN_8690504009085-v2.png');
  aFile := ExpandFileName(ProgramDirectoryWithBundle + '../../UnitTest/Images/beantest.jpg');

  img := TFPMemoryImage.Create(0, 0);
  img.LoadFromFile(aFile);
  //img.LoadFromFile(openDlg.FileName);
  ReadResult := nil;
  ScanManager := nil;
  try
    ScanManager := TScanManager.Create(TBarcodeFormat.Auto, nil);
    ReadResult := ScanManager.Scan(img);
    if ReadResult<>nil then
      log.Lines.Text := ReadResult.text
    else
      log.Lines.Text := 'Unreadable!';
  finally
  	img.Free;
    ScanManager.Free;
    ReadResult.Free;
  end;
end;

end.
