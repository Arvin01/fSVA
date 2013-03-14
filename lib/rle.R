## out of sample relative log expression ##
## no longer included in paper, but code available ##

osrle <- function(dat,newsamp=NULL){

	dat<-log(dat)
	tmp<-apply(dat, MARGIN=1, FUN=median, na.rm=TRUE)

	if(is.null(newsamp)){
		rle.mat<-dat-tmp
		res<-list(rle=rle.mat)
	}

	else{
		newsamp<-log(newsamp)
		rle.mat.new<-newsamp-tmp
		rle.mat.db<-dat-tmp
		
		sd.dat<-apply(rle.mat.db, MARGIN=2, FUN=sd, na.rm=FALSE)
		sd.new<-apply(rle.mat.new, MARGIN=2, FUN=sd, na.rm=FALSE)

		len<-length(sd.new)
		qual<-rep(NA,len)
		for(i in 1:len){
			qual[i]<-mean(sd.new[i]<sd.dat)
		}
		
		res<-list(rle=rle.mat.new,qc=qual)
	}
	return(res)
}