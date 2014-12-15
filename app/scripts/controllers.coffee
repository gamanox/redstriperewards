'use strict'

### Controllers ###
userData = []
popSMS = ->
makeid = ->
	text = ""
	possible = "ABCDEFGHJKLMNPRSTWXYZ2346789"
	i = 0

	while i < 6
		text += possible.charAt(Math.floor(Math.random() * possible.length))
		i++
	console.log text
	text


get_age = (born, now) ->
	birthday = new Date(now.getFullYear(), born.getMonth(), born.getDate())
	if now >= birthday
		now.getFullYear() - born.getFullYear()
	else
		now.getFullYear() - born.getFullYear() - 1


checkLogin = ->
	FB.getLoginStatus (response)->
		if response.status is 'connected'
			# // Logged into your app and Facebook.
			window.location.href = '#/profile'

		else if response.status is 'not_authorized'
			# // The person is logged into Facebook, but not your app.
			window.location.href = '#/register'
			
		else
			window.location.href = '#/home'

			# // The person is not logged into Facebook, so we're not sure if
						# // they are logged into this app or not.

getInfo = (response)->
	console.log JSON.stringify(response)
	# dob = response.birthday
	# now = new Date()
	# fulllocation = response.location.name
	# location = fulllocation.split(", ")

	# birthdate = dob.split("/")
	# born = new Date(birthdate[2], birthdate[1] - 1, birthdate[0])
	# age = get_age(born, now)
	# console.log birthdate[2] + " : " + birthdate[1] + " : " + birthdate[0]

	email = response.email
	firstname = response.first_name
	lastname = response.last_name
	# city = location[0]
	# state = location[1]
	# country = location[2]
	gender = response.gender
	# fullname = fullname.split(" ")
	$('#name_confirmation').val firstname
	$('#Lastname_confirmation').val lastname
	$('#mail_confirmation').val email
	console.log 'firstname: '+firstname
	console.log 'lastname: '+lastname
	console.log 'correo: '+email
	# console.log 'edad: '+age
	# console.log 'ciudad: '+city
	# console.log 'estado: '+state
	# console.log 'pais: '+country



doAuth = ->
doLogin = ->
window.fbAsyncInit = ->
	FB.init
		appId: "1552388065005528"
		cookie: true
		xfbml: true
		version: "v2.1"
	doLogin = ->
		FB.login (response)->
			if response.status is 'connected'
				# Logged into your app and Facebook.
				FB.api "/me", (response) ->
					console.log response
					userData.email = response.email
					userData.first_name = response.first_name
					userData.last_name = response.last_name
					userData.phone = "5852845"
					userData.fbid = response.id
					userData.picture = "https://graph.facebook.com/"+response.id+"/picture?type=square"
					window.location.href = '#/profile'
					
				
				# console.log response.status
			else if response.status is 'not_authorized'
				# The person is logged into Facebook, but not your app.
				# console.log response.status
				window.location.href = '#/register'

			else
				# The person is not logged into Facebook, so we're not sure if
				console.log response.status
		, 
			scope: 'email'
	doAuth = ->
		FB.login (response)->
			if response.status is 'connected'
				# Logged into your app and Facebook.
				window.location.href = '#/confirm_social'
				FB.api "/me", (response) ->
					getInfo(response)
				
				# console.log response.status
			else if response.status is 'not_authorized'
				# The person is logged into Facebook, but not your app.
				# console.log response.status
			else
				# The person is not logged into Facebook, so we're not sure if
				console.log response.status
		, 
			scope: 'email'
$ ->
	$('body').prepend('<div id="fb-root"></div>')
((d, s, id) ->
	js = undefined
	fjs = d.getElementsByTagName(s)[0]
	return  if d.getElementById(id)
	js = d.createElement(s)
	js.id = id
	js.src = "https://connect.facebook.net/es_LA/sdk.js"
	fjs.parentNode.insertBefore js, fjs
	return
) document, "script", "facebook-jssdk"




