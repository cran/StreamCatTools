## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  warning = FALSE, 
  message = FALSE
)

## ----message=FALSE, eval=FALSE------------------------------------------------
# library(devtools)
# install_github('USEPA/StreamCatTools')

## ----message=FALSE------------------------------------------------------------
library(StreamCatTools)

## ----API----------------------------------------------------------------------
res <- jsonlite::fromJSON("https://api.epa.gov/StreamCat/streams/metrics?name=fert&areaOfInterest=cat&comid=179")
res$items

## ----params-------------------------------------------------------------------
region_params <- sc_get_params(param='aoi')

name_params <- sc_get_params(param='metric_names')

print(paste0('region parameters are: ', paste(region_params,collapse = ', ')))
print(paste0('A selection of available StreamCat metrics include: ',paste(name_params[1:10],collapse = ', ')))

## ----params2------------------------------------------------------------------
var_info <- sc_get_params(param='variable_info')
head(var_info)

## ----fullnames----------------------------------------------------------------
metric='pcthbwet2011'
fullname <- sc_fullname(metric)
fullname

## ----fullnames2---------------------------------------------------------------
metric='pctdecid2019,fert'
fullname <- sc_fullname(metric)
fullname

## ----states-------------------------------------------------------------------
states <- sc_get_params(param='state')
head(states)

## ----counties-----------------------------------------------------------------
counties <- sc_get_params(param='county')
head(counties)

## ----get_metric_names---------------------------------------------------------
metrics <- sc_get_metric_names(category = c('Deposition','Climate'),aoi=c('Cat','Ws'))
head(metrics)

## ----get_data-----------------------------------------------------------------
df <- sc_get_data(metric='pcturbmd2006,damdens,tridens', aoi='rp100cat,cat,ws', comid='179,1337,1337420')
knitr::kable(df)

## ----countydata---------------------------------------------------------------
df <- sc_get_data(metric='pctwdwet2006', aoi='ws', county='41003')
knitr::kable(head(df))

## ----all----------------------------------------------------------------------
df <- sc_get_data(comid='179', aoi='cat', metric='all')
knitr::kable(head(df))

## ----get_nlcd-----------------------------------------------------------------
df <- sc_nlcd(year='2001', aoi='cat',
              comid='179,1337,1337420')
knitr::kable(df)

## ----get_nlcd2----------------------------------------------------------------
df <- sc_nlcd(year='2006, 2019', aoi='ws',
              county='41003')
knitr::kable(head(df))

## ----comids, eval=FALSE-------------------------------------------------------
# gages = readr::read_csv(system.file("extdata","Gages_flowdata.csv", package = "StreamCatTools"),show_col_types = FALSE)
# # we'll just grab a few variables to keep things simple
# gages <- gages[,c('SOURCE_FEA','STATION_NM','LON_SITE','LAT_SITE')]
# gages_coms <- sc_get_comid(gages, xcoord='LON_SITE',                   ycoord='LAT_SITE', crsys=4269)
# 
# # Add the COMID we found back to gages data frame
# gages$COMID <- strsplit(gages_coms, ",")[[1]]
# df <- sc_get_data(metric='huden2010', aoi='ws', comid=gages_coms)
# df$COMID <- as.character(df$comid)
# gages <- dplyr::left_join(gages, df, by='COMID')
# knitr::kable(head(gages))

## ----hydroregion--------------------------------------------------------------
df <- sc_get_data(metric='pctwdwet2006', aoi='ws', region='Region17')
knitr::kable(head(df))

## ----conus, eval=FALSE--------------------------------------------------------
# # df <- sc_get_data(metric='om', aoi='ws', conus='true')
# # knitr::kable(head(df))

