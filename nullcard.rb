class NullCard < Card

  def initialize(rank, suit)
    super(rank, suit)
    rank = nil
  end

  def to_s
    out_str = " " + SUIT_CONVERSION[@suit] + " "
    color == :red ? out_str.colorize(:red) : out_str
  end

  def value
    0
  end


end
