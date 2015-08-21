library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Visualizing Relations Between Variables in the R States Dataset"),
  sidebarPanel(
    helpText("To calculate a correlation and see where each of the 50 US states lies along the correlation, please select two variables below."),
    selectInput("v1", "First Variable (x-axis):",
                list(
                  "Population (1975)" = "Population",
                  "Per Capita Income (1974)" = "Income",
                  "Percent Illiteracy (1970)" = "Illiteracy",
                  "Life Expectancy (1969-1971)" = "Life_Exp",
                  "Murder Rate per 100,000 People (1976)" = "Murder",
                  "High School Graduation Rate (1970)" = "HS_Grad",
                  "Number of Days Below Freezing" = "Frost",
                  "Land Area (Square Miles)" = "Area")
                ),
    selectInput("v2", "Second Variable (y-axis):",
                list(
                  "Population (1975)" = "Population",
                  "Per Capita Income (1974)" = "Income",
                  "Percent Illiteracy (1970)" = "Illiteracy",
                  "Life Expectancy (1969-1971)" = "Life_Exp",
                  "Murder Rate per 100,000 People (1976)" = "Murder",
                  "High School Graduation Rate (1970)" = "HS_Grad",
                  "Number of Days Below Freezing" = "Frost",
                  "Land Area (Square Miles)" = "Area")
                ),
    tags$head(tags$script(src = "message-handler.js")),
    actionButton("help", "For Help Click Me"),
    tags$head(tags$script(src = "message-handler.js")),
    actionButton("doc", "For Documentation Click Me")
    ),
  mainPanel(
    plotOutput("statePlot"),
    br(),
    br(),
    br(),
    textOutput("correlation")
    )
  ))


