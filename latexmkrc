# Configuration latexmk partagée (lue automatiquement quand latexmk est lancé
# depuis la racine du dépôt, ce que font le Makefile et l'intégration continue).
#
# Moteur : pdflatex (fontenc T1 + lmodern). Pour passer à lualatex, remplacer
# $pdf_mode = 1 par $pdf_mode = 4 et retirer fontenc de rapport/preambule.tex.

$pdf_mode = 1;
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error -halt-on-error %O %S';

# Bibliographie : biblatex + biber (détecté automatiquement via le fichier .bcf).
$bibtex_use = 2;

# Tous les fichiers produits vont dans build/ (ignoré par git).
$out_dir = 'build';
