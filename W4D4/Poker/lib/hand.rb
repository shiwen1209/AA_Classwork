class Hand

    @attr_accessor :cards_in_hand
    def initialize(board) #ALWAYS PASS IN BOARD! nil is for debugging purposes
        @cards_in_hand = []
        @board = board
        
    end

    def small_hand #for players to see
        return @cards_in_hand
    end

    def big_hand #for use
        return small_hand + @board.flop
    end

    def add_cards(first_card, second_card) #for board to add 2 cards
        @cards_in_hand = [first_card, second_card]
    end

    def empty_hand!
        @cards_in_hand = []
    end

    def best_five
        #b = self.big_hand

        #DELETE BELOW
        b = small_hand + [Card.new(:seven, :hearts), Card.new(:queen, :hearts), Card.new(:nine, :hearts), Card.new(:king, :diamonds), Card.new(:eight, :clubs)]
        ######
        raise StandardError.new("Total Hand Size is not 7") if b.length != 7

        b.sort_by{ |c| c.value}
        

        #VALUES:
        #Single = 1
        #Pair = 2
        #Double Pair = 3
        #Triple = 4
        #STRAIGHT = 5
        #FLUSH = 6
        #full house... does not need container is 7
        #FOUR OF A KIND -> auto returns -> 8
        #STRAIGHT_FLUSH -> 9
        #ROYAL_FLUSH -> 10

        best = nil
        best_score = 0

        straight_counter = 1
        straight_flush_counter = 1
        duplicate_counter = 1

        suit_hash = Hash.new {|h,k| h[k] = []}
        suit_hash[b[0].suit] << 0 #INDICES!

        triples = []
        pairs = []
        (1..6).each do |i|
            #handle duplicates
            if (b[i-1].value == b[i].value)
                duplicate_counter += 1
            else
                case duplicate_counter
                    
                when 2
                    pairs << b[i-1].symbol
                when 3 
                    triples << b[i-1].symbol
                when 4
                    #Different in end case!!
                    best = b[i-4..i-1] #can't possibly have straight flush
                    best.append(b[-1])
                    best_score = 8
                    return best
                end
                duplicate_counter = 1
            end
            #handle straights
            if (b[i-1].value + 1 == b[i].value)
                straight_counter += 1
                if (b[i-1].suit == b[i].suit)
                    straight_flush_counter += 1
                else
                    straight_flush_counter = 1
                end
                if straight_counter >= 5
                    if straight_flush_counter >= 5 #always wins besides other straight flushes
                        best = b[i-4..i] #always replaces previous straight flush
                        if best[-1].symbol == :ace
                            best_score = 10
                            return best
                        else
                            best_score = 9
                        end
                    else
                        if best_score <= 5
                            best_score = 5
                            best = b[i-4..i]
                        end
                    end
                end
            else
                straight_counter = 1
            end
        end

        case duplicate_counter
        when 2
            pairs << b[6].symbol
        when 3 
            triples << b[6].symbol
        when 4
            #Different in end case!!
            best = b[2..6] #can't possibly have straight flush
            best_score = 8
            return best
        end

            #handle flushes
    end

    def five_score

    end






end