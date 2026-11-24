# inf5163-fedesante

Rapport et présentation INF5163 (UQO, A2026) : analyse critique de l'apprentissage fédéré en santé — éthique, propriété et souveraineté des données.

> *Quand le modèle voyage : éthique, propriété et souveraineté dans un consortium d'apprentissage fédéré en santé.*
> Projet de session 2 (examen final), INF5163 – Méthodologie de recherche en informatique, prof. N'dah Daniel Yapi, Ph.D.

## Structure du dépôt

```
├── README.md                  # présentation du dépôt
├── .vscode/settings.json      # recette LaTeX Workshop : Tectonic, compilation à l'enregistrement
├── .devcontainer/             # environnement GitHub Codespaces (Tectonic + LaTeX Workshop)
├── shared/
│   ├── references.bib         # bibliographie unique (rapport + présentation), style IEEEtran
│   ├── macros.tex             # \fedesante{}, \pcap{}, \eptc{}, sigles (\ac{FL}, \ac{DP}…)
│   └── figures/               # figures partagées, dont Logo_UQO.jpg
├── rapport/
│   ├── main.tex               # document principal : \section{…} et \input des fichiers
│   ├── preambule.tex          # mise en page UQO et paquets communs
│   ├── entente-autonome.tex   # l'entente (section 8) compilée seule
│   └── sections/              # page_de_garde, 01-introduction … 09-conclusion, annexe_*
├── presentation/
│   ├── main.tex               # Beamer 16:9
│   └── diapos/                # un fichier par bloc (01-introduction … 09-conclusion, un par section)
├── docs/                      # grille, suivi des sources, répartition
└── .github/workflows/build.yml
```

## Compilation locale

Le projet suit la même recette que nos travaux précédents : **Tectonic**, lancé par l'extension **LaTeX Workshop** de VS Code.
Tectonic télécharge lui-même les paquets manquants (dont `IEEEtran.bst`) et lance BibTeX automatiquement.

1. Installer Tectonic (voir <https://tectonic-typesetting.github.io>), par exemple dans `~/.local/bin`.
2. Ouvrir le dépôt dans VS Code avec LaTeX Workshop : la recette de `.vscode/settings.json` compile à chaque enregistrement.
   Grâce au commentaire `% !TEX root = ../main.tex`, enregistrer un fichier de section recompile le document principal.
3. En ligne de commande :

```sh
cd rapport && tectonic -X compile main.tex               # rapport/main.pdf
cd rapport && tectonic -X compile entente-autonome.tex   # rapport/entente-autonome.pdf
cd presentation && tectonic -X compile main.tex          # presentation/main.pdf
```

**Longueur du rapport.**
Le corps (introduction → conclusion) doit faire 15 à 20 pages.
À chaque compilation, un avertissement LaTeX « Corps du rapport : N page(s) » s'affiche s'il sort de cet intervalle.
Le nombre de pages est aussi écrit dans `rapport/main.log` (ligne `FEDESANTE-PAGES-CORPS`, avec `--keep-logs`).


## Compiler dans GitHub Codespaces (sans rien installer)

Pour travailler dans le navigateur : sur la page du dépôt, **Code → Codespaces → Create codespace on <votre branche>**.
La configuration de `.devcontainer/` installe Tectonic et LaTeX Workshop (environ une minute la première fois).
Ouvrir ensuite `rapport/main.tex` ou un fichier de section : chaque enregistrement recompile, et l'aperçu PDF s'ouvre dans un onglet (icône « View LaTeX PDF »).
Arrêter le codespace après usage (**Codespaces → Stop**) pour ménager le quota mensuel gratuit.

## Récupérer les PDF depuis GitHub Actions

Le workflow *Compilation LaTeX* ne sert pas au travail courant : on compile localement ou dans un codespace.
Il compile les trois documents avec Tectonic dans deux cas seulement :

- à l'ouverture d'une pull request vers `main` et à chaque nouveau commit poussé dans cette pull request (PDF pour la révision) ;
- à la fusion dans `main` (PDF de référence).

Pour récupérer les PDF :

1. ouvrir l'onglet **Actions** du dépôt et choisir la dernière exécution ;
2. télécharger les artefacts `rapport.pdf`, `entente.pdf` et `presentation.pdf` en bas de la page.

Le workflow échoue si une compilation échoue.
Il affiche un avertissement, sans échouer, si le corps du rapport sort de l'intervalle de 15 à 20 pages.

## Flux de travail en équipe

- **Une branche par section** : `section/05-ethique`, `section/08-entente`, `presentation/05-ethique-edi`, etc.
- **Une pull request par branche**, avec au moins un réviseur (voir `docs/repartition.md`).
- **Ne jamais pousser directement sur `main`.** Idéalement, activer une règle de protection de branche sur GitHub.
- **Une phrase par ligne** dans les fichiers `.tex`, pour des diffs lisibles et des révisions faciles.
- **Chaque nouvelle source** va dans `shared/references.bib` **et** dans `docs/sources-a-verifier.md`.
- Les espaces réservés `\arediger{…}` apparaissent en gris dans le PDF : il n'en doit rester aucun à la remise (`grep -rn arediger rapport/ presentation/`).

```sh
git switch main && git pull
git switch -c section/05-ethique
# … rédaction ;
# enregistrer dans VS Code (compilation Tectonic), puis :
git add rapport/sections/05-integrite-ethique-edi.tex
git commit -m "Section 5 : risques résiduels"
git push -u origin section/05-ethique   # puis ouvrir une pull request
```

## IA générative

L'usage d'outils d'IA générative est permis, mais il doit être **déclaré dans l'annexe B** (`rapport/sections/annexe_integrite_ia.tex`) : outil, portion du travail et raison.
Consignez chaque usage **au fur et à mesure**, et non à la fin.

## Licence

À décider en équipe.
Proposition : CC BY 4.0 pour le rapport et la présentation, après la correction.

> Note : le dépôt GitHub a été créé avec un fichier `LICENSE` (CC0 1.0).
> Il ne reflète pas encore une décision de l'équipe : le remplacer ou le retirer une fois la licence choisie.
