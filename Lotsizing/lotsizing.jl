using JuMP
using HiGHS

mutable struct LotSizingData
    n::Int 			# numero de periodos
    c::Array{Int} 	# custo de produção
    h::Array{Int} 	# custo de estoque
    d::Array{Int} 	# demandas dos clientes
    p::Array{Int} 	# multa da falta
end

function readData(file)
	n = 0
	c = []
	h = []
	d = []
    	p = []
	for l in eachline(file)
		q = split(l, '\t')
		num = parse(Int64, q[2])
		if q[1] == "n"
			n = num
			c = [0 for i=1:n]
			h = [0 for i=1:n]
			d = [0 for i=1:n]
            p = [0 for i=1:n]
		elseif q[1] == "c"
			c[num] = parse(Float64, q[3])
		elseif q[1] == "s"
			h[num] = parse(Float64, q[3])									
		elseif q[1] == "d"
			d[num] = parse(Float64, q[3])
        elseif q[1] == "p"
			p[num] = parse(Float64, q[3])
		end
	end
	return LotSizingData(n,c,h,d,p)
end

model = Model(HiGHS.Optimizer)

file = open(ARGS[1], "r")

data = readData(file)

# Variáveis de decisão
@variable(model, x[i=1:data.n] >= 0, Int) 	# quantidade produzida
@variable(model, s[i=1:data.n+1] >= 0, Int) # quantidade excedente
@variable(model, y[i=1:data.n+1] >= 0, Int) # quantidade faltante

# Restrições
for i=2:data.n
    @constraint(model, y[i] == data.d[i] - x[i] + y[i-1] - s[i-1] + s[i]) # o que falta em um período vai pro próximo
end

@constraint(model, s[1] == 0) # inicialmente não estocamos nada
@constraint(model, y[1] == data.d[1] - x[1]) # falta inicial

@constraint(model, sum(x[i] for i=1:data.n) == sum(data.d[i] for i=1:data.n)) # tem que produzir a demanda total

# Função objetivo
@objective(model, Min, sum(data.c[i]*x[i] + data.h[i]*s[i] + data.p[i]*y[i]  for i=1:data.n))

optimize!(model)
sol = objective_value(model)
println("TP1 2022043620 = ", sol)