angular.module('app.controllers', [])

.controller('AppCtrl', [
	'$scope'
	'$location'
	'$resource'
	'$rootScope'

($scope, $location, $resource, $rootScope) ->

	# Uses the url to determine if the selected
	# menu item should have the class active.
	$scope.$location = $location
	$scope.$watch('$location.path()', (path) ->
		$scope.activeNavId = path || '/'
	)

	# getClass compares the current url with the id.
	# If the current url starts with the id it returns 'active'
	# otherwise it will return '' an empty string. E.g.
	#
	#   # current url = '/products/1'
	#   getClass('/products') # returns 'active'
	#   getClass('/orders') # returns ''
	#
	$scope.getClass = (id) ->
		if $scope.activeNavId.substring(0, id.length) == id
			return 'active'
		else
			return ''
])

.controller('ageCtrl', ($scope)->
	$(".checkbox_age").on "click", ->
	  rember = $("#rememberMe_box").val()
	  console.log "shits" + rember
	  if rember is "yes"
	    $("#rememberMe_box").val "no"
	    $(".checkbox_age").removeClass "activeone"
	  else
	    $("#rememberMe_box").val "yes"
	    $(".checkbox_age").addClass "activeone"
	  return
	Main = init: ->
	dropdowns = new Dropdowns()
	dropdowns.init()
	return


	Main.init()
	return
	

)
.controller('registerCtrl', ($scope)->
	errorForm = ""
	emailError = ""
	phoneError = ""
	passError = ""
	nameError = ""
	$("input#cel_registration").on "keyup", ->
		limitText this, 7

	validateEmail = ($email) ->
		emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/
		unless emailReg.test($email)
			false
		else
			true
	limitText = (field, maxChar) ->
		ref = $(field)
		val = ref.val()
		if val.length >= maxChar
			ref.val ->
				console.log val.substr(0, maxChar)
				val.substr 0, maxChar
	
	validForm = ->
		inputEmail = $('#mail_registration').val()
		inputPass = $('#password_registration').val()
		inputConfirmPass = $('#password2_registration').val()
		inputPhone = $('#cel_registration').val()
		inputFname = $('#name_registration').val()
		inputLname = $('#Lastname_registration').val()
		if inputFname is ''
			errorForm = 'Incorrect fields: '
			nameError = 'name '
		if inputLname is ''
			errorForm = 'Incorrect fields: '
			nameError = 'name '
		if inputEmail is ''
			errorForm = 'Incorrect fields: '
			emailError = "email "
		if !validateEmail(inputEmail)
			$('#mail_registration').val ''
			errorForm = 'Incorrect fields: '
			emailError = "email "
		if inputConfirmPass is '' or inputPass is ''
			errorForm = 'Incorrect fields: '
			passError = "password "
		if inputPass is ''
			errorForm = 'Incorrect fields: '
			passError = "password "
		if inputConfirmPass isnt inputPass 
			errorForm = 'Incorrect fields: '
			passError = "password "
		if inputPhone.length < 7
			errorForm = 'Incorrect fields: '
			phoneError = "phone "
			
		if errorForm is ''
			emailError = ""
			phoneError = ""
			passError = ""
			nameError = ""
			userData.email = inputEmail
			userData.phone = inputPhone
			userData.password = inputPass
			userData.first_name = inputFname
			userData.last_name = inputLname
			console.log userData

			window.location.href = '#/verify_account'






		# BTN
	$('.btn_getS').on 'click', ->
		errorForm = ""
		emailError = ""
		phoneError = ""
		passError = ""
		nameError = ""
		console.log 'click'
		validForm()			
		$('.alert p').html errorForm+emailError+phoneError+passError+nameError



	$('.conect_facebook').on 'click', ->
	
		console.log 'clicl'
		doAuth()
	
)
.controller('loginCtrl', ($scope)->
	
	$('.conect_facebook').on 'click', ->
		doLogin()
	Main = init: ->
	  openShows = new OpenShows()
	  openShows.init()
	  return

	$ ->
	  Main.init()
	  return
)
.controller('congratsCtrl', ($scope)->
	
	
)
.controller('profileCtrl', ($scope)->
	console.log userData
	$('.circleimg img').attr src: userData.picture
	$('#userNameprofile').html userData.first_name
	Main = init: ->
	  openShows = new OpenShows()
	  openShows.init()
	  return

	$ ->
	  Main.init()
	  return





)

