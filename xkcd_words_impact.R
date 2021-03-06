options(bitmapType='cairo')
options(scipen = 999)
# library(bbbi)
# library(data.table)
library(dplyr)
library(tidyr)
library(ggplot2)

# Define your workspace: "X:/xxx/"
wd <- "D:/github/xkcd_survey/"
setwd(wd)


terms <- c(
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


f.gtrend.csv.read <- function(x){
  read.csv(file=paste0("data/report_", sprintf("%02d", as.numeric(x)), ".csv"), 
           na.strings = " ", 
           stringsAsFactors = FALSE,
           # 173 is last timeseries row, minus skip, minus header = 168
           skip = 4, nrows = 168)
}

# merge all four google .csvs 
data.raw <- f.gtrend.csv.read(1) %>% 
  merge(f.gtrend.csv.read(2)) %>% 
  merge(f.gtrend.csv.read(3)) %>% 
  merge(f.gtrend.csv.read(4)) %>% 
  mutate(
    Time = as.POSIXct(strptime(Time, "%Y-%m-%d-%H:%M UTC", tz="UTC"))
  )


# big pile of trend lines, starting September-01
data.raw %>% 
  gather(term, trend, -Time) %>% 
  ggplot()+
  geom_line(size=1)+
  aes(x=Time, y=trend, colour=term)+
  coord_cartesian(xlim = c(as.POSIXct(strptime("2015-09-01", "%Y-%m-%d", tz="UTC")),
                           max(data.raw$Time)))+
  ggtitle("Google Search Trends of the xkcd survey English Terms")
ggsave(file="xkcd-messy-trends.png")


# faceted for better overview
data.raw %>% 
  gather(term, trend, -Time) %>% 
  ggplot()+
  geom_line(size=1)+
  aes(x=Time, y=trend, colour=term)+
  coord_cartesian(xlim = c(as.POSIXct(strptime("2015-09-01", "%Y-%m-%d", tz="UTC")),
                           max(data.raw$Time)))+
  facet_wrap(~term)+
  guides(colour=FALSE)+
  theme(axis.text.x=element_text(angle = 45, hjust = 1))+
  ggtitle("Google Search Trends of the xkcd survey English Terms")
ggsave(file="xkcd-facet-trends.png")





