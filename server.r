library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  data <- reactive({
    array(rexp(input$n*input$N,input$lambda),c(input$N,input$n))
  })
  
  res <- reactive({
    as.data.frame(cbind(Stdz=sqrt(input$n)*(apply(data(),1,mean)-1/input$lambda)/(1/input$lambda),
                        Size=rep(input$n,input$N)))
  })

  output$plot <- renderPlot({    
    p <- ggplot(res(),aes(Stdz,fill=Size))+geom_density()+ylab("Density")+
      stat_function(fun = dnorm, colour = "red")+xlab("Standardised mean")+xlim(c(-4,4))
    print(p)
  })  
  output$text <- renderText({
    paste("Figure 1: Density of the standardised mean converging to the
standard normal distribution according to the central limit theorem.")
  })
  res1 <- reactive({
    as.data.frame(cbind(Mean=apply(data(),1,mean),
                        Variance=apply(data(),1,var)/input$n,Size=rep(input$n,input$N)),
                  Stdz=sqrt(input$n)*(apply(data(),1,mean)-1/input$lambda)/(1/input$lambda))
  })
  
  output$plot1 <- renderPlot({    
    s <- ggplot(res1(),aes(Mean,fill=Size))+geom_histogram(col="red")+ylab("Frequency")+xlab("Mean")
    print(s)
  })  
  output$text1 <- renderText({
    paste("Figure 2: Distribution of the mean.")
  })
})