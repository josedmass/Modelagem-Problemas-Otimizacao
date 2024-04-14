using JuMP
using HiGHS

mutable struct ColoracaoData
    n::Int                      # número de vertices
    ma::Array{Array{Int64}}     # lista de adjacências
end

function readData(file)
    n = 0
    ma = [[]]
    for l in eachline(file)
        q = split(l, '\t')
        
        if q[1] == "n"
            n = parse(Int64, q[2])
            ma = [[] for i=1:n]
        elseif q[1] == "e"
            u = parse(Int64, q[2])
			v = parse(Int64, q[3])
            push!(ma[v], u)
            push!(ma[u], v)
        end
    end
    return ColoracaoData(n, ma)
end

model = Model(HiGHS.Optimizer)

file = open(ARGS[1], "r")

data = readData(file)

# Variáveis de decisão
@variable(model, x[i=1:data.n, j=1:data.n], Bin) # =1, se o vértice i possui a cor j
@variable(model, y[i=1:data.n], Bin) # =1, se a cor i é usada

# Restrições
for i=1:data.n
    @constraint(model, sum(x[i, j] for j=1:data.n) == 1) # cada vértice só tem uma cor
end

for i=1:data.n
    for j in data.ma[i]
        for k=1:data.n
            @constraint(model, x[i, k] + x[j, k] <= y[k]) # vizinhos não possuem a mesma cor
        end
    end
end

# Função objetivo
@objective(model, Min, sum(y[i] for i=1:data.n))

optimize!(model)
sol = objective_value(model)
println("TP1 2022043620 = ", round(sol))