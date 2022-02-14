## Spotify Artwork

### Version 0.2

#### Features

* Convert credentials to toml
* ggsave writes patchwork object
* Added data dictionary to docs
* Customisation of patchwork panel & text
* artwork.R funcs now cope with spotify album IDs and direct image urls (in the rare instance that the album is not available on spotify)


#### Backlog

* Modules
* If more than one tsv is detected in the data folder, only read the most recent date.
* '...' error cleansing
* Document all funcs
* Function to create patchwork for every album contributor
* Function to create contributor album timeline - barbell plot using {ggalt}
* Add example barplot to readme with anonymised names - only worth doing if pursuing above
* errors in read_artworks need to propagate through to patch artworks


## ToDo

If more than one tsv is detected in the data folder, only read the most recent date.