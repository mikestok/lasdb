jQuery(document).ready ($) ->
  # In the table which contains editable answers I want the 
  # "Correct?" checkbox for all the questions to act with
  # radio button interface, and this seems to be the simplest
  # way to force it... until I understand 
  radios = "table.answers tr.answer input[@type='checkbox'].radio-like"
  $(document).delegate radios, "click", (event) ->
    event.stopPropagation()
    $(radios).attr "checked", null
    $(event.target).attr "checked", 1
