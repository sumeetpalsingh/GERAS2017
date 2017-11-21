options(shiny.maxRequestSize=500*1024^2)

shinyServer(function(input, output, session) {

  #' Model Info box
  modelTf <- reactive({
    inFile <- input$model1
    if(is.null(inFile))
      return(NULL)
    modelTf = readRDS(inFile$datapath)
    return(modelTf)
  })
  output$ModelParameters <- renderText({
    modelTf = modelTf()
    if(is.null(modelTf))
      return(NULL)
    parameters.name = modelTf$parameters.name
    myTimePoints = modelTf$myTimePoints
    myTimePeriod = modelTf$myTimePeriod
    Age.labels = modelTf$Age.labels
    # myLevels = NN_ageModel$age_levels
    return(paste(paste("The Uploaded GERAS Model uses",length(parameters.name),"genes."), 
                 paste("Data to generate the model was based on cells captured from", min(as.numeric(myTimePoints)),myTimePeriod,"to",max(as.numeric(myTimePoints)),myTimePeriod,"."),
                 paste("The model was built to classify the above chronological ages into", length(unique(Age.labels)), "stages."),
        sep = "\n"))
    # return(paste("The Uploaded GERAS uses",length(parameters.name),"genes"))
  })
  
  output$ModelParameters1 <- renderTable(rownames = T, {
    modelTf = modelTf()
    if(is.null(modelTf))
      return(NULL)
    parameters.name = modelTf$parameters.name
    myTimePoints = modelTf$myTimePoints
    myTimePeriod = modelTf$myTimePeriod
    Age.labels = modelTf$Age.labels
    model.stages <- data.frame(Stages = Age.labels, row.names = paste(myTimePoints, myTimePeriod))
    return(model.stages)
  })
  #' Tpm File Info box
  tpm_counts <- reactive({
    inFile <- input$file1
    if(is.null(inFile))
      return(NULL)
    read.table(inFile$datapath, header = input$header, row.names = 1, check.names = F, sep=input$sep)
  })
  
  output$tpmcounts <- renderTable(rownames = T, {
    tpm_counts = tpm_counts()
    return(head(tpm_counts[,1:5], 15))
  })
  output$sampleBox <- renderInfoBox({
    tpm_counts = tpm_counts()
    valueBox(ncol(tpm_counts), subtitle = "SAMPLE", color = "blue", width = NULL
    )
  })
  output$featureBox <- renderInfoBox({
    tpm_counts = tpm_counts()
    valueBox(nrow(tpm_counts), subtitle = "FEATURE", color = "yellow", width = NULL
    )
  })
  
  ## Classification
  classification_predictions <- reactive({
    modelTf = modelTf()
    tpm_counts = tpm_counts()
    parameters.weights = modelTf$weight
    parameters.name = modelTf$parameters.name
    
    tpm_counts.selected <- tpm_counts[parameters.name,] + 1
    
    tpm_counts.log = apply(tpm_counts.selected, 2, function(x) log(x, 2))
    # tpm_counts.final <- t(tpm_counts.log)
    
    stages.tpm <- model_prediction(tpm_counts.log, parameters.weights)
    
    return(stages.tpm)
  })
  
  output$gerasClassification <- renderTable(rownames = T, {
    modelTf = modelTf()
    tpm_counts = tpm_counts()
    Age.labels = modelTf$Age.labels
    Stage.labels = unique(Age.labels)
    ## Add 1 to the classification predictions since the predictions are from 0 onwards, but subsetting a vector is from 1 onwards
    stages.tpm = classification_predictions()+1
    ## Adding 1 helps subsetting like Stage.labels[stages.tpm]
    stages.tpm.all <- data.frame(Stage = Stage.labels[stages.tpm], row.names = colnames(tpm_counts))
    
    return(head(stages.tpm.all, 15))
  })
  output$gerasClassificationAll <- renderTable(rownames = T, {
    modelTf = modelTf()
    Age.labels = modelTf$Age.labels
    Stage.labels = unique(Age.labels)
    stages.tpm = classification_predictions()+1
    tpm.stages.freq = as.numeric(table(factor(stages.tpm, levels = 1:length(Stage.labels))))
    tpm.table <- data.frame(Frequency = tpm.stages.freq, Percentage = tpm.stages.freq*100/sum(tpm.stages.freq), row.names = Stage.labels)
    return(tpm.table)
  })

  
  # Save Results
  output$downloadData <- downloadHandler(
    filename = function() { paste0(gsub("\\..*","",input$file1),'_geras', '.csv') },
    content = function(file) {
      modelTf = modelTf()
      tpm_counts = tpm_counts()
      Age.labels = modelTf$Age.labels
      Stage.labels = unique(Age.labels)
      stages.tpm = classification_predictions()+1
      
      stages.tpm.all <- data.frame(Stage = Stage.labels[stages.tpm], row.names = colnames(tpm_counts))
        write.csv(stages.tpm.all, file)
    }
  )
  output$saveFile <- renderText({
    paste(input$dataset, '.csv', sep = '')
  })
})