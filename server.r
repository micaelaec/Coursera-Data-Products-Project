library(shiny)
library(datasets)
library(ggplot2)

data(state)
state_data <<- as.data.frame(state.x77)
state_names <<- row.names(state_data)
state_data$State <<- factor(state_names)
names(state_data)[c(4,6)] <<- c("Life_Exp","HS_Grad")

shinyServer(function(input, output, session) { 
  variable1 <- reactive({
    paste(input$v1)
    })
  
  variable2 <- reactive({
    paste(input$v2)
    })
   
  v1_label <- reactive({
    if(as.character(variable1())=="Murder"){
    "Murder and Manslaughter Rate per 100,000 Population (1976)"
  } else if(as.character(variable1())=="Population"){
    "Population Estimate as of July 1, 1975"
  } else if(as.character(variable1())=="Income"){
    "Per Capita Income (1974)"
  } else if(as.character(variable1())=="Illiteracy"){
    "Illiteracy (Percent of Population in 1970)"
  } else if(as.character(variable1())=="Life_Exp"){
    "Life Expectancy in Years (1969-1971)"
  } else if(as.character(variable1())=="HS_Grad"){
    "Percent of High School Graduates (1970)"
  } else if(as.character(variable1())=="Frost"){
    "Mean # of Days with Minimum Temp Below Freezing (1931-1960)"
  } else if(as.character(variable1())=="Area"){
    "Land Area in Square Miles"
  } else{
    as.character(variable1())
  }
  })
  
  v2_label <- reactive({
    if(as.character(variable2())=="Murder"){
    "Murder and Manslaughter Rate per 100,000 Population (1976)"
  } else if(as.character(variable2())=="Population"){
    "Population Estimate as of July 1, 1975"
  } else if(as.character(variable2())=="Income"){
    "Per Capita Income (1974)"
  } else if(as.character(variable2())=="Illiteracy"){
    "Illiteracy (Percent of Population in 1970)"
  } else if(as.character(variable2())=="Life_Exp"){
    "Life Expectancy in Years (1969-1971)"
  } else if(as.character(variable2())=="HS_Grad"){
    "Percent of High School Graduates (1970)"
  } else if(as.character(variable2())=="Frost"){
    "Mean # of Days with Minimum Temp Below Freezing (1931-1960)"
  } else if(as.character(variable2())=="Area"){
    "Land Area in Square Miles"
  } else{
    as.character(variable2())
  }
  })
  
  output$statePlot <- renderPlot({
    g <- ggplot(state_data, aes_string(x=as.character(variable1()), y=as.character(variable2())))
    g <- g + geom_smooth(method=lm)
    g <- g + geom_text(aes(label=as.character(state_data$State)),hjust=.5, vjust=.5, size=4, angle=20)
    g <- g + xlab(as.character(v1_label())) + ylab(as.character(v2_label()))
    g <- g + theme_bw()
    g
  })
  
  output$correlation <- renderText({
    correlation <- cor(state_data[,as.character(variable1())], state_data[,as.character(variable2())])
    paste("The correlation shown above is ", round(correlation,2), ".", sep="")
  })  
  
  observeEvent(input$help, {
    session$sendCustomMessage(type = 'testmessage',
                              message = 'Select 2 variables (above) that you would like to see the scatterplot of.  A linear regression line will be automatically overlayed on the plot. The correlation coefficient relating to that regression line will be shown below.')
  })
  
  observeEvent(input$doc, {
    session$sendCustomMessage(type = 'testmessage',
                              message = 'The data come from the R datasets package, dataset = state. This dataset contains 8 variables on the 50 states of the United States.  The 8 variables are: population, income, % illiteracy, life expectancy, murder rate, high school graduation rate, days with temperatures below freezing, and land area.')
  })
    
})
