"handle xlsx files, write to tsv."
library(readxl)
library(rlist)
library(dplyr)
files <- list.files("data", full.names = TRUE)
xlsx_files <- files[grepl(".xlsx$", files)]

if(length(xlsx_files) == 0) {
  message("No xlsx files found")
} else {
  xlsx_list <- lapply(xlsx_files, read_excel)
  stacked_table <- list.stack(xlsx_list)
  # drop the date column
  stacked_table <- select(stacked_table, -Date_tracking)
  # drop NAs
  stacked_table <- filter(stacked_table, across(everything(), ~ !is.na(.)))
  # prep filenm
  lubridate::today()
  filenm <- paste0("data/",
                   as.Date(lubridate::today(), "%m-%d-%y"),
                   "_albums.tsv")
  write.table(stacked_table, filenm, row.names = FALSE, sep = "\t")
}

# need to remove any "..." prior to writing to tsv.


