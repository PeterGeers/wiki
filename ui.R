# Show a tabset that includes a plot, summary, and
# table view of the generated distribution

fluidPage(
    # Application title
    titlePanel("Tags Word Cloud"),
    
    p("This page shows a word cloud from tags used in my wiki"),
    
    sidebarLayout(
        # Sidebar with a slider and selection inputs
        sidebarPanel(
            selectInput("selection", "Choose a tag:", choices = myTags),
                actionButton("update", "Change"),
                hr(),
            sliderInput("freq",
                        "Minimum Frequency:",
                        min = 1,  max = 10, value = 1),
            sliderInput("max",
                        "Maximum Number of Words:",
                        min = 1,  max = 300,  value = 100)
        ),
        
   # Show Word Cloud
        mainPanel(
            tabsetPanel(
                tabPanel("Plot", plotOutput("plot")),
                tabPanel("Summary", includeHTML("./summary.html"), verbatimTextOutput("summary")),
                
                tabPanel("Table", fluidRow(column(2, dataTableOutput('table'))))
    )
)
)
)


