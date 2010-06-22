#!/bin/bash
universion="5.2.0"
url="http://www.unicode.org/Public/$universion/ucd/"
files="ArabicShaping.txt\n
BidiMirroring.txt\n
LineBreak.txt\n
PropList.txt\n
Scripts.txt\n
SpecialCasing.txt\n
UnicodeData.txt"

echo -e $files | wget -c --base=$url -i -
