class Card
  def self.build(suit, rank)
    new(suit: suit, rank: rank)
  end
  #private_class_method :new

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
      when :jack then 11
      when :queen then 12
      when :king then 13
      else rank
    end
  end

  def suit
    @suit
  end

  def rank
    @rank
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  def hash
    [rank, suit].hash
  end

  def eql?(other)
    self == other
  end

  def to_s
    id = if rank > 10
      {
        11 => "J",
        12 => "Q",
        13 => "K"
      }.fetch(rank)
    else
      rank.to_s
    end

    s = {
      hearts: "♡ ",
      spades: "♤ ",
      diamonds: "♢ ",
      clubs: "♧ ",
    }

    "#{id.upcase}#{s.fetch(suit)}"
  end
end

RSpec.describe 'a playing card' do
  it 'has a suit' do
    raise unless Card.new(suit: :spades, rank: 4).suit == :spades
  end
  it 'has a rank' do
    raise unless Card.new(suit: :spades, rank: 4).rank == 4
  end

  describe 'a jack' do
    it 'ranks higher than a 10' do
      lower = Card.new(suit: :spades, rank: 10)
      higher = Card.new(suit: :spades, rank: :jack)

      raise unless higher.rank > lower.rank
    end
  end

   describe 'a queen' do
    it 'ranks higher than a 10' do
      lower = Card.new(suit: :spades, rank: :jack)
      higher = Card.new(suit: :spades, rank: :queen)

      raise unless higher.rank > lower.rank
    end
  end

   describe 'a king' do
    it 'ranks higher than a 10' do
      lower = Card.new(suit: :spades, rank: :queen)
      higher = Card.new(suit: :spades, rank: :king)

      raise unless higher.rank > lower.rank
    end
  end
end
