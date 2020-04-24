library(shiny)

shinyUI(fluidPage(
    titlePanel("Effect of Vitamin C on Tooth Growth in Guinea Pigs"),
    navbarPage("",
               tabPanel("Documentation",
                        mainPanel(
                            h3("Data description"),
                            p("Data used in the app are taken from ToothGrowth dataset in R dataset package. Data frame collect outcomes from an experiment in which response is the length of odontoblasts (cells responsible for tooth growth) in 60 guinea pigs. Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods: orange juice or ascorbic acid (a form of vitamin C and coded as VC). It contains 60 observations and 3 variables:"),
                            p("- len	(tooth length),"),
                            p("- supp (supplement type: VC or OJ),"),
                            p("- dose	(dose in milligrams/day)."),
                            h3("App description"),
                            p("The app fit two different models."),
                            p("- ", strong("Model 1 "), ": linear regression model with len as response and dose as regressor (", code("len ~ dose"), ")."),
                            p("- ", strong("Model 2 "), ": linear regression model with len as response and both dose and supp as regressors (", code("len ~ dose + supp"), ")."),
                            p("Guinea pigs tooth length is predicted using both models with inputs that you specify."),
                            h3("App usage"),
                            p("You can visualize summaries of the models, a scatterplot and predicted tooth length for both models. App is organized in two panels:"),
                            p("- a", strong("sidebar panel"), "in which you can specify values for predictions and other options,"),
                            p("- a", strong("main panel"), "organized in tabs that display outputs."),
                            br(),
                            p("In sidebar panel you can specify:"),
                            p("- daily vitamin C dose and supplement type for predicting tooth length,"),
                            p("- lines to show in the scatterplot (dose, model 1 prediction and model 2 prediction)."),
                            br(),
                            p("Main panel tabs display:"),
                            p("- summary for fitted models (", strong("model summary tab"), "),"),
                            p("- data scatterplot with lines you decided to show (", strong("scatterplot tab"), "),"),
                            p("- tooth length predictions for model 1 and model 2 based on the values you selected (", strong("predictions tab"), ").")
                            
                        )
               ),
               tabPanel("App",
                        sidebarLayout(
                            sidebarPanel(
                                sliderInput("sliderDose", "Vitamin C dose in mg/day",
                                            min = 0.5, max = 2, step = 0.25, value = 0.5),
                                selectInput("selectSupp", "Supplement type",
                                            choices = c("Orange juice" = "OJ", "Ascorbic acid" = "VC"),
                                            selected = "OJ"),
                                checkboxInput("showDose", "Show/Hide selected dose", value = TRUE),
                                checkboxInput("showPred1", "Show/Hide model 1 prediction", value = FALSE),
                                checkboxInput("showPred2", "Show/Hide model 2 prediction", value = FALSE)
                            ),
                            mainPanel(
                                tabsetPanel(type = "tabs",
                                            tabPanel("Model summary",
                                                     br(),
                                                     h4("Model 1 summary:"),
                                                     verbatimTextOutput("summary1"),
                                                     br(),
                                                     h4("Model 2 summary:"),
                                                     verbatimTextOutput("summary2")
                                            ),
                                            tabPanel("Plot",
                                                     plotOutput("plot")
                                            ),
                                            tabPanel("Predictions",
                                                     br(),
                                                     h4(textOutput("pred1")),
                                                     br(),
                                                     h4(textOutput("pred2"))
                                            )
                                            
                                )
                            )
                        )
               )
    )
    
))
