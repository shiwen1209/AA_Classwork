def first_anagram?(str1 , str2)
    chars = str1.split("")
    chars.permutation.each do |ele|
        return true if ele.join == str2
    end    
    return false
end

p first_anagram?("gizmo", "sally")    #=> false
p first_anagram?("elvis", "lives")    #=> true

def second_anagram?(str1, str2)
    arr1 = str1.split("")
    arr2 = str2.split("")
    arr1.each_with_index do |char, i|
        j  = arr2.find_index(char)
        if j != nil
            arr2.delete(arr2[j])
        end
    end

    arr2.empty?

end

p second_anagram?("gizmo", "sally")    #=> false
p second_anagram?("elvis", "lives")    #=> true

def third_anagram?(str1, str2)
    sorted1 = str1.split("").sort.join
    sorted2 = str2.split("").sort.join
    sorted1 == sorted2
end

p third_anagram?("gizmo", "sally")    #=> false
p third_anagram?("elvis", "lives")    #=> true

def fourth_anagram?(str1, str2)
    hash1 = Hash.new(0)
    hash2 = Hash.new(0)
    str1.each_char {|char| hash1[char] += 1}
    str2.each_char {|char| hash2[char] += 1}
    hash1 == hash2
end 

p fourth_anagram?("gizmo", "sally")    #=> false
p fourth_anagram?("elvis", "lives")    #=> true

def bonus_anagram?(str1, str2)
    hash = Hash.new(0)
    str1.each_char {|char| hash[char] += 1}
    str2.each_char {|char| hash[char] -= 1}
    hash.all? {|k, v| v == 0 } # space complexity O(1) and time complexity is O(n)
end 

p bonus_anagram?("gizmo", "sally")    #=> false
p bonus_anagram?("elvis", "lives")    #=> true

