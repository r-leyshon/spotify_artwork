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
library(configr)
library(ggplot2)

# source credentials ------------------------------------------------------
source("R/config_secrets.R")
source("R/get_album_deets.R")
source("R/artwork.R")

# configure access token --------------------------------------------------
config_secrets("credentials/credentials.toml")
# pull from system variables configured above
access_token <- get_spotify_access_token()

# read data ---------------------------------------------------------------
# detect the tsv in the data folder
datafile <- list.files("data", pattern = "*.tsv")
# read the file in
album_tracker <- read.delim(paste("data", datafile, sep = "/"))

# query api ---------------------------------------------------------------
album_metadata <- get_album_deets(album_tracker$album_id)

# save a patchwork album art ----------------------------------------------
patch_artwork(album_list = album_metadata, save_path = "plots/newplot.png")


