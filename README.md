# inf5163-fedesante

Rapport et présentation INF5163 (UQO, A2026) : analyse critique de l'apprentissage fédéré en santé — éthique, propriété et souveraineté des données.

> *Quand le modèle voyage : éthique, propriété et souveraineté dans un consortium d'apprentissage fédéré en santé.*
> Projet de session 2 (examen final), INF5163 – Méthodologie de recherche en informatique, prof. N'dah Daniel Yapi, Ph.D.

## Structure du dépôt

```
├── README.md                  # présentation du dépôt
├── latexmkrc, Makefile        # configuration de compilation (pdflatex + biber, sortie dans build/)
├── shared/
│   ├── references.bib         # bibliographie unique (rapport + présentation)
│   ├── macros.tex             # \fedesante{}, \pcap{}, \eptc{}, sigles (\ac{FL}, \ac{DP}…)
│   └── figures/               # figures partagées
├── rapport/
│   ├── main.tex               # document principal (15 à 20 pages de corps)
│   ├── preambule.tex          # paquets et réglages communs
│   ├── page-titre.tex
│   ├── sections/              # 02-introduction.tex … 09-conclusion.tex
│   ├── annexes/               # A : contributions ; B : intégrité et IA
│   └── entente-autonome.tex   # l'entente (section 8) compilée seule
├── presentation/
│   ├── main.tex               # Beamer 16:9
│   └── diapos/                # un fichier par bloc (01-intro … 07-conclusion)
├── docs/                      # grille, suivi des sources, répartition
└── .github/workflows/build.yml
```

## Compilation locale

Prérequis : une distribution TeX récente (TeX Live complète recommandée) avec `latexmk`, `biber`, `biblatex` et `biblatex-ieee`.
Sous Debian/Ubuntu : `sudo apt install texlive-full`, ou au minimum `texlive-latex-extra texlive-lang-french texlive-bibtex-extra biber latexmk`.

Toujours compiler **depuis la racine du dépôt**, car les chemins `\input` sont relatifs à la racine :

```sh
make all            # rapport, entente et présentation
make rapport        # build/rapport.pdf
make entente        # build/entente.pdf (section 8 seule)
make presentation   # build/presentation.pdf
make pages          # nombre de pages du corps du rapport (cible : 15 à 20)
make clean          # supprime build/
```

Sur Overleaf, importer le dépôt tel quel et choisir `rapport/main.tex` comme document principal (Overleaf compile depuis la racine).

## Récupérer les PDF depuis GitHub Actions

À chaque push et à chaque pull request sur `main`, le workflow *Compilation LaTeX* compile les trois documents.
Pour récupérer les PDF :

1. ouvrir l'onglet **Actions** du dépôt et choisir la dernière exécution ;
2. télécharger les artefacts `rapport.pdf`, `entente.pdf` et `presentation.pdf` en bas de la page.

Le workflow échoue si une compilation échoue.
Il affiche un avertissement, sans échouer, si le corps du rapport sort de l'intervalle de 15 à 20 pages.

## Flux de travail en équipe

- **Une branche par section** : `section/05-ethique`, `section/08-entente`, `presentation/03-ethique-edi`, etc.
- **Une pull request par branche**, avec au moins un réviseur (voir `docs/repartition.md`).
- **Ne jamais pousser directement sur `main`.** Idéalement, activer une règle de protection de branche sur GitHub.
- **Une phrase par ligne** dans les fichiers `.tex`, pour des diffs lisibles et des révisions faciles.
- **Chaque nouvelle source** va dans `shared/references.bib` **et** dans `docs/sources-a-verifier.md`.
- Les espaces réservés `\arediger{…}` apparaissent en gris dans le PDF : il n'en doit rester aucun à la remise (`grep -rn arediger rapport/ presentation/`).

```sh
git switch main && git pull
git switch -c section/05-ethique
# … rédaction, puis :
make rapport
git add rapport/sections/05-integrite-ethique-edi.tex
git commit -m "Section 5 : risques résiduels"
git push -u origin section/05-ethique   # puis ouvrir une pull request
```

## IA générative

L'usage d'outils d'IA générative est permis, mais il doit être **déclaré dans l'annexe B** (`rapport/annexes/b-integrite-ia.tex`) : outil, portion du travail et raison.
Consignez chaque usage **au fur et à mesure**, et non à la fin.

## Licence

À décider en équipe.
Proposition : CC BY 4.0 pour le rapport et la présentation, après la correction.

> Note : le dépôt GitHub a été créé avec un fichier `LICENSE` (CC0 1.0).
> Il ne reflète pas encore une décision de l'équipe : le remplacer ou le retirer une fois la licence choisie.
