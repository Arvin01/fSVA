# Code to create figure for paper with three summarized results:
# Code creates one panel, then go through for all three

sim_fig_paper<-function(object,maintitle=""){
	
	len1<-dim(object[[1]])[1] #100
	len2<-length(object) #10

	# create x axis
	x<-rep(NA,len2)
	for(i in 1:len2){
		x[i]<-object[[i]][1,6]
	}

	plot(x,seq(0.1,1,by=.1),pch=".",col="white",xlab="Correlation ",
		ylab="Prediction Accuracy",,main=maintitle,ylim=c(0.3,1),
		cex.lab=2.5, cex.axis=2, cex.main=3.5, cex.sub=2.5)
	 
	 
	cols1 <- brewer.pal(3, "Greys")
	#cols2 <- brewer.pal(2, "Blues")
	cols3 <- brewer.pal(3, "Oranges")
	cols4 <- brewer.pal(3, "RdPu")
	cols5 <- brewer.pal(3, "Blues")

	# housekeeping
	y1<-rep(NA,len2)
	y2<-rep(NA,len2)
	y3<-rep(NA,len2)
	y4<-rep(NA,len2)
	y5<-rep(NA,len2)


	# create a graph for each iteration (len1) for each of the "timepoints" (len2)	
	for(i in 1:len1){
		for(j in 1:len2){
	
			# create each of the outcomes for this iteration
			y1[j]<-object[[j]][i,1]
			y2[j]<-object[[j]][i,2]
			y3[j]<-object[[j]][i,3]
			y4[j]<-object[[j]][i,4]
			y5[j]<-object[[j]][i,5]
		
		}
	
		
		# plot everything
		lines(x=x,y=y1,col=cols1[1],lwd=3)
		#lines(x=x,y=y2,col=2,lwd=3)
		lines(x=x,y=y3,col=cols3[1],lwd=3)
		lines(x=x,y=y4,col=cols4[1],lwd=3)
		lines(x=x,y=y5,col=cols5[1],lwd=3)
	
		
	}

	# add mean lines #
	means<-matrix(nrow=10,ncol=6)
	for(j in 1:len2){
		means[j,]<-colMeans(object[[j]])
	}
			 
	# plot everything
	lines(x=x,y=means[,1],col=cols1[2],lwd=3)
	#lines(x=x,y=y2,col=2,lwd=3)
	lines(x=x,y=means[,3],col=cols3[2],lwd=3)
	lines(x=x,y=means[,4],col=cols4[2],lwd=3)
	lines(x=x,y=means[,5],col=cols5[2],lwd=3)


	# create legend
	legend("bottomleft",c("No Correction",
						# "No Batch Effects",
						"SVA only Correction",
						"exact fSVA Correction",
						"fast fSVA Correction"
						),
		cex=2.5,
		lwd=3,col=c(cols1[2],
					#2,
					cols3[2],
					cols4[2],
					cols5[2]))
}