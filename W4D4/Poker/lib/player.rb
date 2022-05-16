# require_relative "board.rb"
require_relative "hand.rb"

class Player 

    attr_reader :board, :name
    attr_accessor :hand, :chips, :big_blind, :current_bet, :all_in, :active

    def initialize(name, password, board, chips = 1000)
        @name = name
        @board = board 
        @password = password
        @hand = Hand.new(@board) # reset for each round 
        @chips =chips  
        @big_blind = false #reset for each round 
        @active = true #reset for each round
        @all_in = false # reset for each round 
        @current_bet = 0 #keeps track of current bet in a turn #reset for each turn
    end

    def reset
        @hand = Hand.new(@board)
        @big_blind = false
        @active = true
        @all_in = false
        @current_bet = 0
    end

    def get_move
        begin
            print "\33c\e[3J"
            puts "#{@name}, please enter your password"
            passw = gets.chomp

            if passw == @password

                f = Array.new(9, "") 
                hand.small_hand.each do |card|
                    cp = card.card_picture
                    (0..8).each do |i|
                        f[i] += cp[i]
                    end
                end

                f.each_with_index do |ele, i|
                    f[i] = ele + "│ "
                end

                @board.flop.each do |card|
                    cp = card.card_picture
                    (0..8).each do |i|
                        f[i] += cp[i]
                    end
                end
                    
                (0..8).each do |line|
                    puts f[line]
                end

                puts "#{name}'s Hand".center(23) + "The Flop".center(65)
                puts "Mainpot is #{@board.main_pot}"
                puts "Your have #{@chips} chips left"
                puts "Current minimum bet is #{@board.minimum_bet}"
                @board.players.each do |player|
                    puts "#{player.name}'s current bet: #{player.current_bet}"
                end
                puts "List of command are:\n 'fold',\n'check',\n 'call',\n 'bet num',\n'raiseto num',\n'allin'"
            
                puts "-"*10



            else
                raise StandardError.new("wrong password")
            end

        rescue StandardError=>e
            puts e
            retry
        end


        begin
            puts "#{@name}, please enter your command"
            player_input = gets.chomp.split
            move, num = player_input
            
            case move
            when "allin"
                self.go_all_in
            when "bet"
                raise StandardError.new("Must enter input with bet!") if num == nil
                num = num.to_i
                self.bet(num)
            when "call"
                self.call
            when "raiseto"
                raise StandardError.new("Must enter input with raiseto!") if num == nil
                num = num.to_i
                self.raiseto(num)
            when "fold"
                self.fold
            when "check"
                self.check
            when "exit"
                #add exiting the game
            else
                raise StandardError=> "Wrong command, please choose one of the valid commands"
            end
        rescue StandardError=>e 
            puts "Error Occurred: #{e}"
            puts "Please try again"
            retry
        end
    end 

    def check
        raise StandardError.new("you cannot check") if @current_bet < @board.minimum_bet
        @board.count += 1
    end

    def go_all_in
        #player stay active until the end 
        # player use all their chips 

        match_bet = @board.minimum_bet - @current_bet

        @board.main_pot += @chips  
        if @chips > match_bet
            @board.minimum_bet = @chips + @current_bet
            @board.count = 1
        else
            @board.count += 1
        end
        @current_bet += @chips
        @chips = 0  # need to revise base on other players
        @all_in = true  
    end

    def bet(num)
        p "bet"
        # only use this for post flop
        raise StandardError.new("you cannot use this action") if @board.players.any? {|player| player.current_bet > 0}
        raise StandardError.new("you have to bet at least # {@board.start_bet}") if num < @board.start_bet
        raise StandardError.new("you don't have enough money") if num >= chips
        @board.main_pot += num
        @current_bet += num
        @chips -= num
        @board.minimum_bet = num
        @board.count += 1
    end

    def raiseto(num)
        raise StandardError.new("did not enter a valid number to raise to") if num == nil
        bet = num - @current_bet
        raise StandardError.new("your bet is lower than the current bet of #{@board.minimum_bet}!") if bet < @board.minimum_bet #?
        raise StandardError.new("you dont have enough money") if bet >= @chips
        raise StandardError.new("you cannot raise") if @board.minimum_bet <= 0 
        @board.main_pot += bet
        @current_bet += bet
        @chips -= bet
        @board.minimum_bet = num
        @board.count = 1 # reset the board count to 1 when someone raises
    end

    def call
        bet = @board.minimum_bet - @current_bet
        raise StandardError.new("you dont have enough money") if bet >= @chips
        raise StandardError.new("you cannot call") if @current_bet == @board.minimum_bet
        @board.main_pot += bet
        @current_bet += bet
        @chips -= bet
        @board.count += 1
    end

    def fold
        # player become inactiv
        # player forego their hands
        self.active = false
        self.current_bet = 0
    end

    # def blind_move
    #     if @chips < @board.start_bet
    #         self.go_all_in
    #     else 
    #         @board.main_pot += @board.start_bet
    #         @current_bet += @board.start_bet
    #         @chips -= @board.start_bet
    #         get_move
    #     end
    # end

    private
    attr_accessor :password


end 