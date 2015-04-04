unit mnFonts;

{$mode delphi}
{**
 *  Raster/Bitmap Fonts
 *
 *  This file is part of the "Mini Library"
 *
 * @url       http://www.sourceforge.net/projects/minilib
 * @license   modifiedLGPL (modified of http://www.gnu.org/licenses/lgpl.html)
 *            See the file COPYING.MLGPL, included in this distribution,
 * @author    Zaher Dirkey <zaher at parmaja dot com>
 *}

interface

uses
  SysUtils, Classes, Graphics, FPCanvas;

type

  { TmnfRasterFont }

  TmnfRasterFont = class(TFPCustomDrawFont)
  protected
    procedure DoDrawText(x, y: Integer; Text: String); override;
    procedure DoGetTextSize(Text: String; var w, h: Integer); override;
    function DoGetTextHeight(Text: String): Integer; override;
    function DoGetTextWidth(Text: String): Integer; override;
  public
    FontBitmap: TBitmap;
    Rows, Columns: Integer;

    CharCount: Integer;
    CharWidth: Integer;
    CharHeight: Integer;
    CharStart: Integer;

    constructor Create; override;
    procedure Generate(FontName: String = 'Courier'; FontSize: integer = 10);
    procedure PrintText(Canvas: TFPCustomCanvas; x, y: Integer; Text: String);
    procedure LoadFromFile(FileName: String);
    procedure SaveToFile(FileName: String);
  end;

implementation

{ TmnfRasterFont }

procedure TmnfRasterFont.DoDrawText(x, y: Integer; Text: String);
begin
  PrintText(Canvas, x, y, Text);
end;

procedure TmnfRasterFont.DoGetTextSize(Text: String; var w, h: Integer);
begin

end;

function TmnfRasterFont.DoGetTextHeight(Text: String): Integer;
begin

end;

function TmnfRasterFont.DoGetTextWidth(Text: String): Integer;
begin

end;

constructor TmnfRasterFont.Create;
begin
  inherited Create;
  CharCount := 256;
  Columns := 16;
  Rows := 16;
  CharStart := 0;
  FontBitmap := TBitmap.Create;
  with FontBitmap do
  begin
    Width := 10;
    Height := 10;
    Canvas.Brush.Color := clWhite;
    Canvas.FillRect(0, 0, Width, Height);
    Transparent := True;
    TransParentColor := clWhite;
    TransparentMode := tmAuto;
    //Canvas.CopyRect(Rect(0, 0, Width, Height), Canvas, Rect(0, 0, w, h));
  end;
end;

procedure TmnfRasterFont.Generate(FontName: String; FontSize: integer);
var
  i, c, r: Integer;
begin
  with FontBitmap do
  begin
    Canvas.Font.Size := FontSize;
    Canvas.Font.Name := FontName;
    Canvas.Brush.Color := clWhite;
    CharWidth := Canvas.TextWidth('W');
    CharHeight := Canvas.TextHeight('W');
    Rows := round(CharCount / Columns);
    Height := CharHeight * Rows;
    Width := CharWidth * Columns;

    Canvas.FillRect(0, 0, Width, Height);

    i := 0;
    for r := 0 to Rows -1 do
      for c := 0 to Columns -1 do
      begin
        Canvas.TextOut(c * CharWidth, r * CharHeight, chr(i));
        inc(i);
      end;
  end;
end;

procedure TmnfRasterFont.PrintText(Canvas: TFPCustomCanvas; x, y: Integer; Text: String);
var
  cRect: TRect;
  i, c: Integer;
  cx, cy: Integer;
begin
  for i := 1 to Length(Text) do
  begin
    c := Ord(Text[i]);
    cy := (c div Columns) * CharHeight;
    cx := (c mod Columns) * CharWidth;
    cRect := rect(cx, cy, cx + CharWidth - 1, cy + CharHeight - 1);
    //Canvas.CopyMode := cmMergeCopy;
    Canvas.CopyRect(x, y, FontBitmap.Canvas, cRect);
    x := x + CharWidth;
  end;
end;

procedure TmnfRasterFont.LoadFromFile(fileName: String);
begin
  FreeAndNil(FontBitmap);
  FontBitmap := TBitmap.Create;
  with FontBitmap do
  begin
    LoadFromFile(FileName);
    Transparent := True;
    TransParentColor := clWhite;
    TransparentMode := tmAuto;
  end;
end;

procedure TmnfRasterFont.SaveToFile(fileName: String);
begin
  FontBitmap.SaveToFile(fileName);
end;

end.
