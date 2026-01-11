library(FactoMineR)
library(factoextra)
library(dplyr)
library(patchwork)

df <- df_acm

get_acm_contrib1 <- function(target_year, color_fill) {
  df_year <- df %>% filter(format(as.Date(annee), '%Y') == target_year)
  mca <- MCA(df_year[, c('niveau_offre', 'feminisation', 'vieillissement')], graph = FALSE)
  
  fviz_contrib(mca, choice = 'var', axes = 1, fill = color_fill, color = 'black') +
    labs(title = paste("Contrib. Dim 1 -", target_year),
         x = "") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}

acm_contrib1_compare <- get_acm_contrib1("2010", "#95a5a6") + get_acm_contrib1("2024", "#3c8dbc")

rm(df, get_acm_contrib1)