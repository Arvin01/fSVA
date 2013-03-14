## CHANGE TO YOUR WORKING DIRECTORY!! ##
workdir<-"/home/bst/student/hiparker/fSVA"

# Simulation 2 #
# B ~ N(0,1)
# \Gam ~ N(0,4)
# U ~ N(0,3)
# 80% probes w/ batch
# 80% probes w/ out
# 50% probes both

setwd(workdir)
library(ProjectTemplate)
load.project()

# set the confounding levels I'll be looking at (confounding in the database only) #
p.conf<-seq(0.50,0.95,by=0.05)

# set up results matrix #
res<-matrix(NA,nrow=1,ncol=6)
colnames(res) <- c("No","Oracle","SVA","exactfSVA","fastfSVA","Corr")
# create results matrix for all 4 scenarios #
res2 <- list(res)

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
						sd.b=1, sd.gam=4, sd.u=3,
						conf=TRUE, distr.db=p.conf[z],
						p.b=0.8, p.gam=0.8, p.ov=0.5)
		temp <- rbind(temp,sim_eval(sim))
	}

	# record results and clear out temp object
	res2[[z]] <- temp
	temp <- res
}

# remove NAs
for(j in 1:length(p.conf)){
	res2[[j]]<-res2[[j]][-1,]
}

# save results
ProjectTemplate::cache("res2")
