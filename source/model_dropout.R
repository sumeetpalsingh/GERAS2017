model_dropout <- function(X_train, Y_train, num.first.hlayer = 1000, 
                          num.second.hlayer = num.first.hlayer/2, 
                          num_epochs = 200, 
                          learning_rate = 0.0001, 
                          dropout.constant = 0.5, regulatization.constant = 1.5, 
                          print_cost = TRUE){  
  tf$reset_default_graph()
  tf$set_random_seed(1)
  # seed = 3
  n_x = nrow(X_train) ## Number of parameters
  m = ncol(X_train) ## Number of training examples
  ## Generate one-hot conversion of Y-train factor variable
  Y_train.levels = factor(Y_train)
  n_y = nlevels(Y_train.levels) ## Number of categories
  Y_train.oneHot = one_hot_matrix(as.numeric(levels(Y_train.levels))[Y_train.levels], n_y)
  
  ## To store the costs during each iteration
  costs = rep(NA, num_epochs)
  
  ## Creates the placeholders for the tensorflow session.
  ## First the input and output. The second dimension is left as NULL since that will correspond to number of examples
  X <- tf$placeholder(tf$float32, shape(n_x, NULL), name = "X")
  Y <- tf$placeholder(tf$float32, shape(n_y, NULL), name = "Y")
  ## The weights
  W1 = weight_variable(shape(num.first.hlayer, n_x)) 
  b1 = bias_variable(shape(num.first.hlayer, 1L))
  W2 = weight_variable(shape(num.second.hlayer, num.first.hlayer))
  b2 = bias_variable(shape(num.second.hlayer, 1L))
  W3 = weight_variable(shape(n_y, num.second.hlayer))
  b3 = bias_variable(shape(n_y, 1L))
  
  # parameters = initialize_parameters()
  parameters = list(W1 = W1, b1 = b1, W2 = W2, b2 = b2, W3 = W3, b3 = b3)
  ## The output of the last linear unit via dropout
  Z3_dropout = forward_propagation_dropout(X, parameters, dropout.constant)
  ## The cost and optimization over cost
  cost = compute_cost(Z3_dropout, Y, parameters, regulatization.constant)
  optimizer = tf$train$AdamOptimizer(learning_rate = learning_rate)$minimize(cost)
  
  ## The output of the last linear unit WITHOUT dropout Required for final predictions
  Z3 = forward_propagation(X, parameters)
  
  
  
  init = tf$global_variables_initializer()
  
  with(tf$Session() %as% sess, {
    sess$run(init)
    for(epoch in 1:num_epochs){
      cost.run = sess$run(c(optimizer, cost), feed_dict=dict(X = X_train, Y = Y_train.oneHot))
      # epoch_cost = epoch_cost + cost.run[[2]]
      costs[epoch] = cost.run[[2]]
      # print(cost.run[[2]])
    }
    parameters = sess$run(parameters)
    
    # accuracy = tf$reduce_mean(tf$cast(correct_prediction, "float"))
    # print(accuracy)
    correct_prediction = tf$equal(tf$argmax(Z3, 0L), tf$argmax(Y, 0L))
    accuracy <- tf$reduce_mean(tf$cast(correct_prediction, tf$float32))
    # sess$run(accuracy, feed_dict=dict(X = X_train, Y = Y_train))
    if(print_cost){
    plot(costs)
    print(paste("Accuracy of training set:",accuracy$eval(feed_dict=dict(X = X_train, Y = Y_train.oneHot))))
    # print(correct_prediction$eval(feed_dict=dict(X = X_train, Y = Y_train)))
    }
  })
  
  return(parameters)

}