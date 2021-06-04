"Purpose of script:
query spotify api for album artwork.
list of albums in data folder.
"
# load packages -----------------------------------------------------------
library(spotifyr)
library(magick)
library(readxl)
library(rlist)
library(patchwork)

# source credentials ------------------------------------------------------
source("credentials/credentials.R")

# get access token --------------------------------------------------------
# pulled from system variables configured in credentials.R
access_token <- get_spotify_access_token()


# import data ------------------------------------------
# detect the tsv in the data folder
datafile <- list.files("data", pattern = "*.tsv")
# read the file in
album_tracker <- read.delim(paste0("data/", datafile))
# use spotifyr client to get album details
all_albums <- lapply(album_tracker$album_id, get_album)

# select urls -------------------------------------------------------------
# cbind to dataframe
# take the second url which is a mid-size image
album_tracker$img_url <- unlist(list.select(all_albums, images$url[2]))
#album_tracker$img_url <- unlist(list.select(all_albums, images$url[1]))


# read artwork images -----------------------------------------------------

read_artworks <- function(urls){
  print(urls)
  # read in the image
  img <- image_read(urls)
  # convert to ggplot for easy patchwork
  plt <- image_ggplot(img, interpolate = FALSE)
  return(plt)
}

all_artworks <- lapply(album_tracker$img_url, read_artworks)



# patchwork combine -------------------------------------------------------
combined_artworks <- wrap_plots(all_artworks)
