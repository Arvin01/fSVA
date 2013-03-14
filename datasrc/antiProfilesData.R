

################################################################################
############################  Hector's data  ###################################
################################################################################

load("antiProfilesData.rda")

exper<-tab$ExperimentID
exper.ids<-unique(exper)
len<-length(exper.ids)

setwd("/home/bst/student/hiparker/fSVA/objs")
for(i in 1:len){
	print(i)
	acc<-exper.ids[i]
	ind<-which(exper==exper.ids[i])
	if(length(ind)<20){next}
	out<-tab$SubType[ind]
	if(length(unique(out))==1){next}
	dat<-e[,ind]
	
	tis<-unique(tab$Tissue[ind])
	len1<-length(tis)
	len2<-length(unique(out))
	j<-1
	k<-1
	descr<-""
	while(j<=len1){
		descr<-paste(descr,tis[j])
		j<-j+1
	}
	while(k<=len2){
		descr<-paste(descr,unique(out)[k])
		k<-k+1
	}
	
	preproc<-"hector"
	save(list=c("dat","out","acc","descr","preproc"),
		 file=paste(acc,"_dat.RData",sep=""))
}

setwd("/home/bst/student/hiparker/fSVA/data/hector")
## 12 datasets were collected ##
files<-dir()
setwd("/home/bst/student/hiparker/fSVA/objs")

load(files[1])
acc
# "GSE10927"
out
dat<-dat[,-which(out=="normal")]
out<-out[-which(out=="normal")]
length(out)
# 27 27
save(list=c("dat","out","acc","descr","preproc"),
	file="GSE10927_dat.RData")



load(files[2])
acc
# "GSE11151"
out
length(out)
# only 5 normals, not enough realistically
	

load(files[3])
acc
# "GSE13041"
out
length(out)
# 13 13


load(files[4])
acc
# "GSE13732"
out
length(out)
# weird outcome, not going to pursue #


load(files[5])
acc
# "GSE13911"
out
length(out)
# 30 30


load(files[6])
acc
# "GSE3744"
out # only 7 normals but will try anyway
length(out)
# 23 23


load(files[7])
acc
# "GSE4183"
out
dat<-dat[,-which(out=="normal")]
out<-out[-which(out=="normal")]
length(out)
# 15 15
save(list=c("dat","out","acc","descr","preproc"),
	file="GSE4183_dat.RData")


load(files[8])
acc
# "GSE6764"
out
# create early vs advanced outcome
out2<-out[-which(out=="normal")]
dat<-dat[,-which(out=="normal")]
out<-rep("early",length(out2))
out[out2=="advanced_hcc"]<-"advanced"
out[out2=="very_advanced_hcc"]<-"advanced"
length(out)
# 11 11
save(list=c("dat","out","acc","descr","preproc"),
	file="GSE6764_dat.RData")



load(files[9])
acc
# "GSE6791"
# only 4 normals, not enough


load(files[10])
acc
# "GSE7553"
out
# only 4 normals, not enough


load(files[11])
acc
# "GSE7696"
out
length(out)
# 35 35


load(files[12])
acc
# "GSE8671"
out
length(out)
# 15 15
