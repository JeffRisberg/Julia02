#=
BayesNets01:
- Julia version: 1.6.0
- Author: jeff
- Date: 2021-03-20
=#

using Random
Random.seed!(0) # seed the random number generator to 0, for a reproducible demonstration
using BayesNets

bn = BayesNet()
push!(bn, StaticCPD(:a, Normal(1.0)))
push!(bn, LinearGaussianCPD(:b, [:a], [2.0], 3.0, 1.0))

a = randn(100)
b = randn(100) .+ 2*a .+ 3

data = DataFrame(a=a, b=b)
cpdA = fit(StaticCPD{Normal}, data, :a)
cpdB = fit(LinearGaussianCPD, data, :b, [:a])

# Likelihood

println(pdf(bn, :a=>0.5, :b=>2.0))

data = DataFrame(a=[0.5,1.0,2.0], b=[4.0,5.0,7.0])
println(pdf(bn, data))    #  0.00215
println(logpdf(bn, data)) # -6.1386;

println(pdf(cpdB, data))    #  0.006
println(logpdf(cpdB, data)) # -5.201

# Sampling

println(rand(bn, 5))
data = DataFrame(c=[1,1,1,1,2,2,2,2,3,3,3,3],
b=[1,1,1,2,2,2,2,1,1,2,1,1],
a=[1,1,1,2,1,1,2,1,1,2,1,1])

bn5 = fit(DiscreteBayesNet, data, (:a=>:b, :a=>:c, :b=>:c))

# Inference

bn = DiscreteBayesNet()
push!(bn, DiscreteCPD(:a, [0.3,0.7]))
push!(bn, DiscreteCPD(:b, [0.2,0.8]))
push!(bn, DiscreteCPD(:c, [:a, :b], [2,2],
        [Categorical([0.1,0.9]),
         Categorical([0.2,0.8]),
         Categorical([1.0,0.0]),
         Categorical([0.4,0.6]),
        ]))

phi = infer(bn, :c, evidence=Assignment(:b=>1))
println(phi)

println(convert(DataFrame, phi))

# Bayesian Scoring

data = DataFrame(c=[1,1,1,1,2,2,2,2,3,3,3,3],
                 b=[1,1,1,2,2,2,2,1,1,2,1,1],
                 a=[1,1,1,2,1,1,2,1,1,2,1,1])
g = DAG(3)
add_edge!(g,1,2); add_edge!(g,2,3); add_edge!(g,1,3)

println(bayesian_score(g, [:a,:b,:c], data))
