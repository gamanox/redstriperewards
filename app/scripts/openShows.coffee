OpenShows = ->
  @settings =
    btn_login_chage_option: $(".btn_login_chage_option")
    inputlog: $(".inputlog")
    newsletter_input: $("#newsletter-input")
    btn_newsLeter: $("#newsletter")
    info_priza: $("#info_prize")
    btn_confi_prizes: $(".sendConfi_prize")
    btn_prize: $(".prize-grid-item")
    close_elPopUP: $(".close_elPopUP")
    bnt_sumit: $(".btsumit")
    closePop_codes: $(".closePop_codes")
    open_popUp: $(".open_popUp")

  return

OpenShows::init = ->
  self = this
  self.bind()
  return

OpenShows::bind = ->
  self = this
  s = self.settings
  s.btn_login_chage_option.on "click", ->
    laId = $(this).attr("id")
    s.inputlog.removeClass "activeInput"
    $("#" + laId + "-input").addClass "activeInput"
    return

  s.btn_newsLeter.on "click", ->
    elId = $(this).attr("id")
    yesNo = s.newsletter_input.val()
    if yesNo is "yes"
      $("#" + elId).css "background-color": "rgba(255, 0, 10, 0.1)"
      s.newsletter_input.val "no"
      console.log "this is no"
    else
      $("#" + elId).css "background-color": "#ed1c24"
      s.newsletter_input.val "yes"
      console.log "this is yes"
    return

  $("#drop_logs").mouseenter ->
    $("#drop_logs-down").stop().animate
      height: 70
    , 250, "easeInOutQuad"
    return

  $("#drop_logs-down").mouseleave ->
    $("#drop_logs-down").stop().animate
      height: 0
    , 250, "easeInOutQuad"
    return

  
  # $('#prizesShow').on('click', function(){
  #   $('#prizes_gate').css({display:'block'});
  # });
  s.btn_confi_prizes.on "click", ->
    elId = $(this).attr("id")
    s.info_priza.css display: "none"
    $("#" + elId + "_gate").css display: "block"
    return

  s.btn_prize.on "click", ->
    $("#pop_up_go").css "display", "block"
    popSMS()
    return

  s.close_elPopUP.on "click", ->
    $("#pop_up_go").css "display", "none"
    $("#sms_info_gate").css "display", "none"
    $("#email_info_gate").css "display", "none"
    $("#cheers_salute").css "display", "none"
    $("#info_full_prize").css display: "block"
    s.info_priza.css display: "block"
    return

  s.bnt_sumit.on "click", ->
    $("#cheers_salute").css "display", "block"
    $("#info_full_prize").css display: "none"
    return

  s.open_popUp.on "click", ->
    console.log 'open'
    console.log 'this: '+$(this)
    cual = $(this).attr("id")
    $("#" + cual + "_popUp_gate").css "display", "block"
    $("#popUp_gate").css "display", "block"
    return

  s.closePop_codes.on "click", ->
    cual = $(this).attr("id")
    $("#" + cual + "_gate").css "display", "none"
    $("#popUp_gate").css "display", "none"
    return

  return

OpenShows::actions = (wich, all) ->
  self = this
  s = self.settings
  $("." + all).css display: "none"
  return