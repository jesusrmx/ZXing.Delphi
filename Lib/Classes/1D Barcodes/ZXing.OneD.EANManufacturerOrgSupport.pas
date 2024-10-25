{
  * Copyright 2010 ZXing authors
  *
  * Licensed under the Apache License, Version 2.0 (the "License");
  * you may not use this file except in compliance with the License.
  * You may obtain a copy of the License at
  *
  *      http://www.apache.org/licenses/LICENSE-2.0
  *
  * Unless required by applicable law or agreed to in writing, software
  * distributed under the License is distributed on an "AS IS" BASIS,
  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  * See the License for the specific language governing permissions and
  * limitations under the License.

  * Original Author: Sean Owen
  * Delphi Implementation by K. Gossens
}

unit ZXing.OneD.EANManufacturerOrgSupport;

{$IFDEF FPC}{$Mode Delphi}{$ENDIF}

interface

uses
  SysUtils,
  Classes,
  Generics.Collections,
  Math,
  ZXing.Common.Types,
  ZXing.OneD.UPCEANExtension2Support,
  ZXing.OneD.UPCEANExtension5Support,
  ZXing.Reader,
  ZXing.BinaryBitmap,
  ZXing.ReadResult,
  ZXing.DecodeHintType,
  ZXing.ResultMetadataType,
  ZXing.ResultPoint,
  ZXing.Common.BitArray,
  ZXing.Common.Detector.MathUtils;

type
  // <summary>
  /// Records EAN prefix to GS1 Member Organization, where the member organization
  /// correlates strongly with a country. This is an imperfect means of identifying
  /// a country of origin by EAN-13 barcode value. See
  /// <a href="http://en.wikipedia.org/wiki/List_of_GS1_country_codes">
  /// http://en.wikipedia.org/wiki/List_of_GS1_country_codes</a>.
  /// </summary>
  TEANManufacturerOrgSupport = class sealed
  private
  var
    ranges: TList<TIntArray>;
    countryIdentifiers: TStringList;

    procedure add(const range: TIntArray; const id: string);
    procedure initIfNeeded;
  public
    constructor Create;
    destructor Destroy; override;

    function lookupCountryIdentifier(const productCode: String): String;
  end;

implementation

{ TEANManufacturerOrgSupport }

constructor TEANManufacturerOrgSupport.Create;
begin
  ranges := TList <TIntArray>.Create;
  countryIdentifiers := TStringList.Create;
end;

destructor TEANManufacturerOrgSupport.Destroy;
begin
  countryIdentifiers.Free;
  ranges.Free;
  inherited;
end;

function TEANManufacturerOrgSupport.lookupCountryIdentifier(const productCode
  : String): String;
var
  i, prefix, max: Integer;
  range: TIntArray;
  start, ending: Integer;
begin
  Result := '';

  initIfNeeded;
  prefix := Integer.Parse(productCode.Substring(0, 3));
  max := ranges.Count;
  for i := 0 to Pred(max) do
  begin
    range := ranges[i];
    start := range[0];
    if (prefix < start) then
      exit;
    if (Length(range) = 1) then
      ending := start
    else
      ending := range[1];
    if (prefix <= ending) then
    begin
      Result := countryIdentifiers[i];
      break;
    end;
  end;
end;

procedure TEANManufacturerOrgSupport.add(const range: TIntArray;
  const id: string);
begin
  ranges.add(range);
  countryIdentifiers.add(id);
end;

