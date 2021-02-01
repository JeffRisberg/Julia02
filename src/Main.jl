#=
Main:
- Julia version: 1.5.3
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

struct Person
    firstName::String
    lastName::String
end

value = Person("Bob", "Jones")

@info value

