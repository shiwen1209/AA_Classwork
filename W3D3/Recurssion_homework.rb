def sum_to(n)
    return nil if n < 1
    return 1 if n == 1
    return n + sum_to(n-1)
end

def add_numbers(nums_arr)
    return nil if nums_arr.length == 0
    return nums_arr[0] if nums_arr.length == 1
    return add_numbers(nums_arr[0...-1]) + nums_arr[-1]
end

def gamma_fnc(num)
    return nil if num == 0 
    return 1 if num == 1
    return (num-1) * gamma_fnc(num-1)
end

def ice_cream_shop(flavors, favorite)
    return false if flavors.length == 0 
    return flavors[0] == favorite if flavors.length == 1
    return ice_cream_shop(flavors[0...-1], favorite) || flavors[-1] == favorite
end

def reverse(str)
    return str if str.length == 0 
    return str[-1] + reverse(str[0...-1])
end

def binary_search(arr, target)
    m = arr.length/2
    if arr[m] == target
        return m
    elsif arr[m] > target 
        return binary_search(arr[0...m], target)
    else
        stack = binary_search(arr[(m+1)..-1], target)
        return binary_search(arr[(m+1)..-1], target) + m +1
    end
end