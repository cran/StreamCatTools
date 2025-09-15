## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  warning = FALSE, 
  message = FALSE
)

## ----message=FALSE, eval=FALSE------------------------------------------------
# res <- jsonlite::fromJSON("https://api.epa.gov/StreamCat/lakes/metrics?name=pcturbmd2006&areaOfInterest=cat&comid=22538788")
# res$items

## ----name_params--------------------------------------------------------------
library(StreamCatTools)
region_params <- lc_get_params(param='areaOfInterest')

name_params <- lc_get_params(param='metric_names')

print(paste0('region parameters are: ', paste(region_params,collapse = ', ')))
print(paste0('A selection of available LakrCat metrics include: ',paste(name_params[1:10],collapse = ', ')))

## ----params2------------------------------------------------------------------
var_info <- lc_get_params(param='variable_info')
head(var_info)

## ----fullnames----------------------------------------------------------------
metric='pcthbwet2016'
fullname <- lc_fullname(metric)
fullname

## ----fullnames2---------------------------------------------------------------
metric=c('pctdecid2019','fert')
fullname <- lc_fullname(metric)
fullname

## ----comids, warning=FALSE, message=FALSE-------------------------------------
dd <- data.frame(x = c(-89.198,-114.125,-122.044),
                 y = c(45.502,47.877,43.730)) |> 
  sf::st_as_sf(coords = c('x', 'y'), crs = 4326)
    
comids <- lc_get_comid(dd)

## ----get_data-----------------------------------------------------------------
df <- lc_get_data(metric='pcturbmd2006,damdens', aoi='cat,ws', comid=comids)
knitr::kable(df)

## ----get_data2----------------------------------------------------------------
df <- lc_get_data(metric='pcturbmd2006,damdens', aoi='cat,ws', comid='23783629,23794487,23812618')
knitr::kable(df)

## ----countydata---------------------------------------------------------------
df <- lc_get_data(metric='pctwdwet2006', aoi='ws', county='41003')
knitr::kable(head(df))

## ----get_nlcd-----------------------------------------------------------------
df <- lc_nlcd(comid='23783629,23794487,23812618', year='2019', aoi='ws')
knitr::kable(df)

