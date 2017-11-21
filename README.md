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

## Data
Data for generating and testing the model can be found at: https://sharing.crt-dresden.de/index.php/s/zcQ14AMGJAevokU

The shared data contains two folders:
<ol type="1">
<li style="font-weight: bold;">Data: Containing the data to develop GERAS.</li>

Zf_AllStages_TPM.csv: TPM-normalized values from all stages of zebrafish beta-cells

Enge_RPM.csv: RPM-normalized values from human pancreatic cells published in <a href="https://www.biorxiv.org/content/early/2017/02/13/108043"> Enge et al., 2017 </a>

<li style="font-weight: bold;"> TestData: Data for testing the GERAS models</li>

Zebrafish Test Data:
<br>1.5 mpf beta-cells
<br>4 mpf beta-cells
<br>3 mpf beta-cells sequenced using C1-Chip Fludigm
<br>9 mpf beta-cells
<br>4 mpf beta-cells from animals on low-calorie diet
<br>4 mpf beta-cells from animals on high-calorie diet

Human Pancreatic Test Data:
<br>Data published in <a href="https://www.ncbi.nlm.nih.gov/pmc/articles/pmid/27667667/"> Segerstolpe et al., 2016 </a>  
</ol>
