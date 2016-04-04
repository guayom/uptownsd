@initBets = ->
  updateBetWin = (gameLine, team) ->
    attrs = '[data-game-line="' + gameLine + '"][data-team="' + team + '"]';
    bet = $(".bet-risk#{attrs}")
    risk = parseFloat(bet.val())
    odds = parseFloat(bet.data('odds'))
    win = 0

    if odds > 0
      win = risk * (odds / 100.0)
    else
      win = risk / (-1 * odds / 100.0)

    totalPayout = win + risk
    $(".bet-payout#{attrs}").val(totalPayout.toFixed(2))

    $addButton = $(".bet-add#{attrs}")
    if risk > 0
      $addButton.show()
    else
      $addButton.hide()

  $('.bet-risk').change ->
    updateBetWin $(this).data('game-line'), $(this).data('team')
  $('.bet-risk').keyup ->
    updateBetWin $(this).data('game-line'), $(this).data('team')

  $('.bet-risk').each ->
    updateBetWin $(this).data('game-line'), $(this).data('team')

@hideBetForm = (gameLine, team) ->
  attrs = '[data-game-line="' + gameLine + '"][data-team="' + team + '"]';
#  $(".add-bet#{attrs}").hide()
  $(".add-bet#{attrs}").slideUp()
  $(".link_to_add_bet#{attrs}").show()
  console.log('!')

$ ->
  initBets()

  $('.link_to_add_bet').click (e) ->
    gameLine = $(this).data('game-line')
    team = $(this).data('team')
    betDiv = ".add-bet[data-game-line=\"#{gameLine}\"][data-team=\"#{team}\"]"
#    $(betDiv).show()
    $(betDiv).slideDown()
    $("#{betDiv} .bet-risk").focus()

    $(this).hide();

    e.preventDefault()

  $('.add-bet .event-remove').click (e) ->
    gameLine = $(this).parents('.add-bet').data('game-line')
    team = $(this).parents('.add-bet').data('team')
    hideBetForm(gameLine, team)

    e.preventDefault()
