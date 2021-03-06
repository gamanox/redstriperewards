Dropdowns = ->
  @settings =
    btn_drop: $(".boxIp")
    dp_days: $("#holD")
    dp_years: $("#holdY")
    dp_months: $("#holM")
    boxIp: $(".mainselector")
    day_input: $(".day_check")
    month_input: $(".month_check")
    year_input: $(".year_check")
    btn_submit: $(".btsumit")
    gate: $(".hold_ageGate")
    confirm: $(".holdConfirmation")
    sorry: $(".sorry_hold")
    btn_back: $(".btn_back")

  @tlOpen = new TimelineLite()
  @tlClose = new TimelineLite()
  return

Dropdowns::init = ->
  self = this
  self.bind()
  return

Dropdowns::bind = ->
  self = this
  s = self.settings
  $("#year_gate").val('2014')
  s.boxIp.on "click", ->
    elId = $(this).attr("id")
    howM = $(this).attr("data-howInside")
    alto = howM * 30
    self.animation "close"
    setTimeout (->
      self.animation "open", elId, alto
      return
    ), 270
    return

  self.create()
  s.dp_days.on "click", ".indeOnes", ->
    wich = $(this).attr("data-info")
    este = s.dp_days.find(".mainselector")
    este.html "<p>" + wich + "</p>"
    self.animation "close"
    s.day_input.val wich
    return

  s.dp_months.on "click", ".indeOnes", ->
    wich = $(this).attr("data-info")
    wich2 = $(this).attr("data-nummth")
    este3 = s.dp_months.find(".mainselector")
    este3.html "<p>" + wich + "</p>"
    self.animation "close"
    s.month_input.val wich2
    return

  s.dp_years.on "click", ".indeOnes", ->
    wich = $(this).attr("data-info")
    este2 = s.dp_years.find(".mainselector")
    este2.html "<p>" + wich + "</p>"
    self.animation "close"
    s.year_input.val wich
    return

  s.btn_submit.on "click", ->
    hoy = new Date().getFullYear()
    edad = hoy - 18

    chose = $("#year_gate").val()
    console.log edad + "fff " + chose
    if chose <= edad
      console.log "its old"
      s.gate.css "display", "none"
      # s.confirm.css "display", "block"
      window.location.href = '#/home'
    else
      console.log "its not old"
      s.gate.css "display", "none"
      s.sorry.css "display", "block"
    return

  s.btn_back.on "click", ->
    s.gate.css "display", "block"
    s.sorry.css "display", "none"
    s.confirm.css "display", "none"
    return

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

  return


Dropdowns::animation = (animation, elId, alto) ->
  self = this
  s = self.settings
  switch animation
    when "open"
      self.tlOpen.to $("#" + elId + "-in"), 0.75,
        height: alto
        ease: Cubic.easeOut
        onComplete: ->
          $("#" + elId + "-in").css "overflow-y", "scroll"
          return

    when "close"
      $("#" + elId + "-in").css "overflow-y", "hidden"
      self.tlOpen.to $(".holdDrops"), 0.25,
        height: 0
        ease: Cubic.easeOut

  return

Dropdowns::create = ->
  $("#hoDays-in").html " "
  i = undefined
  y = undefined
  mths = [
    "January"
    "February"
    "March"
    "April"
    "May"
    "June"
    "July"
    "August"
    "September"
    "October"
    "November"
    "December"
  ]
  i = 1

  while i <= 31
    cadena = "<div data-info=\"" + i + "\" class=\"indeOnes\"><p>" + i + "</p> </div>"
    $("#hoDays-in").append cadena
    i++
  years = new Date().getFullYear()
  year_starts = years - 17
  year_finish = years - 110
  y = years

  while y >= year_finish
    cadena = "<div data-info=\"" + y + "\" class=\"indeOnes\"><p>" + y + "</p> </div>"
    $("#hoYears-in").append cadena
    y--
  l = 0

  while l < mths.length
    cadena = "<div data-info=\"" + mths[l] + "\" data-nummth=\"" + l + "\" class=\"indeOnes\"><p>" + mths[l] + "</p> </div>"
    $("#hoMonths-in").append cadena
    l++
  return