procedure TEANManufacturerOrgSupport.initIfNeeded;
begin
  if (ranges.Count = 0) then
  begin
    add(TIntArray.Create(0, 19), 'US/CA');
    add(TIntArray.Create(30, 39), 'US');
    add(TIntArray.Create(60, 139), 'US/CA');
    add(TIntArray.Create(300, 379), 'FR');
    add(TIntArray.Create(380), 'BG');
    add(TIntArray.Create(383), 'SI');
    add(TIntArray.Create(385), 'HR');
    add(TIntArray.Create(387), 'BA');
    add(TIntArray.Create(400, 440), 'DE');
    add(TIntArray.Create(450, 459), 'JP');
    add(TIntArray.Create(460, 469), 'RU');
    add(TIntArray.Create(471), 'TW');
    add(TIntArray.Create(474), 'EE');
    add(TIntArray.Create(475), 'LV');
    add(TIntArray.Create(476), 'AZ');
    add(TIntArray.Create(477), 'LT');
    add(TIntArray.Create(478), 'UZ');
    add(TIntArray.Create(479), 'LK');
    add(TIntArray.Create(480), 'PH');
    add(TIntArray.Create(481), 'BY');
    add(TIntArray.Create(482), 'UA');
    add(TIntArray.Create(484), 'MD');
    add(TIntArray.Create(485), 'AM');
    add(TIntArray.Create(486), 'GE');
    add(TIntArray.Create(487), 'KZ');
    add(TIntArray.Create(489), 'HK');
    add(TIntArray.Create(490, 499), 'JP');
    add(TIntArray.Create(500, 509), 'GB');
    add(TIntArray.Create(520), 'GR');
    add(TIntArray.Create(528), 'LB');
    add(TIntArray.Create(529), 'CY');
    add(TIntArray.Create(531), 'MK');
    add(TIntArray.Create(535), 'MT');
    add(TIntArray.Create(539), 'IE');
    add(TIntArray.Create(540, 549), 'BE/LU');
    add(TIntArray.Create(560), 'PT');
    add(TIntArray.Create(569), 'IS');
    add(TIntArray.Create(570, 579), 'DK');
    add(TIntArray.Create(590), 'PL');
    add(TIntArray.Create(594), 'RO');
    add(TIntArray.Create(599), 'HU');
    add(TIntArray.Create(600, 601), 'ZA');
    add(TIntArray.Create(603), 'GH');
    add(TIntArray.Create(608), 'BH');
    add(TIntArray.Create(609), 'MU');
    add(TIntArray.Create(611), 'MA');
    add(TIntArray.Create(613), 'DZ');
    add(TIntArray.Create(616), 'KE');
    add(TIntArray.Create(618), 'CI');
    add(TIntArray.Create(619), 'TN');
    add(TIntArray.Create(621), 'SY');
    add(TIntArray.Create(622), 'EG');
    add(TIntArray.Create(624), 'LY');
    add(TIntArray.Create(625), 'JO');
    add(TIntArray.Create(626), 'IR');
    add(TIntArray.Create(627), 'KW');
    add(TIntArray.Create(628), 'SA');
    add(TIntArray.Create(629), 'AE');
    add(TIntArray.Create(640, 649), 'FI');
    add(TIntArray.Create(690, 695), 'CN');
    add(TIntArray.Create(700, 709), 'NO');
    add(TIntArray.Create(729), 'IL');
    add(TIntArray.Create(730, 739), 'SE');
    add(TIntArray.Create(740), 'GT');
    add(TIntArray.Create(741), 'SV');
    add(TIntArray.Create(742), 'HN');
    add(TIntArray.Create(743), 'NI');
    add(TIntArray.Create(744), 'CR');
    add(TIntArray.Create(745), 'PA');
    add(TIntArray.Create(746), 'DO');
    add(TIntArray.Create(750), 'MX');
    add(TIntArray.Create(754, 755), 'CA');
    add(TIntArray.Create(759), 'VE');
    add(TIntArray.Create(760, 769), 'CH');
    add(TIntArray.Create(770), 'CO');
    add(TIntArray.Create(773), 'UY');
    add(TIntArray.Create(775), 'PE');
    add(TIntArray.Create(777), 'BO');
    add(TIntArray.Create(779), 'AR');
    add(TIntArray.Create(780), 'CL');
    add(TIntArray.Create(784), 'PY');
    add(TIntArray.Create(785), 'PE');
    add(TIntArray.Create(786), 'EC');
    add(TIntArray.Create(789, 790), 'BR');
    add(TIntArray.Create(800, 839), 'IT');
    add(TIntArray.Create(840, 849), 'ES');
    add(TIntArray.Create(850), 'CU');
    add(TIntArray.Create(858), 'SK');
    add(TIntArray.Create(859), 'CZ');
    add(TIntArray.Create(860), 'YU');
    add(TIntArray.Create(865), 'MN');
    add(TIntArray.Create(867), 'KP');
    add(TIntArray.Create(868, 869), 'TR');
    add(TIntArray.Create(870, 879), 'NL');
    add(TIntArray.Create(880), 'KR');
    add(TIntArray.Create(885), 'TH');
    add(TIntArray.Create(888), 'SG');
    add(TIntArray.Create(890), 'IN');
    add(TIntArray.Create(893), 'VN');
    add(TIntArray.Create(896), 'PK');
    add(TIntArray.Create(899), 'ID');
    add(TIntArray.Create(900, 919), 'AT');
    add(TIntArray.Create(930, 939), 'AU');
    add(TIntArray.Create(940, 949), 'AZ');
    add(TIntArray.Create(955), 'MY');
    add(TIntArray.Create(958), 'MO');
  end;
end;

end.
