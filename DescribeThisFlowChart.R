rm(list=ls())
PathOutputFolder=paste0(thisdir,"/g_describeHTML")

if (!require("rmarkdown")) install.packages("rmarkdown")
library(rmarkdown )

# Directories

# set directories
thisdir<-getwd()

dirinput <- paste0(thisdir,"/i_input/")
PathOutputFolder <- paste0(thisdir,"/g_describeHTML/")
dirmacro <- paste0(thisdir, "/p_macro/")
suppressWarnings(if (!file.exists(PathOutputFolder)) dir.create(file.path( PathOutputFolder)))


# import data
FlowChart<- fread(paste0(dirinput, "Flowchart_doses.csv"))


##########################  TO BE INCORPORATED



PathOutputFolder=paste0(thisdir,"/g_describeHTML")

if (!require("rmarkdown")) install.packages("rmarkdown")
library(rmarkdown )

render(paste0(dirmacro,"FlowChart_Description.Rmd"),           
       output_dir=PathOutputFolder,
       output_file="FlowChart", 
       params=list(FlowChart = FlowChart)) 


