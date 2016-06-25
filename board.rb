class Board

  attr_reader :holds, :piles, :stacks




  def initialize
    @stacks = Array.new(8) { Array.new }
    @holds = Array.new(4)
    @piles = Array.new(4) { Array.new }

    [:clubs,:diamonds,:spades,:hearts].each_with_index do |suit, idx|
      @piles[idx] << NullCard.new(nil, suit)
    end


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

  def check_move?(a_move)
    from_p, to_p = a_move
    from_c = nil

    if from_p.is_a?(Fixnum)
      return false if @stacks[from_p].empty?
      from_c = @stacks[from_p].last
    elsif ('A'..'D').to_a.include?(from_p)
      return false if input_conversion[from_p].nil?
      from_c = input_conversion[from_p]
    elsif ('E'..'H').to_a.include?(from_p)
      return false
    end

    if to_p.is_a?(Fixnum)
      return true if @stacks[to_p].empty?
      return false unless from_c.value + 1 == @stacks[to_p].last.value
      return false if from_c.color == @stacks[to_p].last.color
    elsif ('A'..'D').to_a.include?(to_p)
      return false unless input_conversion[to_p].nil?
    elsif ('E'..'H').to_a.include?(to_p)
      return false unless from_c.suit == input_conversion[to_p].last.suit
      return false unless from_c.value - 1 == input_conversion[to_p].last.value
    end

    true

  end

  def make_move(a_move)
    from_p, to_p = a_move
    from_c = nil

    if from_p.is_a?(Fixnum)
      from_c = @stacks[from_p].pop
    elsif ('A'..'D').to_a.include?(from_p)
      from_c = input_conversion[from_p]
      if from_p == 'A'
        @holds[0] = nil
      elsif from_p == 'B'
        @holds[1] = nil
      elsif from_p == 'C'
        @holds[2] = nil
      elsif from_p == 'D'
        @holds[3] = nil
      end
    end

    if to_p.is_a?(Fixnum)
      @stacks[to_p].push(from_c)
    elsif ('A'..'D').to_a.include?(to_p)
      if to_p == 'A'
        @holds[0] = from_c
      elsif to_p == 'B'
        @holds[1] = from_c
      elsif to_p == 'C'
        @holds[2] = from_c
      elsif to_p == 'D'
        @holds[3] = from_c
      end
      # input_conversion[to_p] = from_c
    elsif ('E'..'H').to_a.include?(to_p)
      input_conversion[to_p].push(from_c)
    end

  end

  def attempt_autocomplete
    no_more = false

    until no_more == true
      no_more = true

      0.upto(7) do |s_i|
        next if @stacks[s_i].empty?
        current_card = @stacks[s_i].last

        0.upto(3) do |p_i|
          if current_card.suit == @piles[p_i].last.suit &&
            current_card.value - 1 == @piles[p_i].last.value

            @piles[p_i].push(@stacks[s_i].pop)
            no_more = false
          end
        end

      end

      0.upto(3) do |h_i|
        next if @holds[h_i] == nil
        current_card = @holds[h_i]

        0.upto(3) do |p_i|
          if current_card.suit == @piles[p_i].last.suit &&
            current_card.value - 1 == @piles[p_i].last.value

            @piles[p_i].push(current_card)
            @holds[h_i] = nil
            no_more = false
          end
        end

      end

    end


  end



  def render

    # piles_bottom = {
    #   0 => " ♣︎ ",
    #   1 => " ⬥ ".colorize(:red),
    #   2 => " ♠ ",
    #   3 => " ♥︎ ".colorize(:red)
    # }

    rend_out = ""
    rend_out += "  A  B  C  D          E  F  G  H\n"
    rend_out += " #{"/-\\"*4 + " "*8 + "/-\\"*4}\n "

    @holds.each do |hold_card|
      if hold_card
        to_add = hold_card.to_s
      else
        to_add = " - "
      end
      rend_out += to_add
    end
    rend_out += "        "

    @piles.each_with_index do |pile, i|
      to_add = pile.last.to_s
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

  def input_conversion
    {
      'A' => holds[0],
      'B' => holds[1],
      'C' => holds[2],
      'D' => holds[3],
      'E' => piles[0],
      'F' => piles[1],
      'G' => piles[2],
      'H' => piles[3]
    }
  end



end
