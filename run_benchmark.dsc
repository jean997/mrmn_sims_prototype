## This file tests out using externally hosted simulation files

simulate: R( files <- readr::read_lines("bench1_files.txt");
              dat <- readRDS(url(files[DSC_REPLICATE])))
  $dat: dat

analyze: R(m <- mean(dat))
  dat: $dat
  $m: m


DSC:
  replicate: 10
  run: simulate*analyze
  output: benchmark1_result
