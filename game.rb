require 'colorize'
require_relative "card"
require_relative "board"
require_relative "deck"
require 'byebug'


class Game

  def initialize
    @deck = Deck.new
    @board = Board.new
    deal
  end

  def display
    @board.render

  end

  def deal
    @board.place_cards(@deck)
  end



end


if __FILE__ == $PROGRAM_NAME

  mygame = Game.new
  mygame.display
end
