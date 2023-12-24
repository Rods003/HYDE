class Heroi
    attr_accessor :linha, :coluna

    def movimenta_jogador(direcao)
        novo_heroi = dup #DUPLICADO PARA HAVER INTERFERENCIA NA POSIÇAO ANTERIOR À ALTERAÇÃO
        movimentos = {
            "W" => [-1, 0],
            "A" => [0, -1],
            "S" => [1, 0],
            "D" => [0, 1],
        }
    
        movimento = movimentos[direcao]
        novo_heroi.linha += movimento[0]
        novo_heroi.coluna += movimento[1]
        novo_heroi
    end

    def direita
        movimenta_jogador "D"
    end
    def cima
        movimenta_jogador "W"
    end
    def esquerda
        movimenta_jogador "A"
    end
    def baixo
        movimenta_jogador "S"
    end

    def to_array
        [linha, coluna]
    end

    def remove_do mapa
        mapa[linha][coluna] = " "
    end

    def coloca_no mapa
        mapa[linha][coluna] = "H"
    end
    

end