# code for evaluation simulation output #
	
sim_eval<-function(simdat){

	### Housekeeping ###
	db<-simdat$db
	new<-simdat$new
	res<-matrix(NA,nrow=1,ncol=6)
	colnames(res) <- c("No","Oracle","SVA","exactfSVA","fastfSVA","Corr")


	
	### Predictor on no adjustment ###
	res[1,1]<-predictor_PAM(train.dat=db$dat, train.grp=db$S,
			  test.dat=new$dat, test.grp=new$S)
	

	
	### Predictor on "Oracle" (no batch included in simulation) ###
	res[1,2] <- predictor_PAM(train.dat=db$datnobatch, train.grp=db$S,
			  test.dat=new$datnobatch, test.grp=new$S)
	
	
	
	### Predictor on sva (on database) only ###
	modSv <- cbind(db$mod, db$sv$sv)
	nmod = dim(db$mod)[2]
	gammahat = (db$dat %*% modSv %*% solve(t(modSv) %*% modSv))[, (nmod +
        1):(nmod + db$sv$n.sv)]
    db$adj = db$dat - gammahat %*% t(db$sv$sv)
	
	res[1,3] <- predictor(train.dat=db$adj, train.grp=db$S,
			  test.dat=new$dat, test.grp=new$S)
	
	
	
	### Predictor on exact fsva ###
	fsva.exact <- fsva(dbdat=db$dat, mod=db$mod, sv=db$sv, newdat=new$dat, method="exact")	
	res[1,4] <- predictor_PAM(train.dat=fsva.exact$db, train.grp=db$S,
							  test.dat=fsva.exact$new, test.grp=new$S)	
			 


	### Predictor on fast fsva ###
	fsva.fast <- fsva(dbdat=db$dat, mod=db$mod, sv=db$sv, newdat=new$dat, method="fast")	
	res[1,5] <- predictor(train.dat=fsva.fast$db, train.grp=db$S,
						  test.dat=fsva.fast$new, test.grp=new$S)
	
	### Get correlation between batch and outcome (for x-axis in figure) ###
	res[1,6] <- cor(db$G,db$S)
			  
	return(res)
}