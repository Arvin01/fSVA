rm(list=ls())
source("/home/bst/student/hiparker/fSVA/code/make_table.R")

### First get results saved into right format ###
## GSE2034 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE2034_dat.RData",
	file2 = "batch_GSE2034_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE2034_tableres.RData"
)

## GSE2603 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE2603_dat.RData",
	file2 = "batch_GSE2603_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE2603_tableres.RData"
)

## GSE2990 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE2990_dat.RData",
	file2 = "batch_GSE2990_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE2990_tableres.RData"
)



## GSE10927 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE10927_dat.RData",
	file2 = "batch_GSE10927_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE10927_tableres.RData"
)


## GSE13911 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE13911_dat.RData",
	file2 = "batch_GSE13911_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE13911_tableres.RData"
)


## GSE3744 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE3744_dat.RData",
	file2 = "batch_GSE3744_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE3744_tableres.RData"
)


## GSE7696 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE7696_dat.RData",
	file2 = "batch_GSE7696_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE7696_tableres.RData"
)


## GSE4183 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE4183_dat.RData",
	file2 = "batch_GSE4183_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE4183_tableres.RData"
)


## GSE6764 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE6764_dat.RData",
	file2 = "batch_GSE6764_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE6764_tableres.RData"
)


## GSE13041 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE13041_dat.RData",
	file2 = "batch_GSE13041_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE13041_tableres.RData"
)


## GSE8671 ##
make_table(
	wd = "/home/bst/student/hiparker/fSVA/objs",
	file1 = "GSE8671_dat.RData",
	file2 = "batch_GSE8671_PAM.RData",
	savewd = "/home/bst/student/hiparker/fSVA/objs/tableres",
	filename = "GSE8671_tableres.RData"
)


### Second actually make the table ###
setwd("/home/bst/student/hiparker/fSVA/objs/tableres")
files<-dir()
resmat <- matrix(nrow=length(files),ncol=10)
colnames(resmat) <- c("Accession Number","Outcome","Preprocessing","Num of Iterations","Num in build/test sets",
					  "No fSVA Results","Exact Results","Fast Results",
					  "Winner Exact v. None","Winner Fast v. None")
for(i in 1:length(files)){
	load(files[i])
	resmat[i,]<-c(acc,descr,preproc,n.it,simsize,none.quants,exact.quants,fast.quants,test1,test2)
}

library(xtable)
xtable(resmat)

## go through and delete stupd \'s