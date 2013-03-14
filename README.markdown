# Reproducing this project:

I hope this document guides you through the code for this project. I organized the code using [ProjectTemplate](http://projecttemplate.net/), an R package that provides a systematic template for organizing code. ProjectTemplate also allows for easy loading of the project.

In order to load the entire project (data, results and required packages), simply clone the project, open R in the `fSVA` directory, and run the following commands.

    library("ProjectTemplate")
    load.project()
    
The total loaded workspace is 0.2 GB.

## Simulations:

I ran five simulations for this project, three of which are reported in the paper. The simulations can be found in each of these files in the `src` directory.

To run each simulation, run the following code. I recommend running these in parallel, as each one takes about 1-2 days to run on a standard desktop computer. I have noted in comments the amount of time each took for me, running on a standard desktop computer.

    source('sim1.R') # 45.4 hours
    source('sim2.R') # 54.2 hours
    source('sim3.R') # 53.4 hours
    source('sim4.R') # 47.6 hours
    source('sim5.R') # 44.7 hours

If you are able to run things on a unix cluster, the shell scripts are already created and located within the `src` directory. Additionally, the file `qsubs.txt` contains all of the unix commands for running the project (including the simulations).

Once you have run the simulations, the code for producing the graphs in the paper can be found in the `graphs` directory (as well as .pdfs of the graphs themselves). You can run it by the following command:

    source('sim_plots.R')

## Data Examples:

I have included in the `data` directory the curated data files that contain the raw data and various annotation data you will need. I originally obtained the datasets from collaborators, as described in the paper.

I ran analyses of nine different studies for this project. The code for running this analysis can again be found in the `src` directory. Again I recommend running these in parallel, and have noted the amount of time on a standard desktop computer.

    source('GSE10927_PAM.R') # 2.4 hours
    source('GSE13041_PAM.R') # 1.2 hours
    source('GSE13911_PAM.R') # 3.5 hours
    source('GSE2034_PAM.R') # 1.2 hours
    source('GSE2603_PAM.R') # 0.6 hours
    source('GSE2990_PAM.R') # 1.0 hours
    source('GSE4183_PAM.R') # 1.6 hours
    source('GSE6764_PAM.R') # 1.1 hours
    source('GSE7696_PAM.R') # 4.4 hours

Again, if you are able to run things on a unix cluster, the shell scripts are already created and located within the `src` directory. Additionally, the file `qsubs.txt` contains all of the unix commands for running the project.