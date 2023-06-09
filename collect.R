library(dscrutils)

res <- dscquery(dsc.outdir = "benchmark1_result",
                targets = c("analyze.est", "analyze.se", "analyze.p", "analyze.truth", "analyze.DSC_TIME"))

saveRDS(res, file = "bench1_resullts.RDS")
