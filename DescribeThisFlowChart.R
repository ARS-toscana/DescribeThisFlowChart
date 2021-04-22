rm(list=ls())
if (!require("ggplot2")) install.packages("ggplot2") 
library(ggplot2)
if (!require("data.table")) install.packages("data.table")
library(data.table)
if (!require("lubridate")) install.packages("lubridate")
library(lubridate )
if (!require("rmarkdown")) install.packages("rmarkdown")
library(rmarkdown )

# set directories
thisdir<-getwd()

dirinput <- paste0(thisdir,"/i_input/")
dirdescribe <- paste0(thisdir,"/g_describeHTML/")

suppressWarnings(if (!file.exists(dirdescribe)) dir.create(file.path( dirdescribe)))


# import data
Flowchart_doses<- fread(paste0(dirinput, "Flowchart_doses.csv"))
FlowChart<-Flowchart_doses#[20:22]

FlowChart<-data.frame(FlowChart)

n_criteria<-dim(FlowChart)[2]-2
nrow<-dim(FlowChart)[1]
criteria<-names(FlowChart)[2:(n_criteria+1)]


#######################

for(i in criteria){
  for(j in seq(1, dim(FlowChart)[1])){
    if(FlowChart[j, i]==0){
      FlowChart[j, i]=-1
    }
    if(FlowChart[j, i]==1){
      FlowChart[j, i]=-2
    }
  }
}


FlowChart$Included=-3

for(i in seq(1, nrow)){
  
  row=FlowChart[i, ][2:(n_criteria+1)]
  criteria_position<-(n_criteria+2) - length(row[row==-1])
  
  if(length(row[row==-1]) == 0){
    FlowChart[i, "Included" ]=FlowChart[i, "N"] 
  }else{
    FlowChart[i, criteria_position ] = FlowChart[i, "N"]
  }
}



FlowChart<-data.table(FlowChart)
FlowChart_reshaped<-melt(FlowChart, measure.vars = c(criteria, "Included") )
FlowChart_reshaped_plot<-FlowChart_reshaped[value>=0,][,-"value"]


##########

ggplot(FlowChart_reshaped_plot, aes(monday_week, N, fill=variable))+
  geom_col(position="fill")+
  scale_y_continuous(labels = scales::percent_format())








