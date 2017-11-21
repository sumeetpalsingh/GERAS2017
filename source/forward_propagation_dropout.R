forward_propagation_dropout <- function(X, parameters, dropout.constant = 0.5){
#   """
# Implements the forward propagation for the model: LINEAR -> RELU -> LINEAR -> RELU -> LINEAR -> SOFTMAX
# 
# Arguments:
# X -- input dataset placeholder, of shape (input size, number of examples)
# parameters -- list containing your parameters "W1", "b1", "W2", "b2", "W3", "b3"
# dropout.constant -- the probability of retaining an activation function
# 
# Returns:
# Z3 -- the output of the last LINEAR unit
# """
    
    # Retrieve the parameters from the list "parameters" 
    W1 = parameters$W1
    b1 = parameters$b1
    W2 = parameters$W2
    b2 = parameters$b2
    W3 = parameters$W3
    b3 = parameters$b3
    
    
    Z1 = tf$add(tf$matmul(W1, X), b1)                                              # Z1 = np.dot(W1, X) + b1
    A1 = tf$nn$relu(Z1)  # A1 = relu(Z1)
    A1_dropout = tf$nn$dropout(A1, dropout.constant)
    Z2 = tf$add(tf$matmul(W2, A1_dropout), b2)                                              # Z2 = np.dot(W2, a1) + b2
    A2 = tf$nn$relu(Z2)                                              # A2 = relu(Z2)
    A2_dropout = tf$nn$dropout(A2, dropout.constant)
    Z3 = tf$add(tf$matmul(W3, A2_dropout), b3)                                              # Z3 = np.dot(W3,Z2) + b3
  
    
    return(Z3)
}