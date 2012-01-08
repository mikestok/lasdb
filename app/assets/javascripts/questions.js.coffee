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

  # Because the controls which move answers up and down re-load the
  # question and its answers from the database I put this kludge in 
  # to remove the control when the content of an answer is changed -
  # so the user can't move the answers 'cos the controls aren't there.
  answer_changers = "table.answers .change-answer-content"
  answer_movers = "table.answers .move-answer-control"
  $(document).delegate answer_changers, "change", (event) ->
    $(answer_movers).hide()

  # This uses https://github.com/padolsey/jQuery.fn.autoResize.
  # I make a function so that questions/move_answer.js.erb can 
  # update it the same way whe the question is re-rendered.
  $.setUpAutoResize = ->
    $("form.edit_question textarea").autoResize {
      extraSpace: 5
    }
  $.setUpAutoResize()
