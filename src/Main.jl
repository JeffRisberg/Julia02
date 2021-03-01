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

