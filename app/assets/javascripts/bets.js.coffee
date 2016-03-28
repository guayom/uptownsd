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

  $('.bet-risk').change ->
    updateBetWin $(this).data('bet')

  $('.bet-risk').each ->
    updateBetWin $(this).data('bet')

$ ->
  initBets()
