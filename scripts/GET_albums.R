"Purpose of script:
query spotify api for album artwork.
list of albums in data folder.
"
# load packages -----------------------------------------------------------
library(spotifyr)
library(magick)
library(readxl)
library(rlist)

# source credentials ------------------------------------------------------
source("credentials/credentials.R")

# get access token --------------------------------------------------------
# pulled from system variables configured in credentials.R
access_token <- get_spotify_access_token()


# import data ------------------------------------------

album_tracker <- read.delim("data/album_tracker.tsv")

all_albums <- lapply(album_tracker$album_id, get_album)

# select urls -------------------------------------------------------------
# cbind to dataframe
# take the second url which is a mid-size image
album_tracker$img_url <- unlist(list.select(all_albums, images$url[2]))


# read artwork images -----------------------------------------------------

read_artworks <- function(urls){
  print(urls)
  img <- image_read(urls)
  return(img)
}

all_artworks <- lapply(album_tracker$img_url, read_artworks)



# patchwork combine -------------------------------------------------------



