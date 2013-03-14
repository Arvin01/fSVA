## CHANGE TO YOUR WORKING DIRECTORY!! ##
workdir<-"/home/bst/student/hiparker/fSVA"

# Simulation 1 #
# B ~ N(0,1)
# \Gam ~ N(0,6)
# U ~ N(0,5)
# 50% probes w/ batch
# 50% probes w/ out
# 40% probes both

setwd(workdir)
library(ProjectTemplate)
load.project()

# set the confounding levels I'll be looking at (confounding in the database only) #
p.conf<-seq(0.50,0.95,by=0.05)

# set up results matrix #
res<-matrix(NA,nrow=1,ncol=6)
colnames(res) <- c("No","Oracle","SVA","exactfSVA","fastfSVA","Corr")
# create results matrix for all 4 scenarios #
res1 <- list(res)

# number of iterations needed #
len<-100

# housekeeping
temp <- res

# loop
for(z in 1:length(p.conf)){
	# set seed here ensures that the same oracle dataset is created for each correlation level
	set.seed(12345)

	# iterate simulations at each corr level for robust results
	for(i in 1:len){
		sim <- sim_dat(n.e=10000, n.db=100, n.ns=100,
						sv.db=c("A","B"), sv.ns=c("A","B"),
						sd.b=1, sd.gam=6, sd.u=5,
						conf=TRUE, distr.db=p.conf[z],
						p.b=0.5, p.gam=0.5, p.ov=0.4)
		temp <- rbind(temp,sim_eval(sim))
	}

	# record results and clear out temp object
	res1[[z]] <- temp
	temp <- res
}

# remove NAs
for(j in 1:length(p.conf)){
	res1[[j]]<-res1[[j]][-1,]
}

# save results
ProjectTemplate::cache("res1")