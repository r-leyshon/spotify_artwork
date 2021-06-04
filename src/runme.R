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

# source credentials ------------------------------------------------------
source("R/config_secrets.R")

# configure access token --------------------------------------------------
config_secrets("credentials/credentials.toml")
# pull from system variables configured above
access_token <- get_spotify_access_token()