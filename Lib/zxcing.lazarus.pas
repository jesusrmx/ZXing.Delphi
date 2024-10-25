{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit ZXCing.Lazarus;

{$warn 5023 off : no warning about unused units}
interface

uses
  ZXing.OneD.Code128Reader, ZXing.OneD.Code39Reader, ZXing.OneD.Code93Reader, 
  ZXing.OneD.EAN13Reader, ZXing.OneD.EAN8Reader, 
  ZXing.OneD.EANManufacturerOrgSupport, ZXing.OneD.ITFReader, 
  ZXing.OneD.OneDReader, ZXing.OneD.UPCAReader, 
  ZXing.OneD.UPCEANExtension2Support, ZXing.OneD.UPCEANExtension5Support, 
  ZXing.OneD.UPCEANExtensionSupport, ZXing.OneD.UPCEANReader, 
  ZXing.OneD.UPCEReader, ZXing.Datamatrix.Internal.BitMatrixParser, 
  ZXing.Datamatrix.Internal.DataBlock, 
  ZXing.Datamatrix.Internal.DecodedBitStreamParser, 
  ZXing.Datamatrix.Internal.Decoder, ZXing.Datamatrix.Internal.Version, 
  ZXing.QrCode.Internal.BitMatrixParser, ZXing.QrCode.Internal.DataBlock, 
  ZXing.QrCode.Internal.DataMask, 
  ZXing.QrCode.Internal.DecodedBitStreamParser, ZXing.QrCode.Internal.Decoder, 
  ZXing.QrCode.Internal.ErrorCorrectionLevel, 
  ZXing.QrCode.Internal.FormatInformation, ZXing.QrCode.Internal.Mode, 
  ZXing.QrCode.Internal.QRCodeDecoderMetaData, ZXing.QrCode.Internal.Version, 
  ZXing.Datamatrix.Internal.Detector, ZXing.QrCode.Internal.AlignmentPattern, 
  ZXing.QrCode.Internal.AlignmentPatternFinder, 
  ZXing.QrCode.Internal.AlignmentPatternImplementation, 
  ZXing.QrCode.Internal.Detector, ZXing.QrCode.Internal.FinderPattern, 
  ZXing.QrCode.Internal.FinderPatternFinder, 
  ZXing.QrCode.Internal.FinderPatternImplementation, 
  ZXing.QrCode.Internal.FinderPatternInfo, ZXing.Datamatrix.DataMatrixReader, 
  ZXing.QrCode.QRCodeReader, ZXing.Common.Detector.MathUtils, 
  ZXing.Common.Detector.WhiteRectangleDetector, 
  ZXing.Common.ReedSolomon.GenericGF, 
  ZXing.Common.ReedSolomon.ReedSolomonDecoder, ZXing.BarcodeFormat, 
  ZXing.BitSource, ZXIng.ByteSegments, ZXing.CharacterSetECI, 
  ZXing.Common.BitArray, ZXing.Common.BitArrayImplementation, 
  ZXing.Common.BitMatrix, ZXing.Common.DetectorResult, 
  ZXing.Common.GridSampler, ZXing.Common.PerspectiveTransform, 
  ZXIng.Common.Types, ZXing.DecodeHintType, ZXing.DecoderResult, 
  ZXing.DefaultGridSampler, ZXing.EncodeHintType, ZXing.Helpers, 
  ZXing.MultiFormatReader, ZXing.Reader, ZXing.ReadResult, 
  ZXing.ResultMetadataType, ZXing.ResultPoint, 
  ZXing.ResultPointImplementation, ZXing.StringUtils, 
  ZXing.BaseLuminanceSource, ZXing.Binarizer, ZXing.BinaryBitmap, 
  ZXing.GlobalHistogramBinarizer, ZXing.HybridBinarizer, 
  ZXing.InvertedLuminanceSource, ZXing.LuminanceSource, 
  ZXing.PlanarYUVLuminanceSource, ZXing.RGBLuminanceSource, ZXing.ScanManager, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('ZXCing.Lazarus', @Register);
end.
