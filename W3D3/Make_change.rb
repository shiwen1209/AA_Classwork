require "byebug"

def greedy_make_change(amount, coins = [25,10,5,1])
    # debugger
    return [] if amount == 0 
    new_coin = 0
    coins.each do |coin|
        if coin <= amount
            new_coin = coin 
            break
        end
    end
    residual = amount - new_coin
    return [new_coin] + greedy_make_change((residual))
end

p greedy_make_change(14)