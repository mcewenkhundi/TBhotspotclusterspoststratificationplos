library(brms)
library(tidyverse)

dat_scale <- readRDS(here::here("data/dat_scale.rds"))

# dat_scale %>%
#   select(cluster,contains("poststratPrevTB"),prev, worldpop=n_cluster) %>%
#   View()

prior_prev_1 <- c(prior(normal(0,10), class = "b"),
                  prior(normal(0, 10), class = "Intercept"),
                  prior(cauchy(0,1), class = "sd"),
                  prior(normal(0,10), class = "zi"))

#I tried the advice from James 19Augu2021
#Remove the ofset
# poststratPrevTB_tent ~ 1 + scale_perc_never_primary_mean + (1|cluster)
# But did not work still same complaint.

prev_model_rintc_31 <- brm( formula = poststratPrevTB_round ~ 1 + scale_prop_adults_mean + (1|cluster) + offset(log(n_cluster)),
                         data=dat_scale,
                         family=zero_inflated_poisson(),
                         control = list(adapt_delta = 0.99, max_treedepth=10),
                         #autocor=cor_car(w4, ~ 1 | scale_cluster_area, type = "icar"),
                         inits = 0,
                         prior = prior_prev_1,
                         cores=3,
                         iter=15000, warmup=1000,
                         seed = 1293,
                         chains=3)

saveRDS(object = prev_model_rintc_31, file = "data/prev_model_rintc_31.rds")
