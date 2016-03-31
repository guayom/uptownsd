module GameLinesHelper
  def with_sign(number)
    if number.to_i >= 0
      "+#{number}"
    else
      number.to_s
    end
  end
end
