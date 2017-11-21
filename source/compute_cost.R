compute_cost <- function(Z3, Y, parameters, beta){
  # """
  #   Computes the cost
  #   
  #   Arguments:
  #   Z3 -- output of forward propagation (output of the last LINEAR unit), of shape (6, number of examples)
  #   Y -- "true" labels vector placeholder, same shape as Z3
  #   beta -- regularization constant
  #
  #   Returns:
  #   cost - Tensor of the cost function
  #   """
  
  # Retrieve the parameters from the list "parameters" 
  W1 = parameters$W1
  b1 = parameters$b1
  W2 = parameters$W2
  b2 = parameters$b2
  W3 = parameters$W3
  b3 = parameters$b3

  # to fit the tensorflow requirement for tf.nn.softmax_cross_entropy_with_logits(...,...)
  logits = tf$transpose(Z3)
  labels = tf$transpose(Y)
  
  beta = beta ## Regularization constant
  
  
  cost = tf$reduce_mean(tf$nn$softmax_cross_entropy_with_logits(logits = logits, labels = labels) + beta*tf$nn$l2_loss(W1) + beta*tf$nn$l2_loss(W2) + beta*tf$nn$l2_loss(W3))
  
  
  return(cost)
}