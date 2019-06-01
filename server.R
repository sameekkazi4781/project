library(ggplot2)
shinyServer(
 
  function(input,output,session)
  {
    # file$datapath -> gives the path of the file
    data <- reactive({
      file1 <- input$file
      if(is.null(file1)){return()} 
      read.csv(file=file1$datapath, sep=",", header = TRUE)
      
    })
    #details of file uploaded
    output$filedf <- renderTable({
      if(is.null(input$file)){return ()}
      input$file
    })
    
    
    # Extract the file path for file
    output$filedf2 <- renderTable({
      if(is.null(input$file)){return ()}
      input$file$datapath 
    })
   
    
     ## Side bar select input widget coming through renderUI()
  
    # Following code displays the select input widget with the list of file loaded by the user
    #multiple file selection
    
    output$selectfile <- renderUI({
      if(is.null(input$file)) {return()}
      list(hr(), 
           helpText("Select the files for which you need to see data and summary stats"),
           selectInput("Select", "Select", choices=input$file$name)
      )
      
    })
   
    
    #### selcted table displayed from multiple files
    output$tablee <- renderTable({ 
      if(is.null(input$file)){return()}
      read.csv(input$file$datapath[input$file$name==input$Select], sep=",", header = TRUE )
    })
    # table for one file selcted
    output$tabl <- renderTable({
      if(is.null(data())){return ()}
      data()
    })
    
    ##### Summary Stats for multiple file selction##
    output$summm <- renderPrint({
      if(is.null(input$file)){return()}
      summary(read.csv(input$file$datapath[input$file$name==input$Select], sep=",", header = T ))
    })
    
    output$selec_hist <- renderTable({ 
      if(is.null(input$file)){return()}
 s1<-read.csv(input$file$datapath[input$file$name==input$Select], sep=",", header = TRUE )
 s1
 
    })
     #summary for one file selcted
        output$sum <- renderTable({
      if(is.null(data())){return ()}
      summary(data())
      
    })
    
   
    
    ##################################
    ### this contain multile tabs 
        ## multiple selcted files diplayed
    output$tS <- renderUI({
      if(is.null(input$file)) 
        h1("NO FILES SELECTED ", tags$img(src='xl1.png', heigth=500, width=857))
      else
        tabsetPanel(
          tabPanel("Input File Object DF ",  tableOutput("filedf"),  tableOutput("filedf2")),
          #tabPanel("Input File Object Structure", verbatimTextOutput("fileob")),
           tabPanel("Dataset", tableOutput("tablee")),
          tabPanel("Summary Stats", verbatimTextOutput("summm")),
          tabPanel("hitogram",value=1,plotOutput("myhist_selec")),
          id="tabs"
          
         
          )
    })
    output$choose<-renderUI({
      conditionalPanel(condition="input.tabs==1",selectInput("dataa","Select your required data for plot",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)))
      
      #This will gives an option to select column when histogram tag is selected
      })
    output$myhist_selec<-renderPlot({
     # s1()<-read.csv(input$file$datapath[input$file$name==input$Select], sep=",", header = TRUE )
      colmn<-as.numeric(input$dataa)
      hist(s1()[,colmn],5,col=input$color,main="histogram for excle data set",xlab=names(s1()[colmn]))
      
      
    })#print histogram
    
     ##################################
        ### this contain multile tabs 
    output$tb <- renderUI({
      if(is.null(data()))
        h1("NO FILE SELECTED ", tags$img(src='xl1.png', heigth=500, width=857))
      else
        tabsetPanel(type="tab",
          tabPanel("About file",tableOutput("filedf")),
          tabPanel("TABLE", tableOutput("tabl")),
          tabPanel("SUMMARY", tableOutput("sum")),
          
          )
    })#### sub tabs of newfile
    
    
  output$dataname<-renderText({
      paste("Table of dataset ",input$dataset)
    })#tqable name
   output$observation<-renderText({
     paste("first",input$obs,"of dataset",input$dataset)
   })#no of observations seclted
   output$view<-renderTable({
    input$action
     
    isolate(  head(get(input$dataset),n=input$obs))
   })#selctive no of observation display in table
    
   #if we want to apply same code multiple time make reactive function
   s1<-reactive({
     read.csv(input$file$datapath[input$file$name==input$Select], sep=",", header = TRUE )
   })
  colm<-reactive({
    switch(input$dataset,
           "x2"=names(x2),
           "a1"=names(a1),
           "a2"=names(a2))
  })
  dsinput<-reactive({
        switch(input$dataset,
               "x2"=x2,
               "a1"=a1,
               "a2"=a2)
      })
    x<-reactive({
      x2[,as.numeric(input$xval)]
    })
    y<-reactive({
      x2[,as.numeric(input$yval)]
    })
    ############# reactive
    
    output$vx<-renderUI(
      selectInput("rand_colmns","select column",choices=colm())        
    )
    
    output$table<-renderTable({
      dsinput()
    })#print whole table
    #output$myname<-renderText(input$name)
    
    #  output$myslider<-renderText(
    #   paste("you selected the value",input$slider))
   
    output$plot<-renderPlot({
      plot(x(),y())
    })#print scatter plot
    
     output$data<-renderTable(
      x2[c(10,11,14)]
    )#print table of selcted columns
     
    output$summ<-renderPrint({
      colmn<-as.numeric(input$sry)
      summary(x2[colmn])
     # summary(data())
      }
    )    #print summary
    
    output$myhist <-renderPlot({
      colmn<-as.numeric(input$data)
      hist(x2[,colmn],10,col=input$color,main="histogram for excle data set",xlab=names(x2[colmn]))
      #hist(x2[,colmn],breaks = seq(0,max(x2[,colmn],l=input$slider+1)))
      
    })#print histogram
    
    output$down<-downloadHandler(
      
      
      filename = function()
      {paste("",input$format,sep='.')
        
      },
      content = function(file){
        if(input$format=="pdf")
          pdf(file)
        else
            png(file)
        plot(x(),y())
        dev.off()
      })#output$down download button fuctionality
    
    
  }#function
  )#shiny serveer
