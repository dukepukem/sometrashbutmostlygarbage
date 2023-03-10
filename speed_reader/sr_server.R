# Start Button is pressed
observeEvent(input$start_spritz, {
  
  #TODO: Split into paragraphs?
  
  # Create vector of words in input field
  words <- unlist(strsplit(input$text_input, " "))
  
  # Set read speed (this will need to move to the play button once you've made that)
  speed <- input$speed_slider/60
  
  # Initialise word table
  dt_spritz <- data.table(i = 1:length(words)
                          , x = 1
                          , y = 1
                          , word = words)
  
  # Add optimal recognition point
  dt_spritz[, opr := fifelse(round(0.4 * str_count(word),0)==0
                             , 1
                             , round(0.4 * str_count(word),0))]
  dt_spritz[, opr_letter := str_sub(word, opr, opr)]
  
  # Render plot
  output$plot1 <- renderImage({
    
    # Initialise temporary gif
    outfile <- tempfile(fileext='.gif')
    
    # Create gif
    p <- ggplot(dt_spritz
                , aes(x,y)) +
      # Left of OPR
      geom_text(size = 24
                , label = paste0(str_sub(dt_spritz$word, 1, dt_spritz$opr-1), " ")
                , hjust = 1) + 
      # OPR
      geom_text(size = 24
                , label = dt_spritz$opr_letter
                , color = "red") + 
      # Right of OPR
      geom_text(size = 24
                , label = paste0(" ", str_sub(dt_spritz$word, dt_spritz$opr+1))
                , hjust = 0) +
      # Up arrow (bottom)
      geom_point(x = 1
                 , y = 0.988
                 , shape = 24
                 , color = "red"
                 , fill = "red"
                 , size = 10) +
      # Down arrow (top)
      geom_point(x = 1
                 , y = 1.01
                 , shape = 25
                 , color = "red"
                 , fill = "red"
                 , size = 10) +
      theme_void() +
      transition_time(i)
    
    # Save temp gif
    anim_save("outfile.gif", animate(p, nframes = length(words), fps = speed))
    
    # Return gif to renderer
    list(src = "outfile.gif"
         , contentType = 'image/gif'
         # width = 400,
         # height = 300,
         # alt = "This is alternate text"
         , deleteFile = TRUE)
  })
})



# Graveyard ---------------------------------------------------------------

 
# # Define an observeEvent for the pause button
# observeEvent(input$pause, {
#   js$pause_gif()
# })
# 
# # Define an observeEvent for the prev button
# observeEvent(input$prev, {
#   js$prev_gif()
# })
# 
# # Define an observeEvent for the next button
# observeEvent(input$next_button, {
#   js$next_gif()
# })
# 
# # Define an observeEvent for the start button
# observeEvent(input$start, {
#   js$start_gif()
# })
# 
# # Define JavaScript code to control the animation
# js <- HTML("
#   
#   <script>
#     
#     // Get the GIF element
#     var gif = document.getElementById('gif');
#     
#     // Initialize the current frame index
#     var current_frame = 0;
#     
#     // Set the interval ID to null
#     var interval_id = null;
#     
#     // Define a function to pause the GIF
#     Shiny.addCustomMessageHandler('pause_gif', function(message) {
#       clearInterval(interval_id);
#     });
#     
#     // Define a function to go back one frame in the GIF
#     Shiny.addCustomMessageHandler('prev_gif', function(message) {
#       current_frame = Math.max(0, current_frame - 1);
#       gif.src = 'animation.gif#' + current_frame;
#     });
#     
#     // Define a function to go forward one frame in the GIF
#     Shiny.addCustomMessageHandler('next_gif', function(message) {
#       current_frame = Math.min(gif.frames.length - 1, current_frame + 1);
#       gif.src = 'animation.gif#' + current_frame;
#     });
#     
#     // Define a function to go back to the first frame of the GIF
#     Shiny.addCustomMessageHandler('start_gif', function(message) {
#       current_frame = 0;
#       gif.src = 'animation.gif#' + current_frame;
#     });
#     
#     // Start the GIF animation
#     interval_id = setInterval(function() {
#       current_frame = (current_frame + 1) % gif.frames.length;
#       gif.src = 'animation.gif#' + current_frame;
#     }, 100);
#     
#   </script>
#   
# ")


