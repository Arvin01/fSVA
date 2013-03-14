## CHANGE TO YOUR WORKING DIRECTORY!! ##
workdir<-"/home/bst/student/hiparker/fSVA"

setwd(workdir)
library(ProjectTemplate)
load.project()
setwd("./graphs")

createtab<-function(res,acc="GSE2603"){
	tmp1<-round(mean(res$none.out),2)
	tmp2<-round(mean(res$none.out)-1.96*sd(res$none.out)/sqrt(100),2)
	tmp3<-round(mean(res$none.out)+1.96*sd(res$none.out)/sqrt(100),2)
	
	tmp4<-round(mean(res$exact.out),2)
	tmp5<-round(mean(res$exact.out)-1.96*sd(res$exact.out)/sqrt(100),2)
	tmp6<-round(mean(res$exact.out)+1.96*sd(res$exact.out)/sqrt(100),2)
	
	diffen<-res$exact.out-res$none.out
	tmp7<-round(mean(diffen),2)
	tmp8<-round(mean(diffen)-1.96*sd(diffen)/sqrt(100),2)
	tmp9<-round(mean(diffen)+1.96*sd(diffen)/sqrt(100),2)
	
	tabrow<-c(acc,
			  paste("replace{",tmp1,"} (",tmp2,", ",tmp3,")",sep=""),
			  paste("replace{",tmp4,"} (",tmp5,", ",tmp6,")",sep=""),
			  paste("replace{",tmp7,"} (",tmp8,", ",tmp9,")",sep="")  
	)
	tabrow
}

### Second actually make the table ###
resmat <- matrix(nrow=9,ncol=4)
colnames(resmat) <- c("Study Name","No Correction (95/% CI)","Exact fSVA (95/% CI)","Improvement (95/% CI)")

resmat[1,]<-createtab(GSE10927_PAM,acc="GSE10927")
resmat[2,]<-createtab(GSE13041_PAM,acc="GSE13041")
resmat[3,]<-createtab(GSE13911_PAM,acc="GSE13911")
resmat[4,]<-createtab(GSE2034_PAM,acc="GSE2034")
resmat[5,]<-createtab(GSE2603_PAM,acc="GSE2603")
resmat[6,]<-createtab(GSE2990_PAM,acc="GSE2990")
resmat[7,]<-createtab(GSE4183_PAM,acc="GSE4183")
resmat[8,]<-createtab(GSE6764_PAM,acc="GSE6764")
resmat[9,]<-createtab(GSE7696_PAM,acc="GSE7696")


xtable(resmat)


######## END OF CODE ###########
######## FOLLOWING ARE RESULTS -- DO NO RUN #########


% latex table generated in R 2.15.2 by xtable 1.7-0 package
% Tue Mar  5 14:37:39 2013
\begin{table}[ht]
\begin{center}
\begin{tabular}{rllll}
  \hline
 & Study Name & No Correction (95/\% CI) & Exact fSVA (95/\% CI) & Improvement (95/\% CI) \\
  \hline
1 &  &  &  &  \\
  2 & GSE13041 & replace\{0.61\} (0.59, 0.63) & replace\{0.69\} (0.66, 0.71) & replace\{0.07\} (0.05, 0.1) \\
  3 & GSE13911 & replace\{0.93\} (0.93, 0.94) & replace\{0.94\} (0.94, 0.95) & replace\{0.01\} (0, 0.01) \\
  4 & GSE2034 & replace\{0.51\} (0.49, 0.52) & replace\{0.54\} (0.52, 0.56) & replace\{0.03\} (0.01, 0.05) \\
  5 & GSE2603 & replace\{0.68\} (0.66, 0.7) & replace\{0.66\} (0.64, 0.67) & replace\{-0.02\} (-0.04, 0) \\
  6 & GSE2990 & replace\{0.59\} (0.58, 0.61) & replace\{0.58\} (0.56, 0.6) & replace\{-0.02\} (-0.04, 0) \\
  7 & GSE4183 & replace\{0.89\} (0.88, 0.91) & replace\{0.88\} (0.86, 0.89) & replace\{-0.02\} (-0.03, 0) \\
  8 & GSE6764 & replace\{0.74\} (0.72, 0.76) & replace\{0.75\} (0.72, 0.77) & replace\{0.01\} (-0.01, 0.03) \\
  9 & GSE7696 & replace\{0.78\} (0.76, 0.79) & replace\{0.8\} (0.78, 0.81) & replace\{0.02\} (0.01, 0.04) \\
   \hline
\end{tabular}
\end{center}
\end{table}

# find : replace pairs written below
# /\ : \
# \} : }
# \{ : {
# replace : \textbf

% latex table generated in R 2.15.2 by xtable 1.7-0 package
% Tue Mar  5 14:37:39 2013
\begin{table}[ht]
\begin{center}
\begin{tabular}{rllll}
  \hline
 & Study Name & No Correction (95\% CI) & Exact fSVA (95\% CI) & Improvement (95\% CI) \\
  \hline
1 &  &  &  &  \\
  2 & GSE13041 & \textbf{0.61} (0.59, 0.63) & \textbf{0.69} (0.66, 0.71) & \textbf{0.07} (0.05, 0.1) \\
  3 & GSE13911 & \textbf{0.93} (0.93, 0.94) & \textbf{0.94} (0.94, 0.95) & \textbf{0.01} (0, 0.01) \\
  4 & GSE2034 & \textbf{0.51} (0.49, 0.52) & \textbf{0.54} (0.52, 0.56) & \textbf{0.03} (0.01, 0.05) \\
  5 & GSE2603 & \textbf{0.68} (0.66, 0.7) & \textbf{0.66} (0.64, 0.67) & \textbf{-0.02} (-0.04, 0) \\
  6 & GSE2990 & \textbf{0.59} (0.58, 0.61) & \textbf{0.58} (0.56, 0.6) & \textbf{-0.02} (-0.04, 0) \\
  7 & GSE4183 & \textbf{0.89} (0.88, 0.91) & \textbf{0.88} (0.86, 0.89) & \textbf{-0.02} (-0.03, 0) \\
  8 & GSE6764 & \textbf{0.74} (0.72, 0.76) & \textbf{0.75} (0.72, 0.77) & \textbf{0.01} (-0.01, 0.03) \\
  9 & GSE7696 & \textbf{0.78} (0.76, 0.79) & \textbf{0.8} (0.78, 0.81) & \textbf{0.02} (0.01, 0.04) \\
   \hline
\end{tabular}
\end{center}
\end{table}
