require_relative "player.rb"
require_relative "aiplayer.rb"

class Game 

    attr_reader :dictionary, :fragment
    def initialize(names)
        @players = []
        names.each do |name, computer|
            if computer
              @players<< AiPlayer.new(name)
            else
              @players<< Player.new(name)
            end
        end
        @fragment = ""
        @dictionary = Hash.new
        File.foreach("dictionary.txt") do |word|
            @dictionary[word.chomp] = word.chomp
        end 
        @num_losses = Hash.new(0)
        @current_player = @players[0]
    end

    def current_player
        @current_player = @players[0]
    end

    def previous_player
        @previous_player = @players[-1]
    end

    def next_player!
      @players.rotate!
      self.current_player
      self.previous_player
    end

    def take_turn(player)
      if player.class == Player
        entry = player.guess
        valid_play?(entry)
      else
        entry = player.guess(@fragment)
      end
      return entry
    end

    def valid_play?(str)
      alphabet = ('a'..'z').to_a
      raise "invalid move" if !alphabet.include?(str)
      word = @fragment + str
      @dictionary.each do |k, v|
        if k.include?(word)
          return true
        end
      end
      raise "invalid move"
    end

    def play_round
      str = self.take_turn(@current_player)
      if self.valid_play?(str)
        @fragment += str 
        puts @fragment
      end
      if @dictionary.has_key?(@fragment)
        self.losses
        self.record(@previous_player)
        @fragment = ""
      end
      self.next_player!
    end

    def losses
        @num_losses[@current_player] += 1
    end

    def record(player)
        str = "GHOST"
        num = @num_losses[player]
        return str[0...num]
    end 

    def run
      until @num_losses.has_value?(5)
        self.display_standings
        self.play_round
      end
    end

    def display_standings
      @num_losses.each do |k,v|
        puts "#{k.name}: #{self.record(k)}"
      end
    end

end 