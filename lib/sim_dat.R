# simulating X = BS + \Gamma G + U
# S = Biological group
# G = Batch
# U = random error

# NOTE:  If you use conf=TRUE, then you must have exactly two surrogate variables in the database #
# this function only allows for confounding in the database, not confounding in the new samples #

sim_dat <- function(n.e=1000, n.db=70, n.ns=30,
				   sv.db=c("A","B"), sv.ns=c("A","B"),
				   sd.b=1, sd.gam=1, sd.u=1,
				   conf=FALSE, distr.db=NA,
				   p.b=0.3, p.gam=0.3, p.ov=0.1
				   ){
	
	n <- n.db+n.ns
	# Create random error
	U <- matrix(nrow=n.e,ncol=n,rnorm(n.e*n,sd=sd.u))
	
	# Create index for database vs. new sample #
	ind <- as.factor(c(rep("db",n.db), rep("ns",n.ns)))
	
	# Create outcome, surrogate variables #
	# Use distr option to show % overlap of outcome, surrogate variables. #
	# Note that .5 means no confounding between outcome, surrogate variables. #

	# biological variable (fixed at 50% for each outcome)
	S.db <- c(rep(0,round(.5*n.db)),rep(1,n.db-round(.5*n.db)))
	S.ns <- c(rep(0,round(.5*n.ns)),rep(1,n.ns-round(.5*n.ns)))
	S <- c(S.db, S.ns)
	
	len0 <- sum(S.db==0)
	len1 <- sum(S.db==1)
		
	if(conf==FALSE){
		# surrogate variable (no confounding in this function)
		n.sv.db <- length(sv.db)
		prop.db <- 1/n.sv.db
		
		
		# create surrogate variables for outcome 0 in database #
		x1<-c()
		for(i in 1:n.sv.db){
			x1<-c(x1,rep(sv.db[i],floor(prop.db*len0)))
		}
		# If the rounding has caused a problem, randomly assign to fill out vector #
		while(length(x1)!=len0){
			x1<-c(x1,sample(sv.db,1))
		}
		
		# surrogate variables for outcome 1 will be the same #
		# this helps control for the randomly assignment - makes sure there is no #
		# added confounding #
		
		x2 <- x1
	}
	
	if(conf==TRUE){
	
	x1<-c(rep("A",round(distr.db*len0)),
		  rep("B",len0-round(distr.db*len0)))
		  
	x2<-c(rep("A",round((1-distr.db)*len1)),
		  rep("B",len1-round((1-distr.db)*len1)))
	
	
	}
	
	
	# create surrogate variables for outcome 0 in new samples #
	n.sv.ns <- length(sv.ns)
	prop.ns <- 1/n.sv.ns

	len0 <- sum(S.ns==0)
	len1 <- sum(S.ns==1)
	
	x3<-c()
	for(i in 1:n.sv.ns){
		x3<-c(x3,rep(sv.ns[i],floor(prop.ns*len0)))
	}
	# If the rounding has caused a problem, randomly assign to fill out vector #
	while(length(x3)!=len0){
		x3<-c(x3,sample(sv.ns,1))
	}
	
	# surrogate variables for outcome 1 will be the same #
	# this helps control for the randomly assignment - makes sure there is no #
	# added confounding #
	
	x4 <- x3
	
	
	G <- c(x1,x2,x3,x4)	
	G <- t(model.matrix(~as.factor(G)))[-1,]
	if(is.null(dim(G))){
		G <- matrix(G,nrow=1,ncol=n)
	}
	
	
	# Determine which probes are affected by what: #
	# 30% for biological, 30% for surrogate, 10% overlap #
	# First 30% of probes will be affected by biological signal #
	ind.B <- rep(0,n.e)
	ind.B[1:round(p.b*n.e)] <- 1
	# Probes 20% thru 50% will be affected by surrogate variable
	ind.Gam <- rep(0,n.e)
	ind.Gam[round((p.b-p.ov)*n.e):round((p.b-p.ov+p.gam)*n.e)] <- 1
	
	# figure out dimensions for Gamma #
	
	# create parameters for signal, noise #
	B<-matrix(nrow=n.e,ncol=1,rnorm(n.e,mean=0,sd=sd.b)*ind.B)
	Gam<-matrix(nrow=n.e,ncol=dim(G)[1],rnorm(n.e*dim(G)[1],mean=0,sd=sd.gam)*ind.Gam)
	
	# simulate the data #
	sim.dat<- B %*% S + Gam %*% G + U
	sim.dat<-sim.dat+abs(min(sim.dat))+0.0001
	
	# simulate data without batch effects #
	sim.dat.nobatch <- B %*% S + U
	sim.dat.nobatch<-sim.dat.nobatch+abs(min(sim.dat))+0.0001
	
	# divide parts into database, new samples #
	db <- list()
	db$dat <- sim.dat[,ind=="db"]
	db$datnobatch <- sim.dat.nobatch[,ind=="db"]
	db$U <- U[,ind=="db"]
	db$B <- B
	db$S <- S[ind=="db"]
	db$Gam <- Gam
	db$G <- G[ind=="db"]
	
	# Run sva on the database (will be needed for both versions of fsva) #
	library(sva)
	db$mod<-model.matrix(~as.factor(db$S))
	db$sv<-sva(db$dat,db$mod)

	new <- list()
	new$dat <- sim.dat[,ind=="ns"]
	new$datnobatch <- sim.dat.nobatch[,ind=="ns"]
	new$U <- U[,ind=="ns"]
	new$B <- B
	new$S <- S[ind=="ns"]
	new$Gam <- Gam
	new$G <- G[ind=="ns"]
	
	vars<-list(n.e=n.e, n.db=n.db, n.ns=n.ns,
			   sv.db=sv.db, sv.ns=sv.ns,
			   sd.b=sd.b, sd.gam=sd.gam, sd.u=sd.u,
			   conf=conf, distr.db=distr.db,
			   p.b=p.b, p.gam=p.gam, p.ov=p.ov
			   )
	
	return(list(db=db,new=new,vars=vars))
}

