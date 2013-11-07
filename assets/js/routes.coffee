'use strict'

# Declare app level module which depends on filters, and services
angular.module("app", []).
  config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->
    $routeProvider
      .when "/",
        templateUrl: "partials/life"
        controller: 'LifeController'

      .otherwise
        template: '<div class="alert alert-error">Sorry, the requested page does not exist.</div>'
  
    $locationProvider.html5Mode true
  ]
