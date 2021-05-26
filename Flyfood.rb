def gerarPermutações(arrayPontos=[], k=1)
    if k == arrayPontos.length()
        valor = calcularDistancia(arrayPontos, k)
        if valor < $menor
            $menor = valor
            $menorArray = arrayPontos.clone()
        end
    else
        for i in k..arrayPontos.length()-1 do
            trocar(arrayPontos, k,i)
            gerarPermutações(arrayPontos, k+1)
            trocar(arrayPontos, k,i)
        end
    end
end
 
def trocar(arrayPontos, k,i)
    temp = arrayPontos[k]
    arrayPontos[k] = arrayPontos[i]
    arrayPontos[i] = temp
end

def calcularDistancia(arrayPontos, k)
    somador = 0
    (k-1).times do |j|
        somador += (arrayPontos[j][1] - arrayPontos[j+1][1]).abs() + (arrayPontos[j][2] - arrayPontos[j+1][2]).abs()
    end
    somador += (arrayPontos[k-1][1] - arrayPontos[0][1]).abs() + (arrayPontos[k-1][2] - arrayPontos[0][2]).abs()
    return somador
end

def pegarDadosArquivo(nomeArquivo, arrayPontos)
    file = File.open(nomeArquivo + ".txt", "r")
    file.each do |linha|
        pontostemp = [linha[0], nil, nil]
        primeiroNum = true
        numero1 = ""
        numero2 = ""
        for i in 2..linha.length()-1 do
            if linha[i] != " " and linha[i] != "\n"
                if primeiroNum
                    numero1 += linha[i]
                else
                    numero2 += linha[i]
                end
            else
                primeiroNum = false
            end
        end
        pontostemp[1] = numero1.to_f
        pontostemp[2] = numero2.to_f
        arrayPontos.push(pontostemp)
    end
    file.close()
end

pontos =  []
$menor = 9999999999999999999
$menorArray = []
print "Informe o nome do arquivo: "
nomeArquivo = gets.chomp()
ini = Time.now
pegarDadosArquivo(nomeArquivo, pontos)
gerarPermutações(pontos)
texto = ''
for i in 1..$menorArray.length()-1 do
    texto +=  $menorArray[i][0]
end
fim = Time.now
puts texto
puts fim-ini

file = File.open("resultados.txt", "a")
file.puts(texto)
file.puts(fim-ini)
file.puts
file.close()