@initBets = ->
  updateBetWin = (id) ->
    bet = $('.bet-risk[data-bet="' + id + '"]')
    risk = parseFloat(bet.val())
    odds = parseFloat(bet.data('odds'))
    win = 0

    if odds > 0
      win = risk * (odds / 100.0)
    else
      win = risk / (-1 * odds / 100.0)

    totalPayout = win + risk

    $('.bet-win[data-bet="' + id + '"]').val(totalPayout.toFixed(2))

    $updateButton = $('.bet-update[data-bet="' + id + '"]')
    if parseFloat($updateButton.data('risk')) != risk
      $updateButton.show()
    else
      $updateButton.hide()

  $('.bet-risk').change ->
    updateBetWin $(this).data('bet')
  $('.bet-risk').keyup ->
    updateBetWin $(this).data('bet')

  $('.bet-risk').each ->
    updateBetWin $(this).data('bet')

$ ->
  initBets()

  $('.link_to_add_bet').click (e) ->
    gameLine = $(this).data('game-line')
    team = $(this).data('team')
    betDiv = ".add-bet[data-game-line=\"#{gameLine}\"][data-team=\"#{team}\"]"
    $(betDiv).show()
    $("#{betDiv} .bet-risk").focus()

    $(this).hide();

    e.preventDefault()

  $('.add-bet .event-remove').click (e) ->
    $(this).parents('.add-bet').hide()

    gameLine = $(this).parents('.add-bet').data('game-line')
    team = $(this).parents('.add-bet').data('team')
    betAddLink = ".link_to_add_bet[data-game-line=\"#{gameLine}\"][data-team=\"#{team}\"]"
    $(betAddLink).show()

    e.preventDefault()
