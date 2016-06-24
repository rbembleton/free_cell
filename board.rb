class Board


  def initialize
    @stacks = Array.new(8) { Array.new }
    @holds = Array.new(4)
    @piles = Array.new(4)
  end

  def place_cards(deck)
    deck.shuffle
    until deck.empty?
      0.upto(7) do |col|
        @stacks[col] << deck.pop
        return if deck.empty?
      end
    end

  end

  def render

    piles_bottom = {
      0 => " ♣︎ ",
      1 => " ⬥ ".colorize(:red),
      2 => " ♠ ",
      3 => " ♥︎ ".colorize(:red)
    }

    rend_out = ""
    rend_out += " #{"/-\\"*4 + " "*8 + "/-\\"*4}\n "

    @holds.each do |hold_card|
      if hold_card
        to_add = hold_card.to_s
      else
        to_add = "---"
      end
      rend_out += to_add
    end
    rend_out += "        "

    @piles.each_with_index do |pile_card, i|
      if pile_card
        to_add = pile_card.to_s
      else
        to_add = piles_bottom[i]
      end
      rend_out += to_add
    end

    rend_out += "\n #{"\\-/"*4 + " "*8 + "\\-/"*4}\n\n"

    rend_out += "   0   1   2   3   4   5   6   7\n"
    rend_out += "#{"-"*34}\n"


    0.upto(12) do |row|
      rend_out += " "
      0.upto(7) do |col|
        if @stacks[col][row]
          to_add = @stacks[col][row].to_s
        else
          to_add = "   "
        end
        rend_out += to_add.to_s + " "
      end
      rend_out += "\n"
    end

    puts rend_out
  end



end
