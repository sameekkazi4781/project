library(shiny) 
shinyUI(
  fluidPage(
    titlePanel( title=h2("Demonstartionn of renderd plot",align="center")),
    
    sidebarLayout(
      
      sidebarPanel(
        "Enter Requirements",
        #file upload
        fileInput("file","Upload the file",multiple = TRUE), # fileinput() function is used to get the file upload contorl option
        tags$img(src='xl2.jpg', heigth=50, width=50),# image tag
        helpText("Default max. file size is 5MB"),
        tags$hr(),
        
        tags$style("body{background-color:CornflowerBlue ; color:DarkBlue}"),
        #whole
        tags$style(".container-fluid{color:DarkBlue;font-style: oblique}"),
        
        tags$style(".tabbable{color:DarkBLue;font-style: oblique}"),
        tags$style(".control-label{color:DarkBLue;font-style: oblique}"),
        tags$style(".selectize-control{color:DarkBLue;font-style}"),
      #left  
      tags$style(".col-sm-4{border-style: solid}"),
       #inside right
      #tags$style(".tab-content{border-style: solid}"),
        
      uiOutput("choose"),
        
        uiOutput("selectfile"),
       # h5(helpText("Select the read.table parameters below")),
       
      
         #prints random selction of colom depands on datset
  ##  uiOutput("vx"),
       
  ## selectInput("data","Select your required data for plot",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)),
  ## selectInput("sry","Select your required data for Summary",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)),
  ## selectInput("xval","Select  X-AXIS",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)),
  ##  selectInput("yval","Select  Y-AXIS",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)),
  ##  selectInput("dataset","select dataset",choices = c("x2","a1","a2")), 
  ##  numericInput("obs","Select no of observations",6),
  ##  actionButton("action","update!"),   
        ##textInput("text1","Enter frist name"),
        
       
        #helpText("CLICK ON UPDATE TO DISPLAY YOUR FIRST NAME"),
        br(),
        #sliderInput("slider","Select number of bins from slider",min=0,max=100,value = 0),
        #br(),
    ## radioButtons("color","Select your Graph's color",choices = c("Green","REd","Yellow")),
    ## radioButtons("format","Select your Downloading Format",choices = c("pdf","png")),
    ##  radioButtons("formatdata","Select your Downloading Format",choices = c("csv","tsv",'xlxs')),

  conditionalPanel(condition="input.tabselected==1",radioButtons("color","Select your Graph's color",choices = c("Green","REd","Yellow")),selectInput("data","Select your required data for plot",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)),radioButtons("format","Select your Downloading Format",choices = c("pdf","png"))),
  conditionalPanel(condition="input.tabselected==2", selectInput("xval","Select  X-AXIS",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)),selectInput("yval","Select  Y-AXIS",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4)),radioButtons("format","Select your Downloading Format",choices = c("pdf","png"))),
  conditionalPanel(condition="input.tabselected==3",selectInput("sry","Select your required data for Summary",choices = c("Revenue"=10,"Profits"=11,"Selling Quantity"=4))),
  conditionalPanel(condition="input.tabselected==4",selectInput("dataset","select dataset",choices = c("x2","a1","a2")),uiOutput("vx"),  numericInput("obs","Select no of observations",6),actionButton("action","update!")   )
  
  
      ),mainPanel(tabsetPanel(
        type="tab",
      tabPanel("one file ", uiOutput("tb")),
      tabPanel("multiple files", uiOutput("tS")),
      tabPanel("plot",value=1,  plotOutput("myhist")),
      tabPanel("ScatterPLOT",value=2,plotOutput("plot"),downloadButton("down","Download Plot")),
        tabPanel("Summary",value=3,verbatimTextOutput ("summ")),
        tabPanel("Structure",value=4,h2(textOutput("dataname")),tableOutput("table") ,downloadButton("downdata","Download data"),h2(textOutput("observation")),tableOutput("view")),
     
      
      id = "tabselected"
       # tabPanel("PDF",tags$iframe(style="height:400px;width:100%;scrolling:yes",src="Chap 1 - Introduction to SE.pdf"))
    
        # using iframe along with tags() within tab to display pdf with scroll, height and width could be adjusted
        #tabPanel("Reference", tags$iframe(style="height:400px; width:100%; scrolling=yes", src="Chap 1 - Introduction to SE.pdf"))
      )
      
    #  textOutput("name")
      )
    )#sidebar layout
    
    
    
  )#fluid page
  
  
  
  
  
)#shiny UI