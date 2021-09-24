source("SeriesCatalog_Module.R")
source("Plot_Module.R")
source("Console_Module.R")

library(dplyr)
library(rlang)
library(shiny)
library(ODMr)
options(shiny.maxRequestSize = 50 * 1024^2)

ODM <- pool::dbPool(odbc::odbc(), Driver = "SQL Server", 
                    Server = "10.200.24.23\\SQLCHM", 
                    UID = "sa", PWD = "$dorset20", 
                    Database = "ODM_Dorset", 
                    port = 64450)
