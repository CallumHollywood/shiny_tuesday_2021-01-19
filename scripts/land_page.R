

landpageUI <- function(id){
  
  ns <- NS(id)
  
  tagList(
    fluidRow(
      column(width = 12,
             align = "center",
             h2("County Profiles of the Kenya 2019 Census Data"),
             br(),
             h3("A Shiny App Development Exercise showcasing the Tidy Tuesday Data from 2021-01-19"),
             br(),
             hr()
      )
    ),
    fluidRow(
     column(width = 4),
     column(width = 4,
            align = 'center',
            uiOutput(ns('outpt_slt_county'))
            ),
     column(width = 4)
    )
  )
}




landpage <- function(input, output, session, census_data ){
  

  ## eventReactives       ####
  #--------------------------#
  
  slt_county <- eventReactive(input$btn_go_to_profile,{
    
    input$slt_county
    
  })
  

  ## ObserveEvents        ####
  #--------------------------#
  
  
  observeEvent(input$btn_go_to_profile, {
    
    updateQueryString(
      paste0(getQueryString(), paste0("#profile_", input$slt_county)),
      "push"
    )
    
  })
  

  ## Outputs              ####
  #--------------------------#
  
  output$outpt_slt_county <- renderUI({
    
    ns <- session$ns
    
    county_choices <- census_data %>% select(county) %>% arrange(county) %>% pull()
    
    
    tagList(
      selectInput(ns('slt_county'),
                  "Select County",
                  choices = county_choices,
                  selected = county_choices[27],
                  width = '100%'
                  ),
      actionButton(ns('btn_go_to_profile'),
                   'GO',
                   width = '100%'
                   )
    )
  })
  
  
  
  ## CallModules          ####
  #--------------------------#

  return(
    list(
      county_fks = reactive({slt_county()}) 
    )
  )
  
  
}