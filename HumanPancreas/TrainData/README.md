File provided for trainig of Human Pancreatic GERAS.

File is provided as sparse matrix to save space. Additionally, the file is truncated to contain information on only the top 1000 most variable genes.

Please convert from sparse matrix to data.frame using the following command:

train.data <- sparse2dataframe(file = "Enge_pRPM.rds"),

where sparse2dataframe() is a function deposited in 'sourse' folder, 
Enge_pRPM.rds is the file storing the sparse matrix.
