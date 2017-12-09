#' A Softmax Function
#'
#' This function generates the softmax output for the neural network.
#' @param normalized.counts Normalized counts of cells.
#' @param parameters The weights of the neural network.
#' @keywords GERAS
#' @export
#' @examples
#' ## An example using human pancreatic GERAS.
#' ## Model file: GERAS_Tf_Hs_Final.rds. 
#' ## Read counts: H1_pRPM.csv 
#' 
#' human_model <- readRDS(file = "GERAS_Tf_Hs_Final.rds")
#' H1 <- read.table(file = "H1_pRPM.csv", sep = ",", header = T, row.names = 1, check.names = F)
#' 
#' get_softmax(H1.log, human_model$weight)

get_softmax <- function(normalized.counts, parameters){
  counts.log = apply(normalized.counts, 2, function(x) log(x + 1, 2))
  model_softmax(name.log, GERAS_Hs$weight)
}