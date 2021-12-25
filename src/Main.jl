#=
Main:
- Julia version: 1.6.5
- Author: jeff
- Date: 2021-01-31
=#

# Numbers

count = 5
println(typeof(count))

value = 5.5
println(typeof(value))

value = "Alpha"
println(typeof(value))

# Arrays

name_list = ["alpha", "beta", "gamma"]
println(name_list)

name_index = findfirst(==("beta"), name_list)
println(name_index)

append!(name_list, ["delta"])
println(name_list)

name_index = findfirst(==("delta"), name_list)
println(name_index)
println(length(n for n in name_list))

length_list = (length(n) for n in name_list)
println(collect(len for len in length_list))

score_list = Array{Int}(undef, 10)
for i = 1:10
  score_list[i] = 100
end
println(score_list)

# Types (structs)

struct Person
    firstName::String
    lastName::String
end

value = Person("Bob", "Jones")

@info value

abstract type MyAbstractType end

mutable struct MyType <: MyAbstractType
    foo
    bar::Int
end

x = MyType("Hello World!", 10)
println(x.foo)
println(x.bar)

y = MyType("Goodbye World!", 20)
println(y.foo)
println(y.bar)

# Macros

macro e(x)
   if typeof(x) == Expr
      println(x.args)
   end
   return x
end

@e 4

@e 4+4

@e 3.14159

@e 3.14159 * 2


# try out collect() and argmax()

"""
    argmax(seq, fn)

Applies fn() to each element in seq and returns the element that has the highest fn() value. argmax()
is similar to mapreduce(fn, max, seq) in computing the best score, but returns the corresponding element.
"""
function argmax(seq::T, fn::Function) where {T <: Vector}
    local best_element = seq[1];
    local best_score = fn(best_element);
    for element in seq
        element_score = fn(element);
        if (element_score > best_score)
            best_element = element;
            best_score = element_score;
        end
    end
    return best_element;
end

v = [(6.0, 5.0), (7.5, 1.6), (8.3, 0.0)]
println(v)
println(argmax(v, (function (x::Tuple{Float64, Float64}) return x[1]+x[2] end)))

v = [(6.0, 5.0) => "g", (7.5, 1.6) => "h", (8.3, 0.0) => "w"]
println(v)
#v = collect(x.length for x in name_list)

alpha = ((item[1][1] + item[1][2], item[2]) for item in v)
println(alpha)
println(collect(alpha))

println(argmax(collect(alpha), function (x::Tuple{Float64, String}) return x end))

# ----

x = 1.0
y = 1.0
result = [([x - 1.0, y], 0.8), ([x, y - 1.0], 0.1), ([x, y + 1.0], 0.1)]  # move left
println(typeof(result))

function is_valid_state(state::Tuple{Vector{Float64}, Float64})
    return state[1][1] > 0 && state[1][1] < 5 && state[1][2] > 0 && state[1][2] < 4
end

println(filter(is_valid_state, result))
