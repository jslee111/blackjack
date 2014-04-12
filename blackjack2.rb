## Procedural Blackjack game


## creating deck 
## I am using 6 decks of cards (6 X 52 = 312 cards) to prevent the card counting.. 

card_number =['A','2','3','4','5','6','7','8','9','10','J','Q','K']
card_suit =['Spade','Heart','Diamond','Club'] 

## card shuffling 
deck = (card_suit.product(card_number)*6).shuffle!

## Getting the player's name 

puts "Enter your name"
player_name = gets.chomp
puts "Hey~#{player_name} Let's start a blackjack game" 

## Deal cards
dealer_hand =[]
player_hand =[]

2.times do 
	player_hand << deck.pop
	dealer_hand << deck.pop
end
	##dealer_hand =[["Spade","K"   ],["Heart" ,"A" ]]

## card_total calculation 
def calculate_total hand
	total=0
	array = hand.map {|e| e[1]}
	array.each do |card|
		## face card 
		if card == "10" || card =="J" || card =="K" || card =="Q"
			total +=10
		## Ace card	
		elsif card =="A"
			total += 11
		else 
			total += card.to_i
		end
	end
	hand.collect {|e| e[1]}.each do |card|
		if total >21 && card == "A"
			total -= 10
		end
	end

	return total 
end


dealer_total= calculate_total (dealer_hand)
player_total= calculate_total (player_hand)

puts "Dealer\'s card: #{dealer_hand[0]} and #{dealer_hand[1]} with a total of #{dealer_total}"
puts "#{player_name}\'s card: #{player_hand[0]} and #{player_hand[1]} with a total of #{player_total}"

# Check for Dealer's blackjack

dealer_flag=0
dealer_array= dealer_hand.map {|e| e[1]}

if dealer_array.include? "A"
	if dealer_array.include? "10"
		puts "Dealer has a blackjack"
		dealer_flag=1
	elsif dealer_array.include? "J"
		puts "Dealer has a blackjack"
		dealer_flag=1
	elsif dealer_array.include? "Q"
		puts "Dealer has a blackjack"
		dealer_flag=1
	elsif dealer_array.include? "K"	
		puts "Dealer has a blackjack"
		dealer_flag=1
	end
end

# Player's blackjack
player_flag=0
player_array= player_hand.map {|e| e[1]}

if player_array.include? "A"
	if player_array.include? "10"
		puts "#{player_name} has a blackjack"
		player_flag =1
	elsif player_array.include? "J"
		puts "#{player_name} has a blackjack"
		player_flag =1
	elsif player_array.include? "Q"
		puts "#{player_name}  has a blackjack"
		player_flag =1
	elsif player_array.include? "K"	
		puts "#{player_name}  has a blackjack"
		player_flag =1
	end
end


## Printing the Result in case of either the dealer or the player gets blackjack

if (dealer_flag ==1 && player_flag ==1)
	puts "The result is PUSH (It means a TIE in a Blackjack Game)"
	exit
elsif (dealer_flag ==1 && player_flag==0) 

	puts "Sorry. #{player_name} LOSES, The Dealer Wins "
	exit
	
elsif (player_flag==1 && dealer_flag ==0)
	
	puts "Congratulations! #{player_name} WINS"
	exit
end

##Player: Hit or Stay

while player_total <21
	input =[]
	puts "Would you like to hit or stay? (Please press 1 for hit and 2 for stay)"
  	input = gets.chomp

  	if input =="1"
  	new_card1 = deck.pop
  	puts "#{player_name}\'next card is #{new_card1}."
  	player_hand << new_card1		
  	player_total= calculate_total (player_hand)
  	puts "#{player_name}\'s new card total is now #{player_total}."

  		if player_total > 21
  			puts "#{player_name} Busted. #{player_name} Loses "
  			exit
  		end

  	else 
  		puts "You have decided to stay"
  		break
  	end
  end

##Dealer: Must Stay on 17. Dealer Must hit if it is less than 16
while dealer_total <17
	new_card2 = deck.pop
	puts "Dealer\'s next card is #{new_card2}."
  	dealer_hand << new_card2	
  	dealer_total= calculate_total (dealer_hand)
  	puts "Dealer\'s new card total is now #{dealer_total}"

  	if dealer_total > 21
  		puts "Dealer Busted #{player_name} WINS"
  		exit
  	end
end

## Final comparison of hands

if dealer_total == player_total 
	puts "The result is PUSH (It means a TIE in a Blackjack Game)"
	exit 
elsif dealer_total > player_total  
	puts "Sorry. #{player_name} LOSES, The Dealer Wins "
	exit
else 
	puts "Congratulations! #{player_name} WINS"
	exit
end











