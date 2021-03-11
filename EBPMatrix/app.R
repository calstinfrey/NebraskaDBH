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

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Prevention EBPs"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("strat", label = "Select strategy", choices = 
                    c("Problem ID/Referral/Education", 
                      "Education", 
                      "Environmental", 
                      "Alternative Activity", 
                      "Problem ID/Referral", 
                      "Community-Based Process", 
                      "Education/Community-Based Process", 
                      "Information Dissemination", 
                      "Education/Environmental"), selected = "Education"),
      
      checkboxGroupInput("issue", label = "Primary Problem(s)", choices = 
                           c("Alcohol", 
                             "Alcohol, Marijuana", 
                             "Alcohol, Prescription Drug Abuse", 
                             "Alcohol, Tobacco", 
                             "Alcohol, Presciption Drug Abuse, Marijuana, Methamphetamine", "Tobacco",
                             "Prescription Drug Abuse",                                                         
                             "Alcohol, Tobacco, Prescription Drug Abuse, Marijuana, Synthetic  Use, Inhalent Use",
                             "Alcohol, Tobacco, Marijuana",                                                      
                             "Alcohol, Presciption Drug Abuse, Cocaine , Heroin" ), selected = "Alcohol")
      
      
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
    tbl2<- EBPMatrix2 %>%
      filter(Strategy == input$strat) %>%
      select(PFS.EBPPP.Listing, Description , Efficacy, Link) 
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)


