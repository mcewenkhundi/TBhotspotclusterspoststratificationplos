# Author: McEwen Khundi
# Date: 24Aug2021
# why: Produce a table comparing the primary analysis and the two sensitivity analysis.

# load libraries
library(tidyverse)

cluster_ests_95_prev31_notif25_rintc_poststrat <- readRDS(here::here("data/cluster_ests_95_prev31_notif25_rintc.rds"))%>%
                                                       rename_with(~ paste0(.x, "_poststrat"), .cols = -cluster)


#Get from the primary analysis table
cluster_ests_95_prev31_notif25_rintc_origin <- readRDS("~/Projects/TBhotspotclusters/data/cluster_ests_95_prev31_notif25_rintc.rds")

cluster_ests_95_prev31_notif25_rintc_origin <- cluster_ests_95_prev31_notif25_rintc_origin %>%
  rename_with(~ paste0(.x, "_origin"), .cols = -cluster)

prev31_notif25_origin_poststrat_allnotif <- inner_join(cluster_ests_95_prev31_notif25_rintc_origin,
                                                       cluster_ests_95_prev31_notif25_rintc_poststrat,
                                               by = "cluster")

## Get from the (sensitivity) all notified analysis table
compare_prev31_notif25_allnotified <- readRDS("~/Projects/TBhotspotclustersAllcases/data/cluster_ests_95_prev31_notif25_rintc.rds") %>%
  rename_with(~ paste0(.x, "_allnotif"), .cols = -cluster)


prev31_notif25_origin_poststrat_allnotif <- prev31_notif25_origin_poststrat_allnotif %>%
                                            inner_join(compare_prev31_notif25_allnotified, by = "cluster")

prev31_notif25_origin_poststrat_allnotif <- prev31_notif25_origin_poststrat_allnotif %>%
  select(cluster,contains("prev_to_notif_ratio"))

prev31_notif25_origin_poststrat_allnotif <- prev31_notif25_origin_poststrat_allnotif %>%
  mutate(
    prev_to_notif_ratio_origin_4gp = cut(prev_to_notif_ratio_origin,
                                         breaks = quantile(prev_to_notif_ratio_origin,
                                                           probs = c(0, 0.25, 0.50, 0.75, 1)
                                         ),
                                         labels = 1:4,
                                         include.lowest = TRUE
    ),
    prev_to_notif_ratio_allnotif_4gp = cut(prev_to_notif_ratio_allnotif,
                                            breaks = quantile(prev_to_notif_ratio_allnotif,
                                                              probs = c(0, 0.25, 0.50, 0.75, 1)
                                            ),
                                            labels = 1:4,
                                            include.lowest = TRUE
    ),
    prev_to_notif_ratio_poststrat_4gp = cut(prev_to_notif_ratio_poststrat,
                                            breaks = quantile(prev_to_notif_ratio_poststrat,
                                                              probs = c(0, 0.25, 0.50, 0.75, 1)
                                            ),
                                            labels = 1:4,
                                            include.lowest = TRUE
    )
  )


prev31_notif25_origin_poststrat_allnotif %>%
  filter(prev_to_notif_ratio_origin_4gp == 4 | prev_to_notif_ratio_allnotif_4gp == 4 | prev_to_notif_ratio_poststrat_4gp == 4) %>%
  rename(
    "TB prevalence to confirmed TB notification ratio" = prev_to_notif_ratio_origin,
    "TB prevalence to all TB notification ratio" = prev_to_notif_ratio_allnotif,
    "Post-stratified TB prevalence to confimed TB notification ratio" = prev_to_notif_ratio_poststrat,
    "TB prevalence to confirmed TB notification ratio quartile" = prev_to_notif_ratio_origin_4gp,
    "TB prevalence to all TB notification ratio quartile" = prev_to_notif_ratio_allnotif_4gp,
    "Post-stratified TB prevalence to confimed TB notification quartile" = prev_to_notif_ratio_poststrat_4gp
  ) %>%
  gt::gt() %>%
  gt::fmt_missing(
    everything(),
    missing_text = ""
  ) %>%
  gt::gtsave(filename = "S9_Table_tablecompare_prev31_notif25_all.rtf", path = here::here("figures"))
