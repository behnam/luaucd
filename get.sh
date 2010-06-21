#!/bin/bash
universion="5.2.0"
url="http://www.unicode.org/Public/$universion/ucd/"
files="ArabicShaping.txt\n
BidiMirroring.txt\n
Blocks.txt\n
CaseFolding.txt\n
CompositionExclusions.txt\n
DerivedAge.txt\n
DerivedCoreProperties.txt\n
DerivedNormalizationProps.txt\n
EastAsianWidth.txt\n
HangulSyllableType.txt\n
Jamo.txt\n
LineBreak.txt\n
NameAliases.txt\n
NormalizationCorrections.txt\n
NormalizationTest.txt\n
PropList.txt\n
PropertyAliases.txt\n
PropertyValueAliases.txt\n
Scripts.txt\n
SpecialCasing.txt\n
StandardizedVariants.txt\n
UnicodeData.txt"

echo -e $files | wget -c --base=$url -i -
