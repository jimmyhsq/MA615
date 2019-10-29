library(DBI)
library(tidyverse)
library(RSQLite)
library(readxl)

db <- read_excel("Top MA Donors 2016-2020(1).xlsx")
Direct_JFC <- read_excel("Top MA Donors 2016-2020(1).xlsx", sheet = "Direct & JFC")
JFC <- read_excel("Top MA Donors 2016-2020(1).xlsx", sheet = "JFC")

Direct_JFC['contrib'] <- gsub(pattern = ", ",replacement = ",",Direct_JFC$contrib)
Direct_JFC['contrib'] <-gsub(pattern = "\\s\\w*",replacement = "",Direct_JFC$contrib)


Contribution <- Direct_JFC %>% select(cycle,contribid,fam,contrib,date, amount, recipid,type,fectransid,cmteid)%>% distinct()
Donor <- Direct_JFC %>% select(contribid,fam,contrib,City,State,Zip,Fecoccemp,orgname,lastname)%>% distinct()
Recipient <- Direct_JFC %>% select(recipid,recipient,party,recipcode) %>% distinct()
Organization <-Direct_JFC %>% select(orgname, ultorg) %>% na.omit()


Con = dbConnect(SQLite(),"Shuoqi_Huang.sqlite") 
dbWriteTable(Con,"Contribution",Contribution)
dbWriteTable(Con,"Donor",Donor)
dbWriteTable(Con,"Recipient",Recipient)
dbWriteTable(Con,"Organization",Organization)