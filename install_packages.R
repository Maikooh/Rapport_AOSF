# Installation des packages nécessaires pour le projet
# Script d'installation automatique
# Required packages installation script

cat("===========================================\n")
cat("Installation des packages R nécessaires\n")
cat("Installing required R packages\n")
cat("===========================================\n\n")

# Liste des packages requis
packages <- c(
  "arrow",          # Import de données Parquet / Parquet data import
  "tidyverse",      # Manipulation de données / Data manipulation
  "dplyr",          # Manipulation de données / Data wrangling
  "tidyr",          # Nettoyage de données / Data tidying
  "ggplot2",        # Visualisation / Visualization
  "FactoMineR",     # ACP, ACM, AFC / PCA, MCA, CA
  "factoextra",     # Visualisation FactoMineR / FactoMineR visualization
  "corrplot",       # Matrices de corrélation / Correlation matrices
  "knitr",          # Rapports R Markdown / R Markdown reports
  "kableExtra",     # Tableaux formatés / Formatted tables
  "rmarkdown"       # Génération de rapports / Report generation
)

# Fonction pour installer les packages manquants
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("Installation de / Installing %s...\n", pkg))
    install.packages(pkg, dependencies = TRUE, repos = "https://cran.rstudio.com/")
    if (require(pkg, character.only = TRUE, quietly = TRUE)) {
      cat(sprintf("✓ %s installé avec succès / successfully installed\n", pkg))
    } else {
      cat(sprintf("✗ Échec de l'installation de / Failed to install %s\n", pkg))
    }
  } else {
    cat(sprintf("✓ %s déjà installé / already installed\n", pkg))
  }
}

# Installation des packages
cat("\nDébut de l'installation / Starting installation...\n\n")
for (pkg in packages) {
  install_if_missing(pkg)
}

cat("\n===========================================\n")
cat("Installation terminée!\n")
cat("Installation completed!\n")
cat("===========================================\n\n")

# Vérification finale
cat("Vérification finale / Final check:\n")
installed <- sapply(packages, function(pkg) {
  require(pkg, character.only = TRUE, quietly = TRUE)
})

if (all(installed)) {
  cat("\n✓ Tous les packages sont installés correctement!\n")
  cat("✓ All packages are correctly installed!\n")
} else {
  cat("\n✗ Certains packages n'ont pas pu être installés:\n")
  cat("✗ Some packages could not be installed:\n")
  cat(paste(packages[!installed], collapse = ", "), "\n")
}
