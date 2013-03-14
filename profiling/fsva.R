# Profiling fast and exact fSVA #

setwd("/home/bst/student/hiparker/fSVA")
library("ProjectTemplate")
load.project()

simdat <- sim_dat(n.e=10000, n.db=100, n.ns=100,
						sv.db=c("A","B"), sv.ns=c("A","B"),
						sd.b=1, sd.gam=4, sd.u=3,
						conf=TRUE, distr.db=p.conf[z],
						p.b=0.5, p.gam=0.5, p.ov=0.4)

						

### Housekeeping ###
db<-simdat$db
new<-simdat$new

system.time(fsva(dbdat=db$dat, mod=db$mod, sv=db$sv, newdat=new$dat, method="exact"))
#   user  system elapsed
#133.591   0.303 133.910

system.time(fsva(dbdat=db$dat, mod=db$mod, sv=db$sv, newdat=new$dat, method="fast"))
#   user  system elapsed
#   1.27    0.00    1.27




simdat <- sim_dat(n.e=10000, n.db=50, n.ns=50,
						sv.db=c("A","B"), sv.ns=c("A","B"),
						sd.b=1, sd.gam=4, sd.u=3,
						conf=TRUE, distr.db=p.conf[z],
						p.b=0.5, p.gam=0.5, p.ov=0.4)

						

### Housekeeping ###
db<-simdat$db
new<-simdat$new

system.time(fsva(dbdat=db$dat, mod=db$mod, sv=db$sv, newdat=new$dat, method="exact"))
#   user  system elapsed
# 17.634   0.224  17.860
system.time(fsva(dbdat=db$dat, mod=db$mod, sv=db$sv, newdat=new$dat, method="fast"))

> system.time(fsva(dbdat=db$dat, mod=db$mod, sv=db$sv, newdat=new$dat, method="fast"))
#   user  system elapsed
#  0.359   0.000   0.359
