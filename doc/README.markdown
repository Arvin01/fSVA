# Reproducing Paper

I have created a knitr version of this paper -- what this means is that you can reproduce the paper completely within the terminal or R.

## Steps for compiling the document:

First, go to the `config` directory and change these settings in the global.dcf file to the following (this will make the compilation as quickly as possible:
```bash
data_loading: off
cache_loading: on
munging: off
load_libraries: on
```
Next, run these lines (with your own working directories!) to make sure that the knitted version compiles correctly.

```
library(knitr)
opts_knit$set(
  root.dir="/Users/hparker/Desktop/fSVA",
  base.dir="/Users/hparker/Desktop/fSVA/doc"
)
knit("fsva.Rnw")
```
Running this code will create the file `fsva.tex`, which you can then compile using your latex editor.
