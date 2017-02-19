

function(input, output) {
    # Define a reactive expression for the document term matrix
    terms <- reactive({
        # Change when the "update" button is pressed...
        input$update
        # ...but not for anything else
        isolate({
            withProgress({
                setProgress(message = "Processing corpus...")
                getTermMatrix(input$selection)
            })
        })
    })
    
    # Make the wordcloud drawing predictable during a session
    output$plot <- renderPlot({
 
        set.seed(1234)
        
        wordcloud(words = terms()$word, freq = terms()$freq, min.freq = input$freq,
                  max.words=input$max, random.order=FALSE, rot.per=0.35, scale=c(6,0.5),
                  colors=brewer.pal(11, "Spectral"))
         })
    
    wiki <- reactive({
        # Change when the "update" button is pressed...
        input$update
        # ...but not for anything else
        isolate({
            withProgress({
                setProgress(message = "Processing corpus...")
                getWiki(input$selection)
            })
        })
    })
    
    output$table <- DT::renderDataTable(wiki(), 
                options = list(
                pageLength = 10,
                lengthChange = TRUE,
                autoWidth = TRUE,
                columnDefs = list(list(width = '200px', targets = c(0)))
                ), 
                rownames = FALSE,
                style = 'bootstrap',
                escape = FALSE)

}