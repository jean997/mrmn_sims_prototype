## This DSC script only generates data and does no analysis.

## Generates two sample GWAS data with matching LD
## No heritable confounding

simulate: R(library(simGWAS);
            data("ld_mat_list");
            data("AF");
            G <- matrix(c(0, beta,0, 0), nrow = 2, byrow = T);
            dat <- sim_mv(G = G, J = 5e5,
                          N = c(Nx, Ny),
                          h2 = c(h2x, h2y),
                          pi = c(n_effx, n_effy)/5e5,
                          R_LD = ld_mat_list,
                          af = AF, est_s = TRUE);
             pruned_set <- sim_ld_prune(dat = dat, pvalue = 1,
                                        R_LD = ld_mat_list,
                                        r2_thresh = 0.01, pval_thresh = 1);
             res <- data.frame(SNP = 1:(5e5),
                               bhat_x = dat$beta_hat[,1],
                               bhat_y = dat$beta_hat[,2],
                               se_x = dat$s_estimate[,1],
                               se_y = dat$s_estimate[,2],
                               LD_01 = FALSE);
              res$LD_01[pruned_set] <- TRUE;)
  Nx: 60000
  Ny: 60000
  h2x: 0.3
  h2y: 0.15
  n_effx: 1000
  n_effy: 1000
  beta: 0.2
  $dat: res
  $truth: beta


DSC:
  replicate: 10
  run: simulate
  output: benchmark1_data
