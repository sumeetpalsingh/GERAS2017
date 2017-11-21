header <- dashboardHeader(
  title = "GERAS"
)

sidebar <- dashboardSidebar(
  sidebarMenu(id = "sidebarmenu",
              menuItem("Upload GERAS Model", tabName="Model", icon = icon('camera-retro')),
              menuItem("File", tabName="File", icon=icon('file-text-o')),
              menuItem("Classification", tabName="Classification", icon = icon('camera')),
              menuItem("Save Results", tabName="Save", icon = icon('save'))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem("Model",
            fluidRow(
              box(width=12, title="Start GERAS!", solidHeader = TRUE,
                  fileInput('model1', 'Choose GERAS Model File (.rds)',accept=c('.rds'))
              ),
              box(width=12, title="GERAS Model Build", solidHeader = TRUE,
                  verbatimTextOutput("ModelParameters")
              ),
              box(width=12, title="GERAS Model Stages", solidHeader = TRUE,
                  tableOutput("ModelParameters1")
              )
            )
    ),
    tabItem("File",
            fluidRow(
              column( width=5,
                      box(width = NULL, title="Upload Data for Analysis",
                                 fileInput('file1', 'Choose text File',
                                           accept=c('text/csv',
                                                    'text/comma-separated-values',
                                                    'text/tab-separated-values',
                                                    'text/plain',
                                                    '.csv',
                                                    '.tsv',
                                                    '.out')),
                                 tags$hr(),
                                 checkboxInput('header', 'Header', TRUE),
                                 radioButtons('sep', 'Separator',
                                              c(Comma=',',
                                                Semicolon=';',
                                                Tab='\t'),
                                              selected=',')
                      )
              ),
              column(width = 7,
                     box(width = NULL, title="Preview Raw Data", status = "warning",
                         tableOutput('tpmcounts'),
                         tags$hr(),
                         p(
                           class = "text-muted",
                           paste("Note: You can preview the loaded data, ",
                                 "make sure the format is what you want to then proceed."
                           )
                         )
                     ),
                     infoBoxOutput("sampleBox"),
                     infoBoxOutput("featureBox")
              )
            )
    ),
    tabItem("Classification",
            fluidRow(
                    column(width=4,
                          box(title="Classification Results for 15 Samples", width = NULL, solidHeader = TRUE,
                              tableOutput('gerasClassification')
                            )
                          ),
                    column(width=4,
                                 box(title="Classification Results for All Samples", width = NULL, solidHeader = TRUE,
                                     tableOutput('gerasClassificationAll')
                                 # ),
                                 # box(width=NULL, plotOutput('ClassificationPlot')
                        
                                )
                          )
                    )
            ),
    tabItem("Save",
            fluidRow(
              column(width=5,
                     box(title="Download Classification Data", width = NULL, solidHeader = TRUE,
                     downloadButton('downloadData', 'Download')
              # ),
              # column(width=4,
              #        textOutput('saveFile')
                     )
              )
            )
    )
    )
)


dashboardPage(
  header,
  sidebar,
  body
)