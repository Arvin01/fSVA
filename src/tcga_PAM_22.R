## CHANGE TO YOUR WORKING DIRECTORY!! ##
workdir <- "C:/Users/Hilary/GitHub/fSVA/"

setwd(workdir)
library(ProjectTemplate)
load.project()

dat <- exprs(ovEset)
tmp <- pData(ovEset)
tmp <- tmp[match(colnames(dat), tmp$File.Name), ]



# # tmp[,20] = living/dead
# out <- rep(NA, dim(dat)[2])
# out[tmp[,20] == "DECEASED"] <- 1
# out[tmp[,20] == "LIVING"] <- 0


# # tmp[,21] = tumor stage
# out <- rep(NA, dim(dat)[2])
# out[tmp[,21] == "IIA" | 
    # tmp[,21] == "IIB" | 
	# tmp[,21] == "IIC" | 
	# tmp[,21] == "IIIA" | 
	# tmp[,21] == "IIIB" ] <- 0
# out[tmp[,21] == "IIIC" | 
    # tmp[,21] == "IV" ] <- 1


# tmp[,22] = tumor grade
out <- rep(NA, dim(dat)[2])
out[tmp[,22] == "G2"] <- 1
out[tmp[,22] == "G3"] <- 0

# # tmp[,24] = tumor primary outcome (used below)
# out <- rep(NA, dim(dat)[2])
# out[tmp$PRIMARYTHERAPYOUTCOMESUCCESS == "COMPLETE RESPONSE"] <- 1
# out[tmp$PRIMARYTHERAPYOUTCOMESUCCESS == "STABLE DISEASE" | 
    # tmp$PRIMARYTHERAPYOUTCOMESUCCESS == "PARTIAL RESPONSE" | 
	# tmp$PRIMARYTHERAPYOUTCOMESUCCESS == "PROGRESSIVE DISEASE"] <- 0


# # tmp[,25] = neoplasma cancer status
# out <- rep(NA, dim(dat)[2])
# out[tmp[,25] == "WITH TUMOR"] <- 1
# out[tmp[,25] == "TUMOR FREE"] <- 0


# # tmp[,27] = progression-free status
# out <- rep(NA, dim(dat)[2])
# out[tmp[,27] == "DiseaseFree"] <- 0
# out[tmp[,27] == "Recurred/Progressed"] <- 1

# # tmp[,30] = platinum status (?) -- too early, sensitive, missing, resistant
# out <- rep(NA, dim(dat)[2])
# out[tmp[,30] == "Sensitive"] <- 0
# out[tmp[,30] == "Resistant"] <- 1


#################


dat <- dat[,!is.na(out)]
tmp <- tmp[!is.na(out),]
out <- out[!is.na(out)]
sum(colnames(dat)!=tmp$File.Name)
# should be 0




set.seed(12345)

n <- dim(dat)[2]

n.it <- 100

simsize <- 50

fast.out <- rep(0,n.it)
exact.out <- rep(0,n.it)
none.out <- rep(0,n.it)


tmp<-c(rep(2, n-2*simsize), rep(0,simsize),rep(1,simsize))

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

tcga_PAM<-list(fast.out = fast.out,
               exact.out = exact.out,
			   none.out = none.out,
			   simsize = simsize,
			   n.it = n.it)
ProjectTemplate::cache("tcga_PAM")