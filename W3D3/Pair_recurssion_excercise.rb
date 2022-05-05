
def permutations(arr)
    return [[]] if arr.length == 0
    new_arr = []
    shorter_arr = arr[0...-1]
    last_ele = arr[-1]
    prev = permutations(shorter_arr)
    prev.each do |subarr|
        i = 0
        while i <= shorter_arr.length
            new_sub = subarr.dup
            new_sub.insert(i,last_ele)
            # new_sub = subarr[0...i] + [last_ele] + subarr[i..-1]
            new_arr<< new_sub
            i += 1
        end
    end
    return new_arr
end

p permutations([1,2,3,4])
p permutations([1,2,3,4]).size