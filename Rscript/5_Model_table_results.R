#Author: McEwen Khundi
#Date: 24Aug2021
#why: Produce a word table output of the new prevalence model

#Load packages
library(tidyverse)
library(brms)

#Turn posteriors into model summary with coefs

model_parameters_prev_rintc <- function(model_prev_rintc, model_name) {
  #model_prev_rintc <- model_parameters(model_prev_rintc, centrality = "mean", effects = "all", component = "all", ci = 0.95, exponentiate = TRUE)
  model_prev_rintc <- posterior_summary(model_prev_rintc)

  model_prev_rintc.parameters <- row.names(model_prev_rintc)
  model_prev_rintc <- as_tibble(model_prev_rintc)

  model_prev_rintc <- model_prev_rintc %>%
    mutate(Parameter = model_prev_rintc.parameters, .before = 1) %>%
    select(Parameter, Mean=Estimate, CI_low=Q2.5, CI_high=Q97.5)

  model_prev_rintc1 <- model_prev_rintc %>%
    filter(!str_detect(Parameter, "sd_cluster__Intercept|sdcar|zi")) %>%
    filter(!str_detect(Parameter, "rrintc|lp__|r_cluster")) %>%
    mutate(across(c(Mean, CI_low, CI_high), ~exp(.x)))

  model_prev_rintc2 <- model_prev_rintc %>%
    filter(str_detect(Parameter, "sd_cluster__Intercept|sdcar|zi"))

  model_prev_rintc <- bind_rows(model_prev_rintc1, model_prev_rintc2)


  model_prev_rintc$Mean[1] <- model_prev_rintc$Mean[1] * 100000
  model_prev_rintc$CI_low[1] <- model_prev_rintc$CI_low[1] * 100000
  model_prev_rintc$CI_high[1] <- model_prev_rintc$CI_high[1] * 100000

  # model_name <-  deparse(substitute(model_prev_rintc)) #https://stackoverflow.com/questions/10520772/in-r-how-to-get-an-objects-name-after-it-is-sent-to-a-function
  # model_name <- paste0(model_name, "m")

  model_prev_rintc %>%
    select(Parameter, Mean, CI_low, CI_high) %>%
    mutate(across(where(is.numeric), ~ formatC(round(.x, 2), 2, format = "f"))) %>%
    mutate(Parameter = str_replace(Parameter, "b_", "")) %>%
    mutate( {{model_name}} := paste0(Mean, " (", CI_low, "-", CI_high, ")")) %>% #https://stackoverflow.com/questions/26003574/use-dynamic-variable-names-in-dplyr
    select(Parameter, {{model_name}})
}

prev_model_rintc_31 <- readRDS(here::here("data/prev_model_rintc_31.rds"))

model_parameters_prev_rintc(prev_model_rintc_31, "prev_model_rintc_31") %>%
  gt::gt() %>%
  gt::fmt_missing(
    everything(),
    missing_text = ""
  ) %>%
  gt::gtsave(filename = "S7_prev_models_rintc.rtf", path = here::here("figures"))
