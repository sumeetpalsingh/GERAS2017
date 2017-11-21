# GERAS (GEnetic Reference for Age of Single-cell)
Machine Learning Framework for prediction of single-cell's chronological age

The folder contains Rmarkdown reports for generating GERAS for zebrafish beta-cells and human pancreatic cells. 

Data for generating and testing the model can be found at: https://sharing.crt-dresden.de/index.php/s/zcQ14AMGJAevokU

## Folders contained here are:
source: functions necessary to run GERAS, as well as extract information from developed model.

shiny_GERAS_Tf: files necessary to run the Shiny app. Must be in the same folder as Shiny_GERAS_Tf.R

## Files contained here are:
('Tf' in file names denoted 'Tensorflow', the API used to develop the machine learning framework).
GERAS_Tf_Zf.html: The report from Rmarkdown detailing the steps used for developing the human pancreatic GERAS.

GERAS_Tf_Zf_Final.rds: The GERAS model for human pancreatic cells.

GERAS_Tf_Hs.html: The report from Rmarkdown detailing the steps used for developing the human pancreatic GERAS.

GERAS_Tf_Hs_Final.rds: The GERAS model for human pancreatic cells.

shiny_GERAS_Tf.R: R file to run the Shiny app.
