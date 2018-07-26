library(shiny)
shinyServer(
  function(input, output) {


    datasetInput <- eventReactive(input$update, {
      switch(input$dataset,
             "iris" = iris,
             "attitude" = attitude)
    }, ignoreNULL = FALSE)

    # Generate a summary of the dataset ----
    output$summary <- renderPrint({
      dataset <- datasetInput()
      summary(dataset)
    })

    # Show the first "n" observations ----

    output$view <- renderTable({
      head(datasetInput(), n = isolate(input$obs))
    })

    #selectt the data for the first codition
    selectedData <- reactive({
      iris[,c(input$xcol,input$ycol)]
    })

    clusters <- reactive({
      kmeans(selectedData(), input$clusters)
    })

    output$plot1 <- renderPlot({
      plot(iris[,c(input$xcol,input$ycol)],
           col=clusters()$cluster,
           pch=20,cex=3)
      points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })

    #Select the data for the second condition
    output$plot2 <- renderPlot({
      plot(attitude[,c(input$xcol2,input$ycol2)],
           col=clusters()$cluster,
           pch=20,cex=3)
      points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    })



  }

)
