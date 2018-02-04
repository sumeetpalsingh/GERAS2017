sparse2dataframe <- function(file = "file.rds"){
  require(Matrix)
  rds.file <- readRDS(file)
  rds.data <- as.data.frame(as.matrix(rds.file))
  return(rds.data)
}