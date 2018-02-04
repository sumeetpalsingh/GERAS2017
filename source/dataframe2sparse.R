dataframe2sparse <- function(object, save.file = "data_sparese.rds"){
  require(Matrix)
  data.sparse <- Matrix(as.matrix(object), sparse = T)
  saveRDS(data.sparse, save.file)
}