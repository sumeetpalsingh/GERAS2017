prediction_accuracy <- function(X_pred, Y_pred, parameter){
  model.predictions <- model_prediction(X_pred, parameter)
  accuracy.predictions = sum(model.predictions == Y_pred)/length(model.predictions)
  return(accuracy.predictions)
}