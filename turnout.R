---
title: "2014_Election_Turnout"
author: "Warwick Taylor"
date: "4 March 2017"
output: html_document
---

```{r }
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r }
GeneralElectorateTurnout<-data.frame(name=General_turnout_2014[,1],
lat=ElectLocs$ElectLat,
lng=ElectLocs$ElectLong,
turnout=General_turnout_2014[,13])

turnmap<-GeneralElectorateTurnout %>%
  leaflet() %>%
  addTiles() %>%
  addCircles(weight=1,radius=GeneralElectorateTurnout$turnout*10, color = "orange")
turnmap
```

