unit ucp1256;
{*
 * Copyright (C) 1999-2001 Free Software Foundation, Inc.
 * This file is part of the GNU LIBICONV Library.
 *
 * The GNU LIBICONV Library is free software; you can redistribute it
 * and/or modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * The GNU LIBICONV Library is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with the GNU LIBICONV Library; see the file COPYING.LIB.
 * If not, write to the Free Software Foundation, Inc., 51 Franklin Street,
 * Fifth Floor, Boston, MA 02110-1301, USA.
 *}

{*
  Ported by Zaher Dirkey zaher, zaherdirkey
  http://libiconv.cvs.sourceforge.net/*checkout*/libiconv/libiconv/lib/cp1256.h?revision=1.4
*}

{*
 * CP1256
 *}

{$ifdef FPC}
{$mode delphi}
{$endif}

interface

procedure cp1256_mbtowc(S: AnsiChar; var R: WideChar);
procedure cp1256_wctomb(S: WideChar;var R: AnsiChar);

implementation

const
  cp1256_2uni: array[0..128 - 1] of WideChar = (
  {* #$80 *}
  #$20ac, #$067e, #$201a, #$0192, #$201e, #$2026, #$2020, #$2021,
  #$02c6, #$2030, #$0679, #$2039, #$0152, #$0686, #$0698, #$0688,
  {* #$90 *}
  #$06af, #$2018, #$2019, #$201c, #$201d, #$2022, #$2013, #$2014,
  #$06a9, #$2122, #$0691, #$203a, #$0153, #$200c, #$200d, #$06ba,
  {* #$a0 *}
  #$00a0, #$060c, #$00a2, #$00a3, #$00a4, #$00a5, #$00a6, #$00a7,
  #$00a8, #$00a9, #$06be, #$00ab, #$00ac, #$00ad, #$00ae, #$00af,
  {* #$b0 *}
  #$00b0, #$00b1, #$00b2, #$00b3, #$00b4, #$00b5, #$00b6, #$00b7,
  #$00b8, #$00b9, #$061b, #$00bb, #$00bc, #$00bd, #$00be, #$061f,
  {* #$c0 *}
  #$06c1, #$0621, #$0622, #$0623, #$0624, #$0625, #$0626, #$0627,
  #$0628, #$0629, #$062a, #$062b, #$062c, #$062d, #$062e, #$062f,
  {* #$d0 *}
  #$0630, #$0631, #$0632, #$0633, #$0634, #$0635, #$0636, #$00d7,
  #$0637, #$0638, #$0639, #$063a, #$0640, #$0641, #$0642, #$0643,
  {* #$e0 *}
  #$00e0, #$0644, #$00e2, #$0645, #$0646, #$0647, #$0648, #$00e7,
  #$00e8, #$00e9, #$00ea, #$00eb, #$0649, #$064a, #$00ee, #$00ef,
  {* #$f0 *}
  #$064b, #$064c, #$064d, #$064e, #$00f4, #$064f, #$0650, #$00f7,
  #$0651, #$00f9, #$0652, #$00fb, #$00fc, #$200e, #$200f, #$06d2
);

  cp1256_page00:array[0..96 - 1] of AnsiChar = (
  #$a0, #$00, #$a2, #$a3, #$a4, #$a5, #$a6, #$a7, {* #$a0-$a7 *}
  #$a8, #$a9, #$00, #$ab, #$ac, #$ad, #$ae, #$af, {* #$a8-$af *}
  #$b0, #$b1, #$b2, #$b3, #$b4, #$b5, #$b6, #$b7, {* #$b0-$b7 *}
  #$b8, #$b9, #$00, #$bb, #$bc, #$bd, #$be, #$00, {* #$b8-$bf *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$c0-$c7 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$c8-$cf *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$d7, {* #$d0-$d7 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$d8-$df *}
  #$e0, #$00, #$e2, #$00, #$00, #$00, #$00, #$e7, {* #$e0-$e7 *}
  #$e8, #$e9, #$ea, #$eb, #$00, #$00, #$ee, #$ef, {* #$e8-$ef *}
  #$00, #$00, #$00, #$00, #$f4, #$00, #$00, #$f7, {* #$f0-$f7 *}
  #$00, #$f9, #$00, #$fb, #$fc, #$00, #$00, #$00 {* #$f8-$ff *}
);

  cp1256_page01:array[0..72 - 1] of AnsiChar = (
  #$00, #$00, #$8c, #$9c, #$00, #$00, #$00, #$00, {* #$50-$57 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$58-$5f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$60-$67 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$68-$6f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$70-$77 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$78-$7f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$80-$87 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$88-$8f *}
  #$00, #$00, #$83, #$00, #$00, #$00, #$00, #$00 {* #$90-$97 *}
);

  cp1256_page06:array[0..208 - 1] of AnsiChar = (
  #$00, #$00, #$00, #$00, #$a1, #$00, #$00, #$00, {* #$08-$0f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$10-$17 *}
  #$00, #$00, #$00, #$ba, #$00, #$00, #$00, #$bf, {* #$18-$1f *}
  #$00, #$c1, #$c2, #$c3, #$c4, #$c5, #$c6, #$c7, {* #$20-$27 *}
  #$c8, #$c9, #$ca, #$cb, #$cc, #$cd, #$ce, #$cf, {* #$28-$2f *}
  #$d0, #$d1, #$d2, #$d3, #$d4, #$d5, #$d6, #$d8, {* #$30-$37 *}
  #$d9, #$da, #$db, #$00, #$00, #$00, #$00, #$00, {* #$38-$3f *}
  #$dc, #$dd, #$de, #$df, #$e1, #$e3, #$e4, #$e5, {* #$40-$47 *}
  #$e6, #$ec, #$ed, #$f0, #$f1, #$f2, #$f3, #$f5, {* #$48-$4f *}
  #$f6, #$f8, #$fa, #$00, #$00, #$00, #$00, #$00, {* #$50-$57 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$58-$5f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$60-$67 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$68-$6f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$70-$77 *}
  #$00, #$8a, #$00, #$00, #$00, #$00, #$81, #$00, {* #$78-$7f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$8d, #$00, {* #$80-$87 *}
  #$8f, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$88-$8f *}
  #$00, #$9a, #$00, #$00, #$00, #$00, #$00, #$00, {* #$90-$97 *}
  #$8e, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$98-$9f *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$a0-$a7 *}
  #$00, #$98, #$00, #$00, #$00, #$00, #$00, #$90, {* #$a8-$af *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$b0-$b7 *}
  #$00, #$00, #$9f, #$00, #$00, #$00, #$aa, #$00, {* #$b8-$bf *}
  #$00, #$c0, #$00, #$00, #$00, #$00, #$00, #$00, {* #$c0-$c7 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$c8-$cf *}
  #$00, #$00, #$ff, #$00, #$00, #$00, #$00, #$00 {* #$d0-$d7 *}
);

  cp1256_page20:array[0..56 - 1] of AnsiChar = (
  #$00, #$00, #$00, #$00, #$9d, #$9e, #$fd, #$fe, {* #$08-$0f *}
  #$00, #$00, #$00, #$96, #$97, #$00, #$00, #$00, {* #$10-$17 *}
  #$91, #$92, #$82, #$00, #$93, #$94, #$84, #$00, {* #$18-$1f *}
  #$86, #$87, #$95, #$00, #$00, #$00, #$85, #$00, {* #$20-$27 *}
  #$00, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$28-$2f *}
  #$89, #$00, #$00, #$00, #$00, #$00, #$00, #$00, {* #$30-$37 *}
  #$00, #$8b, #$9b, #$00, #$00, #$00, #$00, #$00 {* #$38-$3f *}
);

procedure cp1256_mbtowc(S: AnsiChar; var R: WideChar);
begin
  if (S < #$80) then
    Word(R) := Word(S)
  else
    R := cp1256_2uni[Ord(S) - Ord(#$80)];
end;

procedure cp1256_wctomb(S: WideChar; var R: AnsiChar);
var
  c: AnsiChar;
begin
  c := '?';
  if (S < #$0080) then
  begin
    Byte(R) := Byte(S);
    exit;
  end
  else if (S >= #$00a0) and (S < #$0100) then
    c := cp1256_page00[Ord(S) - $00a0]
  else if (S >= #$0150) and (S < #$0198) then
    c := cp1256_page01[Ord(S) - $0150]
  else if (S = #$02c6) then
    c := #$88
  else if (S >= #$0608) and (S < #$06d8) then
    c := cp1256_page06[Ord(S) - $0608]
  else if (S >= #$2008) and (S < #$2040) then
    c := cp1256_page20[Ord(S) - $2008]
  else if (S = #$20ac) then
    c := #$80
  else if (S = #$2122) then
    c := #$99;
  R := c;
end;

end.
