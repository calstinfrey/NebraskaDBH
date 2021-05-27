#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(mosaic)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("yeti"),
  
  # Application title
  titlePanel("Prevention EBPs"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("strat", label = "Select strategy", choices = 
                    c("Education", 
                      "Environmental", 
                      "Alternative Activity", 
                      "Problem ID/Referral", 
                      "Community-Based Process", 
                      "Information Dissemination"), selected = "Education"),
      
      radioButtons("issue", label = "Primary Problem", choices = 
                           c("Alcohol", 
                             "Marijuana", 
                             "Prescription Drug Abuse", 
                             "Tobacco", 
                             "Methamphetamine",
                             "Synthetic  Use", 
                             "Inhalent Use",
                             "Cocaine" ,
                             "Heroin",
                             "Suicide Prvention",
                             "Violence/Bullying"), selected = "Alcohol")
      
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("name"),
      tableOutput("tbl")
    ) 
  )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  output$tbl <- renderTable({
    tbl2<- FilteredEBP3 %>%
      filter(Strategy1 == input$strat | Strategy2 == input$strat) %>%
      filter(grepl(input$issue, `Primary Problem`)) %>%
      select(`PFS EBPPP Listing`, `Problems Addressed`, `Description (2-3 Sentences)`, Link ) 
  })

  
}

# Run the application 
shinyApp(ui = ui, server = server)


