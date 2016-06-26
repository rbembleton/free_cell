class Deck

  def initialize
    @deck_arr = []
    new_deck
  end


  def new_deck
    [:hearts,:diamonds,:spades,:clubs].each do |suit|
      [:ace,:two,:three,:four,:five,:six,:seven,
        :eight,:nine,:ten,:jack,:queen,:king].each do |rank|
        @deck_arr << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    @deck_arr.shuffle!
  end

  def pop
    @deck_arr.pop
  end

  def empty?
    @deck_arr.empty?
  end

  def dup
    new_deck = @deck_arr.map do |card|
      copy_rank = card.rank
      copy_suit = card.suit
      Card.new(rank, suit)
    end
    d = Deck.new
    d.specific_shuffle(new_deck)
  end

  def self.specific_shuffle(deck)
    @deck_arr = deck
  end


end
