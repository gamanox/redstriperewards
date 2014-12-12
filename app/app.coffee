'use strict'
# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'ngRoute'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
  'partials'
])

App.config([
  '$routeProvider'
  '$locationProvider'

($routeProvider, $locationProvider, config) ->

  $routeProvider

    .when('/age', {templateUrl: '/partials/age.html', controller: 'ageCtrl'})
    .when('/home', {templateUrl: '/partials/home_login.html'})
    .when('/register', {templateUrl: '/partials/register.html', controller: 'registerCtrl'})
    .when('/congratulations', {templateUrl: '/partials/congratulations.html', controller: 'congratsCtrl'})
    .when('/connect', {templateUrl: '/partials/connect.html', controller: 'connectCtrl'})
    .when('/confirm_social', {templateUrl: '/partials/confirm_social.html', controller: 'confirm_socialCtrl'})
    .when('/profile', {templateUrl: '/partials/profile.html', controller: 'profileCtrl'})
    .when('/login', {templateUrl: '/partials/login.html', controller: 'loginCtrl'})
    .when('/prizes', {templateUrl: '/partials/prizes.html', controller: 'prizesCtrl'})
    .when('/verify_account', {templateUrl: '/partials/verify_account.html', controller: 'verifyaccountCtrl'})
    .when('/verify_email', {templateUrl: '/partials/verify_email.html', controller: 'verifyemailCtrl'})
    .when('/verify_sms', {templateUrl: '/partials/verify_sms.html', controller: 'verifysmsCtrl'})
    .when('/view2', {templateUrl: '/partials/partial2.html'})

    # Catch all
    .otherwise({redirectTo: '/age'})

  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(false)
])






      
  
  # console.log 'dolgin'
  # FB.getLoginStatus (response) ->
  #   if response.status is 'connected'
  #     #Logged into your app and Facebook.
  #     FB.api "/me", (response) ->
  #       getInfo(response)
        
  #   else if response.status is 'not_authorized'
  #     #The person is logged into Facebook, but not your app.
  #     FB.login (response) ->
  #       FB.api "/me", (response) ->
  #         getInfo(response)
          
  #   else
  #     FB.login (response) ->
  #       FB.api "/me", (response) ->
  #         getInfo(response)