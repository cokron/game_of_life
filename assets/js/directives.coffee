"use strict"
app = angular.module('app.directives',  ['$strap.directives'])

app.directive "eatClick", ->
  (scope, element, attrs) ->
    $(element).click (event) ->
      event.preventDefault()
      false



