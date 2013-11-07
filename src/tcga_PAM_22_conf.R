## CHANGE TO YOUR WORKING DIRECTORY!! ##
workdir <- "/home/bst/student/hiparker/fSVA"

setwd(workdir)
library(ProjectTemplate)
load.project()

dat <- exprs(ovEset)
tmp <- pData(ovEset)
tmp <- tmp[match(colnames(dat), tmp$File.Name), ]




# tmp[,20] = living/dead
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


table(out,tmp$batch)
# batch 18 and 21





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

# reduce to batches 18 and 21 only
dat <- dat[,tmp$batch==18 | tmp$batch==21]
out <- out[tmp$batch==18 | tmp$batch==21]
tmp <- tmp[tmp$batch==18 | tmp$batch==21,]
sum(colnames(dat)!=tmp$File.Name)
# should be 0


# separate data into two batches
batch <- tmp$batch
datA <- dat[,batch==18]
outA <- out[batch==18]
datB <- dat[,batch==21]
outB <- out[batch==21]

set.seed(12345)

n <- dim(dat)[2]

n.it <- 100

simsize <- 24

fast.out <- rep(0,n.it)
exact.out <- rep(0,n.it)
none.out <- rep(0,n.it)


# choose 10 out1 from batch A, 2 out0
# chosose 10 out0 from batch 21, 2 out1

for(s in 1:n.it){

    print(s)

    # batch A: 10 outcome 1s, 2 outcome 0s
    indA <- c(sample(which(outA==1),10), sample(which(outA==0),2))

    # batch B: 10 outcome 0s, 2 outcome 1s
    indB <- c(sample(which(outB==1),2), sample(which(outB==0),10))

    # sort into lists for later use #
    db.dat <- cbind(datA[,indA],datB[,indB])
    db.out <- c(outA[indA],outB[indB]) 

    # chose 3 of all combos for test set
    red_outA <- outA[-indA]
    red_outB <- outB[-indB]
    red_datA <- datA[,-indA]
    red_datB <- datB[,-indB]

    indA <- c(sample(which(red_outA==1),3), sample(which(red_outA==0),3))
    indB <- c(sample(which(red_outB==1),3), sample(which(red_outB==0),3))

    newsamp.dat <- cbind(red_datA[,indA],red_datB[,indB])
    newsamp.out <- c(red_outA[indA],red_outB[indB]) 


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

tcga_PAM_20<-list(fast.out = fast.out,
               exact.out = exact.out,
               none.out = none.out,
               simsize = simsize,
               n.it = n.it)
ProjectTemplate::cache("tcga_PAM_20")





