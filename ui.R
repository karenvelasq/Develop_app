library(shiny)
shinyUI(
  fluidPage(
    tabsetPanel(
        tabPanel("INSTRUCTIOS",
                 titlePanel("USE THE APP"),
                 sidebarLayout(
                   sidebarPanel(
                     h3("INSTRUCTIONS")



                   ),
                   mainPanel(
                     h3("CONTENT"),
                     h5("This information contains the summary of the two databases:
                         iris and attitude where in the Summary tab you can choose
                        the database you want to summarize and you should choose the amount
                        of records you want to see in the attached table"),
                     h3(""),
                     h3("STEPS"),
                     h4("Step 1"),
                     h5("Go to the panel named SUMMARY INFORMATION"),
                     h5("Once you are there, select the data set you want
                         to access"),
                     h5("Choose the number of observations you wish to observe in the
                         table that will serve as a complement"),
                     h5("Select the UPDATE VIEW button to view the summary and update the
                         table"),
                     h3(""),
                     h4("Step 2"),
                     h5("Go to the Clustering sheet in this sheet you will be able to observe
                        "),
                     h5("Select the variable x and y to apply the method"),
                     h5("Select the number of clusters you want to apply to the method"),
                     h5("In this sheet you can apply to the data already selected, a
                         cluster method, where you choose the cluster number and you can
                         observe graphically")
                   )
                 )),

         tabPanel("Summary Information",
               sidebarLayout(

                 # Sidebar panel for inputs ----
                 sidebarPanel(

                   # Input: Select a dataset ----
                   selectInput("dataset", "Choose a dataset:",
                               choices = c("iris", "attitude")),

                   # Input: Number of observations ----
                   numericInput("obs", "Observations to view in the table:", 10),

                   # Help ----
                   helpText("PLEASE: Select the data set that you know in the table",
                            "then click in the button Update Viewe to see the information"),

                  # Action Button to update the data set
                   actionButton("update", "Update View")

                 ),

                 # Main panel  ----
                 mainPanel(

                   # Output: ----
                   h4("Summary"),
                   verbatimTextOutput("summary"),

                   # Output: ----
                   h4("Observations"),
                   tableOutput("view")
                 )

               )
      ),
      tabPanel("Clustering",

               sidebarPanel(
                 conditionalPanel(
                 'input.dataset === "iris"',
                 selectInput('xcol', 'X Variable', names(iris)),
                 selectInput('ycol', 'Y Variable', names(iris),
                             selected = names(iris)[[2]])),
                 conditionalPanel(
                   'input.dataset === "attitude"',
                   selectInput('xcol2', 'X Variable', names(attitude)),
                   selectInput('ycol2', 'Y Variable', names(attitude),
                               selected = names(attitude)[[2]])),
                 numericInput('clusters','Cluster count',3,min=1,max=9)),
                 mainPanel(
                   conditionalPanel(
                     'input.dataset === "iris"',
                   plotOutput('plot1')),

                   conditionalPanel(
                     'input.dataset === "attitude"',
                     plotOutput('plot2'))



               )


               )
  )
))
