# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class EspagoContainer
  container: "#espago-container" 

  $: (sel) =>
    jQuery("#{@container} #{sel}")

class TermsLink extends EspagoContainer
  term: "#espago-terms"

  accept: =>
    $(@term).prop("checked", true) 
    
  decline: =>
    $(@term).prop("checked", false) 
  
  accepted: =>
    $(@term).is ":checked"

  toggleButton: =>
    return @$(".actions .button").addClass 'enabled' if @accepted()
    @$(".actions .button").removeClass 'enabled'

class TermsLinksListener
  constructor: (@terms = new TermsLink) ->
    @listen()

  listen: =>
    $(@terms.term).click (e) =>
      @terms.toggleButton()

class SelectButtons extends EspagoContainer
  buttons: ".options li"

  all: =>
    @$(@buttons)

class SelectButtonsListener extends EspagoContainer
  constructor: (@buttons = new SelectButtons, @terms = new TermsLink) ->
    @listen()

  listen: =>
    @buttons.all().click (e) =>
      e.preventDefault()
      form = $(e.target).data('transfer')
      if @terms.accepted()
        @showForm(form) 
      else
        alert "Proszę zaakceptować warunki regulaminu"

  showForm: (form) =>
    $("#espago-card-form").css( opacity: 1, "z-index": 2 )
    @$("##{form}-form-holder").show()


  addTransferType: (form) =>
    builder = new EspagoTransferType(form)
    @$("[data-form=#{form}]").append builder.input()

class CardFormListener
  form: "#espago-card-form"
  constructor: ->
    @listen()

  listen: =>
    $("#{@form} header a.close").click (e) =>
      e.preventDefault()
      @hideForm()

  hideForm: =>
    $(@form).css( opacity: 0, "z-index": -1 )
    $("#espago-form-holder").hide()
    $("#cc-form-holder").hide()
    $("#pbn-form-holder").hide()

$(document).ready ->
  terms = new TermsLinksListener
  buttons = new SelectButtonsListener
  cardForm = new CardFormListener