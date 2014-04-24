## BlackJack OOP

class Card
  attr_accessor :suit, :value, :hide

  def initialize (s,v,h)
    @suit = s
    @value =v
    @hide = h
  end 

  def display 
    if hide == true 
      puts "card is hidden"
    else 
      puts "#{value} of #{suit} "
    end
  end

  def show
    hide == false
  end

end


class Deck
  attr_accessor :cards, :hide

  def initialize 
    @cards =[]
      ["Spade","Heart","Club","Diamond"].each do |s|
        ["A","2","3","4","5","6","7","8","9","10","J","Q","K"].each do |v|

        @cards << Card.new(s, v, hide)
        end
      end
      cards.shuffle!
  end 

    def deal_one
      cards.pop
    end 

end

module Display
  def display
    cards.each do |e|
    puts "#{e} with a total of #{sum}"
    end 
  end

  def add_card (new_card)
    cards << new_card
  end
end

module Compute
  def calculate 
    values=cards.map{|e| e.value}

    values.each do |e|
        if e == "A"
          sum +=11
        else 
          sum +=(e.to_i ==0 ? 10 : e.to_i)
        end
    end

    values.select {|e| e =="A"}.count.times do 
      break if sum <=21
      sum -=10
    end 
    sum
  end

end 

class Human

  include Display
  include Compute

  attr_accessor :name, :cards

  def initialize (set_name)
    @name = set_name
    @cards = []
  end

  def sum
    # calculate 
    sum=0
  end 

  display

end 

class Engine

  DEALER_STAY = 17
  BLACKJACK = 21
  BUST = 21

  attr_accessor :deck, :dealer, :player

  def initialize ()
    @deck = Deck.new
    @dealer= Human.new("Dealer")
    @player = Human.new("Player")
  end 

  def deal 
    2.times {
      player.new_card(deck.deal_one)
      dealer.new_card(deck.deal_one)
    }
  end 

  def blackjack? (flag)
    if flag.sum == BLACKJACK && flag==dealer
      puts ("Dealer wins with a Blackjack")
    elsif flag.sum == BLACKJACK && flag==player 
      puts ("Player wins with a Blackjack")
    end
  end

  def bust? (flag)
     if flag.sum > BUST && flag==dealer
      puts ("Dealer busted")
    elsif flag.sum > BUST && flag==player 
      puts ("Player busted")
    end

  end

  def player_turn
      blackjack?(player)
      bust?(player)

      new_card = deck.deal_one
      player.add_card(new_card)

      blackjack?(player)
      bust?(player)
  end

  def dealer_turn
      blackjack?(dealer)
      bust?(dealer)

      while (dealer.sum < DEALER_STAY)
        new_card = deck.deal_one
        dealer.add_card(new_card)
      
      blackjack?(dealer)
      bust?(dealer)
      end 
  end

  def winner
    if player.sum > dealer.sum
        puts "Player wins"
    elsif player.sum < dealer.sum
        puts "Dealer wins"
    else 
        puts "PUSH (Tie)"
    end 

  end

  def start 
    player_turn
    dealer_turn
    winner
  end 
end


  game = Engine.new
  game.start 



