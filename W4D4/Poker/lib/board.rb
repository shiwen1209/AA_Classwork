require_relative "card.rb"
require_relative "player.rb"
require_relative "hand.rb"
require_relative "deck.rb"

class Board 

    # 1 move: 1 player move
    # 1 turn: 1 circle of activities around the table
    # 1 round: completion of a flop
    # when does a turn end
        # everyone but one person folds
        # more than two people stick to the end reveal cards at showdown
    attr_accessor :flop, :big_blind_index, :start_bet, :minumum_bet, :count, :players
    attr_reader :num_players, :deck, :main_pot
    def initalize(num_players)
        @flop = []
        @num_players = num_players
        #PLAYERS NEEDS REFACTORING INTO GAME SO THEY CAN HAVE NAMES
        @players = []
        # (0...num_players).each do 
        #     @players << Player.new(self)
        # end 
        @deck = Deck.new
        @big_blind_index = -1
        # @current_player_index = 1
        @start_bet = 20 # keeps track of minimum start bet for the blind
        @minimum_bet = @start_bet # keeps track of minimum bet player needs to match in order to stay in the game
        @main_pot = 0 #keeps track of of size of the pot in a round
        # @side_pots = [] #used when more than 1 person goes all in and their all-ins are different
        @player_bets = [] #keeps track of each player's bet in each turn
        @count = 0  #keep tracker of player actions
    end

    def active_players # players who has not folded
        @players.select {|player| player.active}
    end

    def betting_players # players who has not folded and has not gone all in
        @players.select {|player| player.active && !player.all_in}
    end

    def play_round
        # 0. reset for the new game
        main_pot = 0
        @big_blind_index += (@big_blind_index + 1) % @num_players
        @players.each do |player| 
            player.reset
        end
        @players[@big_blind_index].big_blind  = true
        @minimum_bet = @start_bet
        # 1. dealer draws cards for the round
        reserve_cards = @deck.deal(@num_players)

        
        # 2. pre-flop
        deal_players(reserve_cards)
        play_preflop_turn
        
        #reset player's current bet and minimum bet for post flop
        @betting_players.each {|player| player.current_bet = 0}
        @minimum_bet = 0

        # 3. post-flop
        while @active_players.length > 1 || @flop.length < 5
            deal_flop(reserve_cards)
            play_postflop_turn
            #reset player's current bet and minimum bet for post flop
            @betting_players.each {|player| player.current_bet = 0}
            @minimum_bet = 0
        end

        # 4. divide winnings and reveal cards
        if @active_players.length == 1
            @active_players[0].chips += main_pot  # the person who didn't fold gets the pot
        else
            # reveal cards if more than two players reach the last round 
            reveal_cards  #the winning person gets the pot
        end
    end

    def deal_players(cards)
        @players.each do |player|
            player.cards_in_hand << cards.pop
            player.cards_in_hand << cards.pop
        end
    end

    def deal_flop(cards)
        @flop << cards.pop
    end

    def play_preflop_turn
        i = (big_blind_index + 1) % @num_players
        @count = 0  #count reset to 0
        unless count == betting_players.length && betting_players.all? {|player| player.current_bet == @minumum_bet}
            if @player[i].big_blind == true
                @player[i].blind_move
            else
                @players[i].get_move
            end 
            i = (i+1) % @num_players
        end

    end

    def play_postflop_turn
        #deal a card to the flop
        @count = 0  #count reset to 0
    end




        #count increase by 1 when player take a move
        #count reset to 0 when a player raise



        end 

        #minium_bet turns 0 after each turn post flop
        #all players@current_bet turns 0 after completion of each turn



        #if someone went all in, if the person_wins, they only win based on what they put in,
        #the remaining pot goes back to the other players
        
        
    end



    def reveal_cards
        best_score = nil
        best_player = nil #may need something like minheap to handle ties/2nd vs 3rd place etc
        
        @players.each do |player|
            if player.active
            
                p_hand, p_score = player.hand.best_five

                #Handle scoring.. below may need readjusting for side pot BS
                if !best_score || p_score > best_score
                    best_player = player
                    best_score = p_score
                end
            else
                Card.print_empty_cards
                puts "test".center(23)
            end
        end


        divide_winnings

    end

    def divide_winnings

    end


end