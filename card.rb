require 'colorize'

class Card
  attr_reader :rank, :suit

  VALUE_CONVERSION = {
    :ace => 1,
    :two => 2,
    :three => 3,
    :four => 4,
    :five => 5,
    :six => 6,
    :seven => 7,
    :eight => 8,
    :nine => 9,
    :ten => 10,
    :jack => 11,
    :queen => 12,
    :king => 13
  }

  STRING_CONVERSION = {
    :ace => " A",
    :two => " 2",
    :three => " 3",
    :four => " 4",
    :five => " 5",
    :six => " 6",
    :seven => " 7",
    :eight => " 8",
    :nine => " 9",
    :ten => "10",
    :jack => " J",
    :queen => " Q",
    :king => " K"
  }

  SUIT_CONVERSION = {
    :spades => "♠",
    :clubs => "♣︎",
    :hearts => "♥︎",
    :diamonds => "⬥"
  }



  def initialize(rank, suit)
    @rank, @suit = rank, suit
  end

  def value
    VALUE_CONVERSION[rank]
  end

  def to_s
    # debugger
    out_str = STRING_CONVERSION[@rank] + SUIT_CONVERSION[@suit]
    suit == :hearts || suit == :diamonds ? out_str.colorize(:red) : out_str
  end


end
