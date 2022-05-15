require_relative "card.rb"
require_relative "hand.rb"
require_relative "deck.rb"

d = Deck.new
h = Hand.new

    h.cards_in_hand = d.dealer_deck.sample(7)

    f = Array.new(9, "") #VERY POOR NAMING, not same as above
    h.cards_in_hand.each do |card|
        f[0] += "┌─────────┐ "
        f[1] += "│#{card.type_s.ljust(2)}       │ "  # use two {} one for char, one for space or char
        f[2] += "│         │ "
        f[3] += "│         │ "
        f[4] += "│    #{card.suit_s}    │ "
        f[5] += "│         │ "
        f[6] += "│         │ "
        f[7] += "│       #{card.type_s.rjust(2)}│ "
        f[8] += "└─────────┘ "
    end
        
    (0..8).each do |line|
        puts f[line]
    end

    best_five, ranking, score = h.best_five

    bruh = Array.new(9, "")
    best_five.each do |card|
        bruh[0] += "┌─────────┐ "
        bruh[1] += "│#{card.type_s.ljust(2)}       │ "  # use two {} one for char, one for space or char
        bruh[2] += "│         │ "
        bruh[3] += "│         │ "
        bruh[4] += "│    #{card.suit_s}    │ "
        bruh[5] += "│         │ "
        bruh[6] += "│         │ "
        bruh[7] += "│       #{card.type_s.rjust(2)}│ "
        bruh[8] += "└─────────┘ "
    end

    p "Best Five Cards with a ranking of #{ranking} and tiebreaker score of #{score}"

    (0..8).each do |line|
        puts bruh[line]
    end

# end
