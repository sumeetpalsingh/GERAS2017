#This function assumes that there is at least one hidden layer.
variableImportance = function(modelTf) {
  numberOfWeights = c(dim(modelTf$weight$W1)[2], dim(modelTf$weight$W2)[2], dim(modelTf$weight$W2)[1])
  
  Qik = matrix(0, numberOfWeights[1], numberOfWeights[3])
  sumWj = array(0, numberOfWeights[2]);
  sumWk = array(0, numberOfWeights[3]);
  
  for(j in 1:numberOfWeights[2]){
    sumWj[j] = sum(abs(modelTf$weight$W1[,j]))
  }
  
  for(k in 1:numberOfWeights[3]){
    sumWk[k] = sum(abs(modelTf$weight$W2[k,]))
  }
  
  for(i in 1:numberOfWeights[1]) {
    for(k in 1:numberOfWeights[3]) {
      for(j in 1:numberOfWeights[2]) {
        wij = modelTf$weight$W1[i, j]
        wjk = modelTf$weight$W2[k, j]
        Qik[i, k] =  abs(wij) / sumWj[i] * abs(wjk) / sumWk[k]
      }
    }
  }
  for (k in 1:numberOfWeights[3]) {
    sumQk = sum(Qik[, k])
    
    #for (i in 1:numberOfWeights[1]) sumQk = sumQk + Qik[i, k];
    Qik[, k] = Qik[, k] / sumQk
    
    #for (i in 1:numberOfWeights[1]) Qik[i, k] = Qik[i, k]/sumQk
    
  }
  vi = array(0, numberOfWeights[1])
  # importance for feature i is the sum over k of i->k importances
  for (i in 1:numberOfWeights[1]) vi[i] = sum(Qik[i], na.rm=T);
  
  vi = vi / max(vi)
  
  return(vi)
}