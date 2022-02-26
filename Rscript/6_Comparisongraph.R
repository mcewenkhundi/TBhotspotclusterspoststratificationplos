# Author: McEwen Khundi
# Date: 24Aug2021
# why: Produce a graph comparing original p:n ratios from the TBhotsposts proj
#     and the poststratified results.

# load libraries
library(tidyverse)

cluster_ests_95_prev30_notif10_rintc_poststrat <- readRDS(here::here("data/cluster_ests_95_prev31_notif25_rintc.rds"))

cluster_ests_95_prev30_notif10_rintc_poststrat <- cluster_ests_95_prev30_notif10_rintc_poststrat %>%
  rename_with(~ paste0(.x, "_poststrat"), .cols = -cluster)

#Produced from the primary analysis repository TBhotspot
cluster_ests_95_prev30_notif10_rintc_origin <- readRDS("~/Projects/TBhotspotclusters/data/cluster_ests_95_prev31_notif25_rintc.rds")

cluster_ests_95_prev30_notif10_rintc_origin <- cluster_ests_95_prev30_notif10_rintc_origin %>%
  rename_with(~ paste0(.x, "_origin"), .cols = -cluster)

compare_prev30_notif10_poststrat <- inner_join(cluster_ests_95_prev30_notif10_rintc_poststrat,
  cluster_ests_95_prev30_notif10_rintc_origin,
  by = "cluster"
)

compare_prev30_notif10_poststrat <- compare_prev30_notif10_poststrat %>%
  mutate(compare_pn_post_orig = prev_to_notif_ratio_poststrat - prev_to_notif_ratio_origin)


compare_prev30_notif10_poststrat %>%
  ggplot() +
  geom_point(aes(x = cluster, y = compare_pn_post_orig)) +
  scale_color_brewer(palette = "Set1", direction = 1) +
  xlim(1, 72) +
  scale_x_continuous(breaks = c(seq(1, 72, 3), 72)) +
  theme_bw() +
  theme(axis.title = element_text(size = 12)) +
  labs(y = "Prevalence to notification ratio diferences", x = "Neighbourhood identifier")

ggsave(filename = here::here("figures/S2_Fig.tiff"), width = 10, height = 5)

compare_prev30_notif10_poststrat <- compare_prev30_notif10_poststrat %>%
  select(cluster,prev_to_notif_ratio_poststrat)

saveRDS(object = compare_prev30_notif10_poststrat,
        file = here::here("data/compare_prev31_notif25_poststrat.rds"))


