## "leekasso" predictor ##
## not used in paper ##

predictor<-function(train.dat, train.grp, test.dat, test.grp){

	library(genefilter)
	library(sva)
	
	nsamp <- dim(train.dat)[2]
	mod0 <- matrix(1,nrow=nsamp,ncol=1)
	mod <- model.matrix(~train.grp)
	
	ps <- f.pvalue(train.dat,mod,mod0)
	topten <- sort(which(rank(ps,ties.method="first")<=10))
	#if(length(topten)>10){topten<-topten[1:10]}
	#if(length(topten)<10){next()}
	train.minmat <- t(train.dat[topten,])
	test.minmat <- t(test.dat[topten,])
	
	colnames(train.minmat)->tmp

	fit <- lm(train.grp~train.minmat)
	coefs <- fit$coef
	
	pred <- coefs[1]+
			coefs[2]*test.minmat[,1]+
			coefs[3]*test.minmat[,2]+
			coefs[4]*test.minmat[,3]+
			coefs[5]*test.minmat[,4]+
			coefs[6]*test.minmat[,5]+
			coefs[7]*test.minmat[,6]+
			coefs[8]*test.minmat[,7]+
			coefs[9]*test.minmat[,8]+
			coefs[10]*test.minmat[,9]+
			coefs[11]*test.minmat[,10]
	
	return(mean((pred > 0.5) == test.grp))
}

