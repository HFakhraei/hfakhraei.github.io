---
---

$ ->
  $('.youtube').each ->
    width = 720
    height = 480
    $(@).append "<iframe width=\"#{width}\" height=\"#{height}\" src=\"https://www.youtube.com/embed/#{@id}\" frameborder=\"0\" allowfullscreen></iframe>"
