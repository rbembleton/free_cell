require 'colorize'
require_relative "card"
require_relative "nullcard"
require_relative "board"
require_relative "deck"
require 'byebug'


class Game

  def initialize
    @deck = Deck.new
    @board = Board.new
    deal
  end

  def run
    until won?
      turn
    end
    display
    puts "YOU WON!"
  end

  def turn
    display

    this_move = nil
    until valid_move?(this_move)
      this_move = get_input
      return if this_move == "auto"
    end

    @board.make_move(this_move)

  end

  def display
    system('clear')
    @board.render

  end

  def deal
    @board.place_cards(@deck)
  end

  def get_input
    begin
      puts "What pile would you like to take a card off of?"
      from_p = parse_entry(gets.chomp)
      return "auto" if from_p == "auto"
    rescue StandardError => e
      puts e.message
      retry
    end

    begin
      puts "Where would you like to move that card?"
      to_p = parse_entry(gets.chomp)
      return "auto" if to_p == "auto"
    rescue StandardError => e
      puts e.message
      retry
    end

    [from_p, to_p]

  end

  def parse_entry(str)
    if str.downcase == "auto" || str.downcase == "autocomplete"
      @board.attempt_autocomplete
      return "auto"
    end

    if ('0'..'7').to_a.include?(str)
      str.to_i
    elsif ('A'..'H').to_a.include?(str.upcase)
      str.upcase
    else
      raise "Not a valid pile. Try again."
    end
  end

  def valid_move?(a_move)
    return false unless a_move.is_a?(Array) && a_move.length == 2
    @board.check_move?(a_move)
  end

  def won?
    @board.piles.flatten.size == 56
  end



end


if __FILE__ == $PROGRAM_NAME

  mygame = Game.new
  mygame.run
end
