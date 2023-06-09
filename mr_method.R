library(dplyr)
mr_method <- function(dat){
  dat <- mutate(dat, p_x = 2*pnorm(-abs(bhat_x/se_x))) %>%
         filter(p_x < 5e-8 & LD_01 == TRUE)
  ivw_fit <- lm(bhat_y ~ bhat_x -1, weights = 1/se_y^2, data = dat)
  result <- list(est = ivw_fit$coefficients[1],
                 se = summary(ivw_fit)$coefficients[1,2],
                 p = summary(ivw_fit)$coefficients[1,4])
  return(result)
}
