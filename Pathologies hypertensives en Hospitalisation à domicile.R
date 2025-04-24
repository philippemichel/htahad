

#  ------------------------------------------------------------------------
#
# Title : HTA-HAD import
#    By : PhM
#  Date : 2025-04-18
#
#  ------------------------------------------------------------------------


library(tidyverse)
library(janitor)
library(labelled)
library(baseph)
library(lubridate)
library(readODS)
#
# 1. Importation des données
#
rm(list = ls())
tt <- read_ods("datas/htahad.ods", sheet = "htahad", na = c("","NC")) |>
  clean_names() |>
  mutate(across(where(is.character), ~ as.factor(.x))) |>
  mutate(ipp = as.factor(ipp)) |>
  mutate(across(starts_with("date"), ~ dmy(.x))) |>
  ## Réordonnancement de tt$terme_mise_en_place_ttt
mutate(terme_mise_en_place_tt = fct_relevel(terme_mise_en_place_tt,
    "arret  debut de grossesse", "avant 20SA", "apres 20SA", "apres 25SA"
  )) |>
  mutate(traitement = fct_relevel(traitement,
   "aucun", "monotherapie", "bitherapie", "tritherapie"
  )) |>
  mutate(imc =  bmiph(imc))



