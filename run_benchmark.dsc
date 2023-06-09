## This file tests out using externally hosted simulation files

simulate: R( files <- readr::read_lines("bench1_files.txt");
              dat <- readRDS(url(files[DSC_REPLICATE])))
  $dat: dat

analyze: R(source("mr_method.R");
           result <- mr_method(dat$dat))
  dat: $dat
  $est: result$est
  $se: result$se
  $p: result$p
  $truth: dat$truth


DSC:
  replicate: 10
  run: simulate*analyze
  output: benchmark1_result
