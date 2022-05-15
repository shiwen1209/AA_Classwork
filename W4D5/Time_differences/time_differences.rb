def my_min1 (list)
    m = list.first
    (0...list.length).each do |i|
        
        (0...list.length-1).each do |j|
            if list[i] < list[j] && m >list[i]
                m = list[i]
            elsif list[j] < list[i] && m > list[j]
                m = list[j]
            end 
        end 

    end
    return m 
end
p list1 = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p my_min1(list1)


def my_min2 (list)
    m = list.first
    list.each do |ele|
        m = ele if ele < m 
    end
    return m
end

p my_min2(list1)

def largest_contigous1(arr)
    subs = []
  
    len = 1
    while len <= arr.length
        i = 0
        while i < arr.length - len + 1
            subs << arr[i, len] # length of subs is n ^ 2 but each ele is up to n # space to  n^3 
            i += 1
        end
        len += 1
    end

    max = subs.first.sum

    subs.each do |sub|
        if sub.sum > max
            max = sub.sum # n operation for every element of a n^2 length #making time n ^ 3
        end
    end

    return max

end

p largest_contigous1([5,3,-7])

def largest_contigous2(arr)
    largest_sum = arr.first
    current_sum = arr.first

    (1...arr.length).each do |i|
        current_sum = 0 if current_sum < 0
        current_sum = current_sum + arr[i]  
        largest_sum = current_sum if current_sum > largest_sum

    end
    largest_sum
end
p largest_contigous2([5,3,-7])
p largest_contigous2([2, 3, -6, 7, -6, 7])
p largest_contigous2([-5,-1,-3])

