


profile_mod_UI <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      verbatimTextOutput(ns('test'))
    ),
    fluidRow(
      column(width = 12,
             align = 'center',
             uiOutput(ns('outpt_profile_title'))
      )
    ),
    hr(),
    fluidRow(
      column(width = 6,
             amChart4Output(ns('outpt_rdl_br'))
             ),
      column(width = 6,
             amChart4Output(ns('outpt_am_br'))
             
             )
    )
    
    
    
  )
}

profile_mod <- function(input, output, session
                        , census_data_county 
                        , census_data_bar
) {
  

  #### <<<<    OUTPUTS         >>>>  ####
  #-------------------------------------#
  
  output$outpt_am_br <- renderAmChart4({
    
    amBarChart(
      data = census_data_bar(),
      width = "700px",
      category = "county",
      values = c("population", "number_of_households"),
      valueNames = list(population = "population", number_of_households = "number_of_households"),
      tooltip = amTooltip(
        textColor = "white",
        backgroundColor = "#101010",
        borderColor = "silver"
      ),
      draggable = list(population = TRUE, number_of_households = FALSE),
      backgroundColor = "#2b3e50",
      columnStyle = list(
        population = amColumn(
          color = "darkmagenta",
          strokeColor = "#cccccc",
          strokeWidth = 2
        ),
        number_of_households = amColumn(
          color = "darkred",
          strokeColor = "#cccccc",
          strokeWidth = 2
        )
      ),
      chartTitle = "County Population & No of Households v All County Average",
      xAxis = list(title = amText(text = "County")),
      yAxis = list(
        title = amText(text = "Count"),
        gridLines = amLine(color = "whitesmoke", width = 1, opacity = 0.4),
        breaks = amAxisBreaks(values = seq(0, 45, by = 5))
      ),
      yLimits = c(0, 1200000),
      valueFormatter = "#.#",
      caption = amText(text = "Census Kenya 2019"),
      theme = "dark")
    
    
  })
  
  

  output$outpt_rdl_br <- renderAmChart4({
    
    
    plot_data <- census_data_county()
    
    plot_values <- colnames(plot_data)[!colnames(plot_data) == 'county']
    
    amRadialBarChart(
      data = plot_data, data2 = NULL,
      width = "600px", height = "600px",
      category = "county",
      values = plot_values,
      valueNames = NULL,
      showValues = FALSE,
      tooltip = amTooltip(
        textColor = "white",
        backgroundColor = "#101010",
        borderColor = "silver"
      ),
      draggable = TRUE,
      backgroundColor = "#2b3e50",
      columnStyle = list(
        
        farming = amColumn(
          color = "darkmagenta",
          strokeColor = "#cccccc",
          strokeWidth = 2
        ),
        tea = amColumn(
          color = "darkred",
          strokeColor = "#cccccc",
          strokeWidth = 2
        ),
        coffee  = amColumn(
          color = "darkgreen",
          strokeColor = "#cccccc",
          strokeWidth = 2
        ),
        avocado  = amColumn(
          color = "green",
          strokeColor = "darkred",
          strokeWidth = 2
        ),
        citrus  = amColumn(
          color = "darkred",
          strokeColor = "orange",
          strokeWidth = 2
        ),
        mango  = amColumn(
          color = "darkred",
          strokeColor = "lime",
          strokeWidth = 2
        ),
        coconut = amColumn(
          color = "white",
          strokeColor = "#cccccc",
          strokeWidth = 2
        ),
        macadamia  = amColumn(
          color = "darkred",
          strokeColor = "brown",
          strokeWidth = 2
        ),
        cashew_nut = amColumn(
          color = "darkred",
          strokeColor = "darkred",
          strokeWidth = 2
        ),
        khat_miraa  = amColumn(
          color = "darkred",
          strokeColor = "grey80",
          strokeWidth = 2
        )
      ),
      chartTitle = "Population by Industry",
      xAxis = list(
        labels = amAxisLabelsCircular(
          radius = -100, relativeRotation = 180
        )
      ),
      yAxis = list(
        labels = amAxisLabels(color = "orange"),
        gridLines = amLine(color = "whitesmoke", width = 1, opacity = 0.4),
        breaks = amAxisBreaks(values = seq(0, 15000, by = 5000))
      ),
      yLimits = c(0, 15000),
      valueFormatter = "#.#",
      caption = amText(
        text = "",
        fontFamily = "Impact",
        fontSize = 18
      ),
      theme = "dark")
    
    
  })

  output$outpt_profile_title <- renderUI({
    
    h2(paste0('Profile of ', str_to_title(census_data_county()$county[1]), " County"))
    
  })
  

  
  
  
}