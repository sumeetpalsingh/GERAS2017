model_prediction <- function(X_pred, parameter){
  X <- tf$placeholder(tf$float32, shape(nrow(X_pred), NULL), name = "X") 
  W1 = tf$constant(parameter$W1, dtype = tf$float32)
  b1 = tf$constant(parameter$b1, dtype = tf$float32)
  W2 = tf$constant(parameter$W2, dtype = tf$float32)
  b2 = tf$constant(parameter$b2, dtype = tf$float32)
  W3 = tf$constant(parameter$W3, dtype = tf$float32)
  b3 = tf$constant(parameter$b3, dtype = tf$float32)
  

  Z1 = tf$add(tf$matmul(W1, X), b1)                                              # Z1 = np.dot(W1, X) + b1
  A1 = tf$nn$relu(Z1)                                              # A1 = relu(Z1)
  Z2 = tf$add(tf$matmul(W2, A1), b2)                                              # Z2 = np.dot(W2, a1) + b2
  A2 = tf$nn$relu(Z2)                                              # A2 = relu(Z2)
  Z3 = tf$add(tf$matmul(W3, A2), b3)                                              # Z3 = np.dot(W3,Z2) + b3
  # parameters = tf$constant(value = param, dtype = tf$float32)
  prediction = tf$argmax(Z3, 0L)
  init = tf$global_variables_initializer()
  with(tf$Session() %as% sess, {
    sess$run(init)
    prediction.eval = sess$run(prediction, feed_dict=dict(X = X_pred))
  })
  # prediction.eval = prediction$eval(feed_dict=dict(X = X_pred, parameters = param))
  return(prediction.eval)
}