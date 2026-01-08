# 🏥 Analyse Multivariée de l'Offre de Soins en France

### Multivariate Analysis of Healthcare Supply in France

[![R](https://img.shields.io/badge/R-4.0+-blue.svg)](https://www.r-project.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 📋 Table of Contents / Table des matières

- [🇫🇷 Version française](#-version-française)

  - [Description](#description)
  - [Objectifs](#objectifs)
  - [Structure du projet](#structure-du-projet)
  - [Méthodologie](#méthodologie)
  - [Prérequis](#prérequis)
  - [Installation](#installation)
  - [Utilisation](#utilisation)
  - [Données](#données)
  - [Auteurs](#auteurs)

- [🇬🇧 English version](#-english-version)
  - [Description](#description-1)
  - [Objectives](#objectives)
  - [Project Structure](#project-structure)
  - [Methodology](#methodology)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation-1)
  - [Usage](#usage)
  - [Data Sources](#data-sources)
  - [Authors](#authors)

---

## 🇫🇷 Version française

### Description

Ce projet propose une **analyse statistique multivariée** de l'offre de soins en France à l'échelle départementale. L'étude combine des données sur les professionnels de santé (AMELI) et les établissements de santé (FINESS) pour caractériser la structure territoriale de l'offre de soins et identifier les disparités régionales.

L'analyse mobilise deux approches complémentaires :

- **Analyse en Composantes Principales (ACP)** pour étudier les relations entre variables quantitatives
- **Analyse des Correspondances Multiples (ACM)** pour établir une typologie qualitative des territoires

### Objectifs

- 🎯 Caractériser la structure démographique des professionnels de santé par département
- 📊 Identifier les patterns territoriaux de l'offre de soins
- 👥 Analyser la féminisation et le vieillissement de l'offre de soins
- 🗺️ Mettre en évidence les disparités territoriales
- 📈 Étudier l'évolution temporelle de l'offre de soins (2010-2024)

### Structure du projet

```
.
├── Analyse_de_l_offre_de_soin_en_France.Rmd  # Document principal R Markdown
└── Script/
    ├── 00_ameli_effectif.R                   # Import données AMELI
    ├── 00_finess.R                            # Import données FINESS
    ├── 00_tab_pres_ameli.R                   # Tableau de présentation AMELI
    ├── 00_tab_pres_finess.R                  # Tableau de présentation FINESS
    ├── 01_fusion_ACP.R                       # Préparation données ACP
    ├── 01_fusion_ACM.R                       # Préparation données ACM
    ├── 01_tab_pres_acp.R                     # Tableau de présentation ACP
    ├── 01_tab_pres_acm.R                     # Tableau de présentation ACM
    ├── 02_acp_cercle.R                       # Cercle de corrélation (ACP)
    ├── 02_acp_contrib_dim1.R                 # Contributions dimension 1 (ACP)
    ├── 02_acp_contrib_dim2.R                 # Contributions dimension 2 (ACP)
    ├── 02_acp_individu.R                     # Projection individus (ACP)
    ├── 02_acp_vp.R                           # Valeurs propres (ACP)
    ├── 03_acm_contrib_dim1.R                 # Contributions dimension 1 (ACM)
    ├── 03_acm_contrib_dim2.R                 # Contributions dimension 2 (ACM)
    ├── 03_acm_individu.R                     # Projection individus (ACM)
    ├── 03_acm_variable.R                     # Projection variables (ACM)
    └── 03_acm_vp.R                           # Valeurs propres (ACM)
```

### Méthodologie

#### 1. Sources de données

##### Données AMELI

- **Source** : [data.ameli.fr](https://data.ameli.fr)
- **Contenu** : Démographie des professionnels de santé
- **Dimensions** : Sexe, âge, profession, département, année (2010-2024)
- **Format** : Données téléchargées via API en format Parquet

##### Données FINESS

- **Source** : [data.gouv.fr](https://www.data.gouv.fr)
- **Contenu** : Établissements sanitaires et médico-sociaux
- **Granularité** : Localisation départementale

#### 2. Indicateurs construits

##### Pour l'ACP (variables quantitatives)

- **Part des femmes** : Ratio effectif féminin / effectif total
- **Part des 60 ans et plus** : Indicateur de vieillissement
- **Âge moyen estimé** : Moyenne pondérée des centres de classes d'âge
- **Effectif total (log)** : Volume de professionnels (transformation logarithmique)

##### Pour l'ACM (variables qualitatives)

Variables construites par discrétisation en tertiles :

- **Niveau d'offre** : Faible / Moyen / Élevé
- **Féminisation** : Faible / Intermédiaire / Forte
- **Vieillissement** : Jeune / Intermédiaire / Vieillissant

#### 3. Traitements appliqués

- Exclusion des modalités agrégées ("tout sexe", "tout âge", "FRANCE")
- Harmonisation des codes départementaux (ex: 9A → 971)
- Nettoyage des doublons et valeurs manquantes
- Normalisation des données pour l'ACP
- Discrétisation cohérente dans le temps pour l'ACM

### Prérequis

- R ≥ 4.0
- RStudio (recommandé)
- Packages R :
  ```r
  install.packages(c(
    "arrow",          # Import données Parquet
    "tidyverse",      # Manipulation de données
    "FactoMineR",     # ACP et ACM
    "factoextra",     # Visualisation
    "corrplot",       # Corrélations
    "knitr",          # Rapports R Markdown
    "kableExtra"      # Tableaux formatés
  ))
  ```

### Installation

1. Clonez le dépôt :

```bash
git clone https://github.com/votre-username/analyse-offre-soins-france.git
cd analyse-offre-soins-france
```

2. Créez la structure de dossiers :

```bash
mkdir -p Script
```

3. Installez les dépendances R :

```r
source("install_packages.R")  # Si disponible
```

### Utilisation

#### Génération du rapport complet

1. Ouvrez le fichier `Analyse_de_l_offre_de_soin_en_France.Rmd` dans RStudio
2. Cliquez sur "Knit" pour générer le rapport (PDF ou HTML)

#### Exécution des scripts individuellement

```r
# Importation des données
source("Script/00_ameli_effectif.R")
source("Script/00_finess.R")

# Préparation pour l'ACP
source("Script/01_fusion_ACP.R")

# Exécution de l'ACP
source("Script/02_acp_vp.R")        # Valeurs propres
source("Script/02_acp_cercle.R")    # Cercle de corrélation
source("Script/02_acp_individu.R")  # Projection des individus

# Préparation pour l'ACM
source("Script/01_fusion_ACM.R")

# Exécution de l'ACM
source("Script/03_acm_vp.R")        # Valeurs propres
source("Script/03_acm_variable.R")  # Projection des variables
source("Script/03_acm_individu.R")  # Projection des individus
```

### Données

Les données sont téléchargées automatiquement lors de l'exécution des scripts :

- **AMELI** : API directe avec filtres intégrés
- **FINESS** : Import depuis data.gouv.fr

⚠️ **Note** : Le téléchargement initial peut prendre quelques minutes selon votre connexion internet.

### Résultats attendus

Le rapport généré contient :

- 📊 Statistiques descriptives complètes
- 🎨 Visualisations de l'ACP (cercle de corrélation, projection des individus)
- 🗺️ Cartographies de l'ACM (modalités et individus)
- 📈 Graphiques des contributions et valeurs propres
- 📝 Interprétations des axes factoriels
- 🔍 Analyse des typologies départementales

### Auteur

- **Fadli Aaron**

---

## 🇬🇧 English version

### Description

This project provides a **multivariate statistical analysis** of healthcare supply in France at the departmental level. The study combines data on healthcare professionals (AMELI) and healthcare facilities (FINESS) to characterize the territorial structure of healthcare supply and identify regional disparities.

The analysis uses two complementary approaches:

- **Principal Component Analysis (PCA)** to study relationships between quantitative variables
- **Multiple Correspondence Analysis (MCA)** to establish a qualitative typology of territories

### Objectives

- 🎯 Characterize the demographic structure of healthcare professionals by department
- 📊 Identify territorial patterns of healthcare supply
- 👥 Analyze feminization and aging of the healthcare workforce
- 🗺️ Highlight territorial disparities
- 📈 Study temporal evolution of healthcare supply (2010-2024)

### Project Structure

```
.
├── Analyse_de_l_offre_de_soin_en_France.Rmd  # Main R Markdown document
└── Script/
    ├── 00_ameli_effectif.R                   # AMELI data import
    ├── 00_finess.R                            # FINESS data import
    ├── 00_tab_pres_ameli.R                   # AMELI presentation table
    ├── 00_tab_pres_finess.R                  # FINESS presentation table
    ├── 01_fusion_ACP.R                       # PCA data preparation
    ├── 01_fusion_ACM.R                       # MCA data preparation
    ├── 01_tab_pres_acp.R                     # PCA presentation table
    ├── 01_tab_pres_acm.R                     # MCA presentation table
    ├── 02_acp_cercle.R                       # Correlation circle (PCA)
    ├── 02_acp_contrib_dim1.R                 # Dimension 1 contributions (PCA)
    ├── 02_acp_contrib_dim2.R                 # Dimension 2 contributions (PCA)
    ├── 02_acp_individu.R                     # Individual projection (PCA)
    ├── 02_acp_vp.R                           # Eigenvalues (PCA)
    ├── 03_acm_contrib_dim1.R                 # Dimension 1 contributions (MCA)
    ├── 03_acm_contrib_dim2.R                 # Dimension 2 contributions (MCA)
    ├── 03_acm_individu.R                     # Individual projection (MCA)
    ├── 03_acm_variable.R                     # Variable projection (MCA)
    └── 03_acm_vp.R                           # Eigenvalues (MCA)
```

### Methodology

#### 1. Data Sources

##### AMELI Data

- **Source**: [data.ameli.fr](https://data.ameli.fr)
- **Content**: Demographics of healthcare professionals
- **Dimensions**: Gender, age, profession, department, year (2010-2024)
- **Format**: Data downloaded via API in Parquet format

##### FINESS Data

- **Source**: [data.gouv.fr](https://www.data.gouv.fr)
- **Content**: Health and medico-social facilities
- **Granularity**: Departmental location

#### 2. Constructed Indicators

##### For PCA (quantitative variables)

- **Female proportion**: Female workforce / Total workforce ratio
- **60+ proportion**: Aging indicator
- **Estimated average age**: Weighted average of age class centers
- **Total workforce (log)**: Volume of professionals (logarithmic transformation)

##### For MCA (qualitative variables)

Variables constructed by tertile discretization:

- **Supply level**: Low / Medium / High
- **Feminization**: Low / Intermediate / High
- **Aging**: Young / Intermediate / Aging

#### 3. Data Processing

- Exclusion of aggregated categories ("all genders", "all ages", "FRANCE")
- Harmonization of departmental codes (e.g., 9A → 971)
- Cleaning of duplicates and missing values
- Data normalization for PCA
- Time-consistent discretization for MCA

### Prerequisites

- R ≥ 4.0
- RStudio (recommended)
- R packages:
  ```r
  install.packages(c(
    "arrow",          # Parquet data import
    "tidyverse",      # Data manipulation
    "FactoMineR",     # PCA and MCA
    "factoextra",     # Visualization
    "corrplot",       # Correlations
    "knitr",          # R Markdown reports
    "kableExtra"      # Formatted tables
  ))
  ```

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/analyse-offre-soins-france.git
cd analyse-offre-soins-france
```

2. Create the folder structure:

```bash
mkdir -p Script
```

3. Install R dependencies:

```r
source("install_packages.R")  # If available
```

### Usage

#### Generate Complete Report

1. Open `Analyse_de_l_offre_de_soin_en_France.Rmd` in RStudio
2. Click "Knit" to generate the report (PDF or HTML)

#### Run Scripts Individually

```r
# Data import
source("Script/00_ameli_effectif.R")
source("Script/00_finess.R")

# PCA preparation
source("Script/01_fusion_ACP.R")

# Run PCA
source("Script/02_acp_vp.R")        # Eigenvalues
source("Script/02_acp_cercle.R")    # Correlation circle
source("Script/02_acp_individu.R")  # Individual projection

# MCA preparation
source("Script/01_fusion_ACM.R")

# Run MCA
source("Script/03_acm_vp.R")        # Eigenvalues
source("Script/03_acm_variable.R")  # Variable projection
source("Script/03_acm_individu.R")  # Individual projection
```

### Data Sources

Data is automatically downloaded when scripts are executed:

- **AMELI**: Direct API with integrated filters
- **FINESS**: Import from data.gouv.fr

⚠️ **Note**: Initial download may take a few minutes depending on your internet connection.

### Expected Results

The generated report contains:

- 📊 Complete descriptive statistics
- 🎨 PCA visualizations (correlation circle, individual projection)
- 🗺️ MCA mappings (modalities and individuals)
- 📈 Contribution and eigenvalue plots
- 📝 Interpretation of factorial axes
- 🔍 Analysis of departmental typologies

### Author

- **Fadli Aaron**

---

## 📝 License / Licence

This project is licensed under the MIT License - see the LICENSE file for details.

Ce projet est sous licence MIT - voir le fichier LICENSE pour plus de détails.

## 🤝 Contributing / Contribution

Contributions are welcome! Please feel free to submit a Pull Request.

Les contributions sont les bienvenues ! N'hésitez pas à soumettre une Pull Request.

## 📧 Contact

For questions or suggestions, please open an issue on GitHub.

Pour toute question ou suggestion, veuillez ouvrir une issue sur GitHub.

---

**⭐ If you find this project useful, please consider giving it a star!**

**⭐ Si vous trouvez ce projet utile, pensez à lui donner une étoile !**
