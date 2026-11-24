# Compilation des documents INF5163 – FédéSanté.
# Toujours lancer depuis la racine du dépôt : les chemins \input sont relatifs à la racine.

LATEXMK := latexmk
BUILD   := build
PAGES_MIN := 15
PAGES_MAX := 20

.PHONY: all rapport entente presentation pages clean

all: rapport entente presentation

rapport:
	$(LATEXMK) -jobname=rapport rapport/main.tex

entente:
	$(LATEXMK) -jobname=entente rapport/entente-autonome.tex

presentation:
	$(LATEXMK) -jobname=presentation presentation/main.tex

# Affiche le nombre de pages du corps du rapport (introduction → conclusion),
# écrit dans le log par \AtEndDocument (voir rapport/main.tex).
# Dans GitHub Actions, l'avertissement est émis au format ::warning:: sans faire échouer le workflow.
pages:
	@test -f $(BUILD)/rapport.log || $(MAKE) --no-print-directory rapport
	@n=$$(sed -n 's/^FEDESANTE-PAGES-CORPS: \([0-9][0-9]*\).*/\1/p' $(BUILD)/rapport.log | tail -n 1); \
	if [ -z "$$n" ]; then \
		echo "Nombre de pages introuvable dans $(BUILD)/rapport.log : recompiler avec « make rapport »."; \
		exit 1; \
	fi; \
	echo "Corps du rapport : $$n page(s) (cible : $(PAGES_MIN) à $(PAGES_MAX), hors références et annexes)."; \
	if [ $$n -lt $(PAGES_MIN) ] || [ $$n -gt $(PAGES_MAX) ]; then \
		msg="Le corps du rapport fait $$n page(s), hors de l'intervalle $(PAGES_MIN)–$(PAGES_MAX)."; \
		if [ -n "$$GITHUB_ACTIONS" ]; then echo "::warning title=Longueur du rapport::$$msg"; \
		else echo "AVERTISSEMENT : $$msg"; fi; \
	else \
		echo "OK : longueur conforme."; \
	fi

clean:
	rm -rf $(BUILD)
