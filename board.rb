class Board


  def initialize
    @stacks = Array.new(8) { Array.new }
  end

  def place_cards(deck)
    deck.shuffle

    0.upto(7) do |col|
      @stacks[col] << deck.pop
      return if deck.empty?
    end

  end

  def render
    rend_out = ""
    0.upto(12) do |row|
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