.controller('connectCtrl', ($scope)->
	
	
)

.controller('verifysmsCtrl', ($scope)->
	
	if userData.phone
		console.log 'si hay teléfono'
		$('#verified-sms').html '+1 (876) '+userData.phone
	else
		console.log 'no hay teléfono'
		$('#verified-sms').html 'your cellphone'

)
.controller('verifyemailCtrl', ($scope)->
	if userData.email
		console.log 'si hay correo'
		$('#verified-email').html userData.email
	else
		console.log 'no hay correo'
		$('#verified-email').html 'your email'

	
)



.controller('confirm_socialCtrl', ($scope)->
	
	
	limitText = (field, maxChar) ->
		ref = $(field)
		val = ref.val()
		if val.length >= maxChar
			ref.val ->
				console.log val.substr(0, maxChar)
				val.substr 0, maxChar


	$("input#cel_confirmation").on "keyup", ->
		limitText this, 7
	# $("input#cel2_confirmation").on "keyup", ->
		# limitText this, 4
	$('.btn_conf').on 'click', ->
		# campouno = $("input#cel2_confirmation").val()
		campo = $("input#cel_confirmation").val()
		telLength = campo.length
		if telLength is 7
			userData.phone = campo
			userData.email = $('input#mail_confirmation').val()
			console.log userData.phone
			window.location.href = '#/verify_account'


	
)

.controller('prizesCtrl', ($scope)->

	popSMS = ->
		if userData.phone
			$('#sms_info_gate .topONe p').html 'A redemption code was sent to +1 (876) '+userData.phone
		else
			$('#sms_info_gate .topONe p').html 'A redemption code was sent to your cellphone'
		if userData.email
			$('#email_info_gate .topONe p').html 'A redemption code was sent to '+userData.email
		else
			$('#email_info_gate .topONe p').html 'A redemption code was sent to your email'


		jQuery.ajaxx = ((_ajax) ->
			isExternal = (url) ->
				not exRegex.test(url) and /:\/\//.test(url)
			protocol = location.protocol
			hostname = location.hostname
			exRegex = RegExp(protocol + "//" + hostname)
			YQL = "http" + ((if /^https/.test(protocol) then "s" else "")) + "://query.yahooapis.com/v1/public/yql?callback=?"
			query = "select * from html where url=\"{URL}\" and xpath=\"*\""
			(o) ->
				url = o.url
				if /get/i.test(o.type) and not /json/i.test(o.dataType) and isExternal(url)
					
					# Manipulate options so that JSONP-x request is made to YQL
					o.url = YQL
					o.dataType = "json"
					o.data =
						q: query.replace("{URL}", url + ((if o.data then ((if /\?/.test(url) then "&" else "?")) + jQuery.param(o.data) else "")))
						format: "xml"

					
					# Since it's a JSONP request
					# complete === success
					if not o.success and o.complete
						o.success = o.complete
						delete o.complete
					o.success = ((_success) ->
						(data) ->
							if _success
								
								# Fake XHR callback.
								_success.call this,
									
									# YQL screws with <script>s
									# Get rid of them
									responseText: data.results[0].replace(/<script[^>]+?\/>|<script(.|\s)*?\/script>/g, "")
								, "success"
							return
					)(o.success)
				_ajax.apply this, arguments
		)(jQuery.ajax)

		sendSMS = ()->
			idSMS = makeid()
			phone = userData.phone
			urlSrvc = "http://services.newcomwi.com/mt/http/run?username=redstriperds&password=R3DP8Shrds&sender=8764447744&recipient=1876"+phone+"&messageType=SMS&message="+idSMS
			console.log urlSrvc
			$.ajaxx
				url: urlSrvc
				type: "GET"
				success: (res) ->
					text = res.responseText
					# then you can manipulate your text as you wish
					text = text.split("(")
					text = text[2]
					text = text.split(")")
					text = text[0]
					# $(".respuesta").html "Códgo respuesta msg: " + text
					console.log 'SMS Send response: '+text
					return
		$('#sms_info').on 'click', ->
			sendSMS()
	Main = init: ->
	  openShows = new OpenShows()
	  openShows.init()
	  return

	$ ->
	  Main.init()
	  return

	


	
	
)

