fluidPage(
  textAreaInput("text_input"
                , "Enter text to Spritz:"
                , value = "The quick brown fox jumps over the lazy dog"
                , height = '400px'
                , width = '400px')
  , actionButton("start_spritz"
                 , "Start Spritz")
  , sliderInput("speed_slider"
                , "Select words per minute"
                , min = 100
                , max = 500
                , value = 250
                , step = 10)
  , box(width = 6
        , status = "info"
        , solidHeader = T
        , title = "Test"
        , fluidRow(
          imageOutput("plot1")
          # , actionButton("pause", "Pause")
          # , actionButton("prev", "Prev")
          # , actionButton("next_button", "Next")
          # , actionButton("start", "Start")
        )
  )
)