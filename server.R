

census_data <- read_csv("scripts/data/census_data.csv")


server <- function(input, output, session){
  
  
  ## Reactives              ####
  #----------------------------#
  
  census_data_long_wide_rctv <- reactive({
    
    req(lndpge$county_fks())
    
    census_data %>% 
      filter(county == lndpge$county_fks()) %>%
      pivot_longer(farming:khat_miraa, names_to = 'industry') %>% 
      filter(!is.na(value)) %>% 
      select(county, industry, value) %>% 
      pivot_wider(names_from = industry, values_from = value)
    
  })
  
  
  census_data_bar_rctv <- reactive({
    
    req(lndpge$county_fks())
    
    # county in foocus
    county_data <- census_data %>% 
      filter(county == lndpge$county_fks()) %>% 
      select(county, population, number_of_households)
    
    
    # all counties for comparison 
    census_data_bar <- census_data %>% 
      select(county, population, number_of_households) %>% 
      transmute(
        county,
        population = mean(population),
        number_of_households = mean(number_of_households)
      ) %>% 
      slice(1) %>% 
      mutate(county = 'all county average') %>% 
      bind_rows(county_data) %>% 
      mutate(county = str_to_title(county))
    
  })
  
  
  ## live_hash = a constant reading of the URL address bar
  ## -------------------------------------------------------
  
  live_hash <- reactive({getUrlHash()})
  
  
  ## Outputs                ####
  #----------------------------#
  
  output$main_ui <- renderUI({
    
    if(live_hash() == ""){
      landpageUI("lndpge")
    } else if(str_detect(live_hash(), "profile_")){
      profile_mod_UI("prflmd")
    } 
    
  })
  
  
  
  ## CallModules            ####
  #----------------------------#

  lndpge <- callModule(landpage, "lndpge"
                       , census_data = census_data
                       )

  callModule(profile_mod, 'prflmd'
             , census_data_county = census_data_long_wide_rctv
             , census_data_bar    = census_data_bar_rctv
             )
  
  
  
}