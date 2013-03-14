## CHANGE TO YOUR WORKING DIRECTORY!! ##
workdir<-"/home/bst/student/hiparker/fSVA"

setwd(workdir)
library(ProjectTemplate)
load.project()

dat<-GSE2603_dat$dat
out<-GSE2603_dat$out

set.seed(12345)

n<-dim(dat)[2]

n.it<-100

simsize<-20

fast.out<-rep(0,n.it)
exact.out<-rep(0,n.it)
none.out<-rep(0,n.it)


tmp<-c(rep(2,n-2*simsize),rep(0,simsize),rep(1,simsize))

for(s in 1:n.it){
	print(s)
	# create random database vs. new samples index #
	ind<-sample(tmp,n,replace=FALSE)

	# sort into lists for later use #
	db.dat<-dat[,ind==0]
	db.out<-out[ind==0]
	newsamp.dat<-dat[,ind==1]
	newsamp.out<-out[ind==1]

	# run sva on the database (will be used later in fsva) #
	mod<-model.matrix(~as.factor(db.out))
	db.sva<-sva(db.dat,mod)

	fsva.res <- fsva(dbdat=db.dat, mod=mod, sv=db.sva, newdat=newsamp.dat, method="exact")	
	fast.fsva.res <- fsva(dbdat=db.dat, mod=mod, sv=db.sva, newdat=newsamp.dat, 
							 method="fast")



	# uncorrected #
	
	
	none.out[s] <- predictor_PAM(train.dat=db.dat, train.grp=db.out,
				   test.dat=newsamp.dat, test.grp=newsamp.out)

	exact.out[s] <- predictor_PAM(train.dat=fsva.res$db, train.grp=db.out,
					test.dat=fsva.res$new, test.grp=newsamp.out)

	fast.out[s] <- predictor_PAM(train.dat=fast.fsva.res$db, train.grp=db.out,
				   test.dat=fast.fsva.res$new, test.grp=newsamp.out)
}

GSE2603_PAM<-list(fast.out=fast.out,exact.out=exact.out,none.out=none.out,
				  simsize=simsize,n.it=n.it)
ProjectTemplate::cache("GSE2603_PAM")