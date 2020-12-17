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
album_tracker$img_url <- unlist(list.select(all_albums, images$url[1]))

# query albums ------------------------------------------------------------

# test_album <- get_album("0TkfHTK2sSV4CxrQWqBrNF")
# myurl <-  test_album[["images"]][["url"]][1]
# images <- image_read(myurl)



