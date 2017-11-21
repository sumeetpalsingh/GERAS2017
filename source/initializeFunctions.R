## Helps initialize the weight variable
weight_variable <- function(shape) {
  initial <- tf$truncated_normal(shape, stddev=0.1)
  tf$Variable(initial)
}

## Helps initialize the bias variables
bias_variable <- function(shape) {
  initial <- tf$constant(0.1, shape=shape)
  tf$Variable(initial)
}


one_hot_matrix <- function(labels, C){
  #   """
  # Creates a matrix where the i-th row corresponds to the ith class number and the jth column
  # corresponds to the jth training example. So if example j had a label i. Then entry (i,j) 
  # will be 1. 
  # 
  # Arguments:
  # labels -- vector containing the labels 
  # C -- number of classes, the depth of the one hot dimension
  # 
  # Returns: 
  # one_hot -- one hot matrix
  # """
  
  
  # Create a tf.constant equal to C (depth), name it 'C'. 
  C = tf$constant(value = as.integer(C), name = "C" )
  labels = tf$constant(value = as.integer(labels), name = "labels")
  
  # Use tf.one_hot, be careful with the axis 
  one_hot_matrix = tf$one_hot(indices = labels, depth = C, axis = 0) 
  
  # Create the session 
  with(tf$Session() %as% sess, {
    # return(sess$run(one_hot_matrix))
    one_hot = sess$run(one_hot_matrix)
  })
  
  return(one_hot)
}