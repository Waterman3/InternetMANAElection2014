
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

turnout2014<-read.csv("e9_part9_2.csv",skip=5,header=FALSE)
General_turnout_2014<-turnout2014[1:64,]
Maori_turnout_2014<-turnout2014[66:72,]
names(Maori_turnout_2014)=c("ElectorateName","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15")
names(General_turnout_2014)=c("ElectorateName","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13","V14","V15")
elect_types<-read.csv("elect_types.csv",header=TRUE)
party_vote_2014_raw<-read.csv("party_vote_2014.csv")
party_vote_2014<-rbind(party_vote_2014_raw[1:64,],party_vote_2014_raw[66:72,])
party_vote_2014_electorate<-cbind(party_vote_2014[,1:18],elect_types$ElectorateType)
Elect_turnout_2014<-rbind(General_turnout_2014,Maori_turnout_2014)

IMvotes_2014<-cbind(elect_types,Elect_turnout_2014[,13],party_vote_2014_electorate$INTERNET_MANA)
names(IMvotes_2014)<-c("Electorate","ElectorateType","turnout","party_vote")

shinyServer(function(input, output) {
  
  output$turnoutPlot <- renderPlot({
    plot(IMvotes_2014$turnout,y=IMvotes_2014$party_vote,
         xlab = "Turnout (percent)", ylab = "Party vote")
    
  })
    
    turnout_model<-reactive({
      IM_party_vote <- brushedPoints(IMvotes_2014,input$electorate_brush,
                                     xvar = "turnout", yvar= "party_vote")
      if(nrow(IM_party_vote)<3) {
        return(NULL)
      }
      lm(party_vote ~ turnout, data = IM_party_vote)
      
  })
  output$Intercept <- renderText({
      if (is.null(turnout_model())) {
        "Not Enough Points Chosen"
        }
        else 
          {
            turnout_model()[[1]][1]
            }
        })
  output$Slope <- renderText({ 
    if (is.null(turnout_model())) {
      "Not Enough Points Chosen"
    }
    else 
    {
      turnout_model()[[1]][2] 
    }
  })
  output$Sigma <- renderText({ 
    if (is.null(turnout_model())) {
      "Not Enough Points Chosen"
    }
    else 
    {
      summary(turnout_model())$sigma
      }
    })
})
