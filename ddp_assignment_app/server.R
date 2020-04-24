library(shiny)

shinyServer(function(input, output) {
    
    data("ToothGrowth")
    
    lm1 <- lm(len ~ dose, data = ToothGrowth)
    
    lm2 <- lm(len ~ dose + supp, data = ToothGrowth)
    
    lm1pred <- reactive({
        doseInput <- input$sliderDose
        predict(lm1, newdata = data.frame(dose = doseInput))
    })
    
    lm2pred <- reactive({
        doseInput <- input$sliderDose
        suppInput <- input$selectSupp
        predict(lm2, newdata = data.frame(dose = doseInput,
                                          supp = suppInput))
    })
    
    output$summary1 <- renderPrint({
        summary(lm1)
    })
    
    output$summary2 <- renderPrint({
        summary(lm2)
    })
    
    output$plot <- renderPlot({
        doseInput <- input$sliderDose
        
        plot(x = ToothGrowth$dose, y = ToothGrowth$len,
             col = c("darkgoldenrod3", "darkorchid4")[unclass(ToothGrowth$supp)],
             pch=16,
             xlab = "Vitamin C dose (mg/day)",  ylab = "Length")
        if(input$showDose){
            abline(v = doseInput, col = "coral", lwd = 1.5)
        }
        if(input$showPred1){
            abline(h = lm1pred(), col = "steelblue", lwd = 1.5)
        }
        if(input$showPred2){
            abline(h = lm2pred(), col = "aquamarine3", lwd = 1.5)
        }
        legend(0.47, 34,
               c("Orange juice", "Ascorbic acid"),
               pch = 16,
               col = c("darkgoldenrod3", "darkorchid4"))
    })
    
    output$pred1 <- renderText({
        paste("Model 1 prediction:", round(lm1pred(), 2))
    })
    
    output$pred2 <- renderText({
        paste("Model 2 prediction:", round(lm2pred(), 2))
    })
})
