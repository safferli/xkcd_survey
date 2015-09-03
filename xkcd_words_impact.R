options(bitmapType='cairo')
options(scipen = 999)
# library(bbbi)
# library(data.table)
library(dplyr)
# library(tidyr)
library(ggplot2)

terms <- c(
  "NHL", 
  "Unitory", 
  "Rife",
  "Soliloquy",
  "Regolith",
  "Tribution",
  "Stipple",
  "Fination",
  "Modicum",
  "Trephony",
  "Amiable",
  "Fleek",
  "Apricity",
  "Lithe",
  "Revergent",
  "Cadine",
  "Phoropter",
  "Slickle",
  "Hubris",
  "Peristeronic",
  "Salient")



# https://trinkerrstuff.wordpress.com/2014/11/24/gtrendsr-package-to-explore-google-trending-for-field-dependent-terms/
# devtools::install_github("dvanclev/GTrendsR")
# devtools::install_github("trinker/gtrend")
library(GTrendsR)
library(gtrend)

phrases <- sprintf("\"%s\"", gsub("[-,]", " ", terms))


google.raw <- gtrend_scraper("christoph.safferling@googlemail.com", "password", terms)
#http://www.google.com/trends/explore#q=Soliloquy%2C%20Cadine&date=now%207-d&cmpt=q&tz=Etc%2FGMT-2

usr <- "christoph.safferling@googlemail.com"
psw <- "password"
ch <- GTrendsR::gconnect(usr, psw)  # or use env.var or options 

location <- "CA"
query <- "NHL"

data = gtrends(ch, query = query, geo = location)

ch <- GTrendsR::gconnect(usr, psw)


