using JuMP
using HiGHS

mutable struct EmpacotamentoData
    n::Int                  # numero de objetos
    obj::Array{Float64}     # pesos dos objetos
end

function readData(file)
    n = 0
    obj = []
    for l in eachline(file) 
        
        q = split(l, '\t')
        num = parse(Int64, q[2])
        if q[1] == "n"
            n = num
            obj = [0.0 for i=1:n]
        elseif q[1] == "o"
			p = parse(Float64, q[3])
            obj[num+1] = p
        end
    end
    return EmpacotamentoData(n, obj)
end

model = Model(HiGHS.Optimizer)

file = open(ARGS[1], "r")

data = readData(file)

# Variáveis de decisão
@variable(model, x[i=1:data.n, j=1:data.n], Bin) # =1, se objeto i está na caixa j
@variable(model, y[i=1:data.n], Bin) # =1, se caixa i foi usada

# Restrições
for j=1:data.n
    @constraint(model, sum(data.obj[i] * x[i, j] for i=1:data.n) <= 20 * y[j]) # Respeitar capacidade das caixas
end

for i=1:data.n
    @constraint(model, sum(x[i, j] for j=1:data.n) == 1) # Todo objeto tem que estar em alguma caixa
end

# Função objetivo
@objective(model, Min, sum(y[j] for j=1:data.n))

optimize!(model)
sol = objective_value(model)
println("TP1 2022043620 = ", round(sol))