library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar( 
  headerPanel("Simulation of exponential distribution"),
  sidebarPanel(
    numericInput('n', 'n (Sample Size):',value=2),
    sliderInput('N', 'N (Number of Simulations):',min=20, max=2000,
                value=20, step=20, round=0),
    numericInput("lambda", "Lambda:",0.1),   
    p(em("Documentation:",a("Shiny_App_Coursera",href="index.html"))),
    submitButton('Submit', icon("refresh"))
  ),
  
  mainPanel(
    plotOutput('plot'),
    verbatimTextOutput("text"),
    plotOutput('plot1'),
    verbatimTextOutput("text1")
  )
))  