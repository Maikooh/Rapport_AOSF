library(FactoMineR)
library(factoextra)
library(dplyr)
library(patchwork)

df <- df_acp
df$annee_num <- format(as.Date(df$annee), '%Y')

# --- Fonction pour calculer l'ACP et la contribution ---
get_contrib_plot <- function(annee_cible) {
  df_filtered <- df %>% filter(annee_num == annee_cible)
  df_acp <- df_filtered %>% 
    select(effectif_total_log, part_femmes, part_60_plus, age_moyen, nb_etablissements_log) %>%
    na.omit()
  
  pca <- PCA(df_acp, scale.unit = TRUE, ncp = 5, graph = FALSE)
  
  fviz_contrib(pca, choice = 'var', axes = 2,
               fill = ifelse(annee_cible == "2024", '#3c8dbc', '#999999'), 
               color = 'black') +
    labs(title = paste("Contribution Dim 2 (", annee_cible, ")", sep=""),
         x = "") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

# Génération des deux graphiques
c1 <- get_contrib_plot("2010")
c2 <- get_contrib_plot("2024")

# Assemblage côte à côte
comparaison_contrib <- c1 + c2
rm(c1, c2, df, get_contrib_plot)