# Modelagem-Problemas-Otimizacao
Modelagem de 5 problemas de otimização envolvendo programação linear e inteira para o Trabalho Prático 1 da disciplina de Pesquisa Operacional da UFMG, em 2024/01. 

## Autor
- José Eduardo Duarte Massucato

## Descrição
Abaixo, apresento uma breve descrição desses problemas.

1. **Problema de Empacotamento:** Considere um conjunto de objetos $O = \{ o_1, o_2, ..., o_n \}$ cada qual com um peso $w_i$. Dispomos de várias caixas de papel, cada uma delas com o limite de peso 20kg. Desejamos empacotar nossos objetos, utilizando o menor número de caixas possível, dado que em nenhuma caixa o valor da soma dos pesos dos objetos ultrapasse seu limite de peso.

2. **Problema de Clique Máxima:** Dado um grafo $G = (V, E)$, uma clique é um conjunto de vértices dois a dois adjacentes, ou seja, com arestas entre eles. Desejamos determinar um subgrafo induzido que seja uma clique de cardinalidade máxima (maior tamanho em número de vértices).

3. **Problema de Lotsizing com Backlog:** Estamos auxiliando um produtor a planejar sua produção. Esse produtor quer que planejemos sua produção para um horizonte de tempo com $n$ períodos. O produtor produz um único produto, conhece as demandas dos clientes para cada período de tempo $i$ ($d_i$), o custo de produzir uma unidade do produto no tempo $i$ ($c_i$) e o custo de armazenar uma unidade do tempo $i$ para o tempo $i + 1$ ($h_i$). Entretanto, devido a sazonalidade do produto, pode ser que os pedidos dos clientes não sejam satisfeitos em um período e, nesse caso, podemos entregar o produto atrasado para o cliente, mas pagamos uma multa $p_i$ por unidade de produto pedida pelo cliente e ainda não entregue no período $i$.

4. **Problema de Coloração:** Dado um grafo $G = (V, E)$, uma coloração própria é uma atribuição de cores aos vértices do grafo de tal forma que os vértices adjacentes recebem cores diferentes. Desejamos determinar o menor número de cores necessárias para colorir de maneira própria um grafo dado de entrada.

5. **Problema de A-Coloração:** Dado um grafo $G = (V, E)$, temos, além da coloração própria do grafo, a propriedade de que para cada conjunto de vértices coloridos com a cor $i$ temos na vizinhança combinada desses vértices todas as demais cores, ou seja, se $C_i \subseteq V(G)$ é o conjunto dos vértices que receberam a cor $i$, temos que para toda cor $i$, $N(C_i) \cap C_j \neq \emptyset$ para toda cor $j$, com $j \neq i$. Diremos então que a coloração é uma A-coloração. Desejamos determinar o maior número de cores possíveis para se colorir de maneira própria um grafo dado de entrada e garantir que a coloração obtida é uma A-coloração.

## Funcionalidades
- Resolução do problema por meio do solver HiGHS, da linguagem Julia.
- Apresentação do resultado de valor ótimo, para a entrada especificada.

OBS: os detalhes da formatação do arquivo de entrada seguem ao modelo dos exemplos disponíveis. Note que a separação dos valores ocorre por tabulação ('\t').

## Como usar
1. Problema de Empacotamento
```bash
julia Empacotamento/empacotamento.jl Empacotamento/Exemplos/Entradas/<entrada.txt>
```

2. Problema de Clique Máxima
```bash
julia Clique_Maxima/cliquemaxima.jl Clique_Maxima/Exemplos/Entradas/<entrada.txt>
```

3. Problema de Lotsizing com Backlog
```bash
julia Lotsizing/lotsizing.jl Lotsizing/Exemplos/Entradas/<entrada.txt>
```

4. Problema de Coloração
```bash
julia Coloracao/coloracao.jl Coloracao/Exemplos/Entradas/<entrada.txt>
```

5. Problema de A-Coloração
```bash
julia A_Coloracao/Acoloracao.jl A_Coloracao/Exemplos/Entradas/<entrada.txt>
```

OBS: O valor ótimo para cada instância, juntamente com uma possível atribuição de valores para as variáveis de decisão correspondentes, estão disponíveis na pasta Exemplos/Saidas de cada problema respectivo. A saída do programa em si é direcionada para a saída padrão.
