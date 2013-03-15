## CHANGE TO YOUR WORKING DIRECTORY!! ##
workdir<-"/home/bst/student/hiparker/fSVA"

setwd(workdir)
library(ProjectTemplate)
load.project()
setwd("./graphs")

# plot full results for each simulation #
pdf(file="sim1detailed.pdf")
sim_fig_detailed(res1)
dev.off()

pdf(file="sim2detailed.pdf")
sim_fig(res2)
dev.off()

pdf(file="sim3detailed.pdf")
sim_fig(res3)
dev.off()

pdf(file="sim4detailed.pdf")
sim_fig(res4)
dev.off()

pdf(file="sim5detailed.pdf")
sim_fig(res5)
dev.off()


# create a good summary figure for each simulation #

pdf(file="sim1summarized.pdf")
sim_fig_summarized(res1)
dev.off()

pdf(file="sim2summarized.pdf")
sim_fig_summarized(res2,maintitle="Scenario 3")
dev.off()

pdf(file="sim3summarized.pdf")
sim_fig_summarized(res3)
dev.off()

pdf(file="sim4summarized.pdf")
sim_fig_summarized(res4,maintitle="Scenario 2")
dev.off()

pdf(file="sim5summarized.pdf")
sim_fig_summarized(res5,maintitle="Scenario 1")
dev.off()


## create panel figure for paper ##
## on a PC, so need to change working directories ##
workdir<-"C:/Users/Hilary/GitHub/fsva"

setwd(workdir)
library(ProjectTemplate)
load.project()
setwd("C:/Users/Hilary/GitHub/fsva/doc")

pdf(file="simfigpaper.pdf",height=21,width=9.43)
par(mfrow=c(3,1),mar=c(5.1,6,4.1,2.1))
sim_fig_paper(res5,maintitle="Scenario 1")
sim_fig_paper(res4,maintitle="Scenario 2")
sim_fig_paper(res2,maintitle="Scenario 3")
dev.off()
