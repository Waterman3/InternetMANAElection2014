
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)
shinyUI(fluidPage(

  # Application title
  titlePanel("Internet MANA Party Vote vs Turnout"),

  # Sidebar showing intercept and slope of model
  sidebarLayout(
    sidebarPanel(
       h3("The intercept of this model is"),
       textOutput("Intercept"),
       h3("The slope is"),
       textOutput("Slope"),
       h3("The residual standard error is"),
       textOutput("Sigma")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      "This application to investigate the relationship between 
       the Internet MANA party vote and the percentage of registered
       voters who voted (turnout) in each electorate in the 2014 
      New Zealand General Election.
      
      You can select a group of points and see what sort of relationship
      there may be.
      
      Please left-click and move the cursor over the points
                  that you want to include in your model, keeping your
                  finger on the left-click button.",
      plotOutput("turnoutPlot", brush=brushOpts(id="electorate_brush"))
    )
  )
))