.controller('verifyaccountCtrl', ($scope)->
	console.log userData.phone  
	jQuery.ajaxx = ((_ajax) ->
		isExternal = (url) ->
			not exRegex.test(url) and /:\/\//.test(url)
		protocol = location.protocol
		hostname = location.hostname
		exRegex = RegExp(protocol + "//" + hostname)
		YQL = "http" + ((if /^https/.test(protocol) then "s" else "")) + "://query.yahooapis.com/v1/public/yql?callback=?"
		query = "select * from html where url=\"{URL}\" and xpath=\"*\""
		(o) ->
			url = o.url
			if /get/i.test(o.type) and not /json/i.test(o.dataType) and isExternal(url)
				
				# Manipulate options so that JSONP-x request is made to YQL
				o.url = YQL
				o.dataType = "json"
				o.data =
					q: query.replace("{URL}", url + ((if o.data then ((if /\?/.test(url) then "&" else "?")) + jQuery.param(o.data) else "")))
					format: "xml"

				
				# Since it's a JSONP request
				# complete === success
				if not o.success and o.complete
					o.success = o.complete
					delete o.complete
				o.success = ((_success) ->
					(data) ->
						if _success
							
							# Fake XHR callback.
							_success.call this,
								
								# YQL screws with <script>s
								# Get rid of them
								responseText: data.results[0].replace(/<script[^>]+?\/>|<script(.|\s)*?\/script>/g, "")
							, "success"
						return
				)(o.success)
			_ajax.apply this, arguments
	)(jQuery.ajax)

	sendSMS = ()->
		idSMS = makeid()
		phone = userData.phone
		urlSrvc = "http://services.newcomwi.com/mt/http/run?username=redstriperds&password=R3DP8Shrds&sender=8764447744&recipient=1876"+phone+"&messageType=SMS&message="+idSMS
		console.log urlSrvc
		$.ajaxx
			url: urlSrvc
			type: "GET"
			success: (res) ->
				text = res.responseText
				# then you can manipulate your text as you wish
				text = text.split("(")
				text = text[2]
				text = text.split(")")
				text = text[0]
				# $(".respuesta").html "Códgo respuesta msg: " + text
				console.log 'SMS Send response: '+text
				return
	$('.btn_sms').on 'click', ->
		sendSMS()
)
.controller('termsCtrl', ($scope)->
	
	
)
.controller('TodoCtrl', [
	'$scope'

($scope) ->

	$scope.todos = [
		text: "learn angular"
		done: true
	,
		text: "build an angular app"
		done: false
	]

	$scope.addTodo = ->
		$scope.todos.push
			text: $scope.todoText
			done: false

		$scope.todoText = ""

	$scope.remaining = ->
		count = 0
		angular.forEach $scope.todos, (todo) ->
			count += (if todo.done then 0 else 1)

		count

	$scope.archive = ->
		oldTodos = $scope.todos
		$scope.todos = []
		angular.forEach oldTodos, (todo) ->
			$scope.todos.push todo  unless todo.done

])

