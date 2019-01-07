library(shiny)
library(shinydashboard)
library(datasets)
library(DT)

library(data.table)
library(dplyr)
library(ggplot2)
library(plotrix)
library(gridExtra)
library(rpivotTable)

#Used shinyUI dashboard to create rich interactive dashboard component.
shinyUI(dashboardPage(
  title = "Product Sales Analysis",
  skin = "red",
  dashboardHeader(title = "Sales Analysis"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuSubItem("Sales", tabName = "sales", icon = icon("bar-chart")),
      menuSubItem("Category-wise Performance", tabName = "prodlineperf", icon = icon("bolt")),
      menuItem("Regression", tabName = "regression")
    )
  ),
  
  dashboardBody(
    headerPanel("",
                tags$head(
                  tags$img(src="ttu1.png", style="width:100%")
                )
    ),
    
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                column(width = 10,
                       valueBoxOutput("countries"),
                       valueBoxOutput("products")
                )
              ),
              fluidRow(
                box(title = "Country-wise Revenue", solidHeader = T,
                    status = "success",  plotOutput("piechart", hover = hoverOpts(id ="plot_hover", delay = 0)),
                    uiOutput("dynamic")),
                box(title = "Sales Revenue Data", status = "warning", solidHeader = T,
                    background = "teal",
                    DT::dataTableOutput("country_rev")
                )
              )
      ),
      
      tabItem(tabName = "sales",
              fluidRow(
                column(12,
                       tabBox(width = 12,
                              tabPanel(title = "Retailer-wise Revenue", solidHeader = T,
                                       background = "aqua",
                                       status = "primary",
                                       tags$head(tags$style( type = 'text/css',  '#rpivotRetRev{ overflow-x: scroll; }')),
                                       rpivotTableOutput("rpivotRetRev")
                              ),
                              tabPanel(title = "Order Method Type", status = "warning", solidHeader = T,
                                       background = "teal",
                                       tags$head(tags$style( type = 'text/css',  '#rpivotOrderMethType{ overflow-x: scroll; }')),
                                       rpivotTableOutput("rpivotOrderMethType")
                              )
                       )
                )
              )
      ),
      
      tabItem(tabName = "prodlineperf",
              fluidRow(
                column(12,
                       tabBox(width = 12,
                              tabPanel(title = "Category-wise Performance", solidHeader = T,
                                       background = "aqua",
                                       status = "primary",
                                       tags$head(tags$style( type = 'text/css',  '#rpivotProdPerf{ overflow-x: scroll; }')),
                                       rpivotTableOutput("rpivotProdPerf")
                              )
                       )
                )
              )
      ),
      
      tabItem(tabName = "regression",
              fluidRow(
                column(12,
                       tabBox(width = 12,
                              tabPanel(title = "Revenue Vs Quantity", solidHeader = T,
                                       background = "aqua",
                                       status = "primary",
                                       plotOutput("nplotrev_vs_qty")
                              ),
                              tabPanel(title = "Revenue Vs Cost Of Goods Sold", solidHeader = T,
                                       background = "aqua",
                                       status = "primary",
                                       plotOutput("nplotrev_vs_cst")
                              ),
                              tabPanel(title = "Revenue Vs Marketing Cost", solidHeader = T,
                                       background = "aqua",
                                       plotOutput("nplotrev_vs_mkt_cst")
                              ),
                              tabPanel(title = "Model Summary", solidHeader = T,
                                       background = "aqua",
                                       verbatimTextOutput("model_summary")
                              )
                              
                       )
                )
              )
      )
    )
  )
))
