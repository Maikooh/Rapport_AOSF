library(FactoMineR)
library(factoextra)
library(dplyr)
library(patchwork)

df <- df_acm
get_acm_contrib2 <- function(target_year, color_fill) {
  df_year <- df %>% filter(format(as.Date(annee), '%Y') == target_year)
  mca <- MCA(df_year[, c('niveau_offre', 'feminisation', 'vieillissement')], graph = FALSE)
  
  fviz_contrib(mca, choice = 'var', axes = 2, fill = color_fill, color = 'black') +
    labs(title = paste("Contrib. Dim 2 -", target_year),
         x = "") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

acm_contrib2_compare <- get_acm_contrib2("2010", "#95a5a6") + get_acm_contrib2("2024", "#3c8dbc")

rm(df, get_acm_contrib2)