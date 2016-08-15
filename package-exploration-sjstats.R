# Example from https://strengejacke.wordpress.com/2016/08/01/pipe-friendly-bootstrapping-with-list-variables-in-rstats/

library(dplyr)
library(sjstats)

data(efc)
fit <- lm(neg_c_7 ~ e42dep + c161sex, data = efc)

confint(fit)

bootstrap(efc, 1000)

# Since all data frames are saved in a list, you can use lapply() to easily run the same linear model
# (used above) over all bootstrap samples and save these fitted model objects in another list-variable.

efc %>% 
  # generate bootstrape replicates, saved in
  # the list-variable 'strap'
  bootstrap(1000) %>% 
  # run linear model on all bootstrap samples
  mutate(models = lapply(.$strap, function(x) {
    lm(neg_c_7 ~ e42dep + c161sex, data = x)
  })) %>%
  # extract coefficient for "e42dep" (dependency) variable
  mutate(dependency = unlist(lapply(.$models, function(x) coef(x)[2]))) %>%
  # compute boostrapped confidence intervals
  boot_ci(dependency)