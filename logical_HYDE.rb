require_relative "ui_HYDE"
require_relative "heroi"

def le_mapa numero
    nivel = File.read "maze#{numero}.txt"
    mapa = nivel.split "\n"
    mapa
end

def copia_mapa mapa
    novo_mapa = mapa.join("\n").tr("F"," ").split("\n")
end

def encontra_jogador mapa
    caractere_do_heroi = "H"
    mapa.each_with_index do |linha_atual, linha|
        coluna_do_jogador = linha_atual.index caractere_do_heroi
        if coluna_do_jogador
            hyde = Heroi.new
            hyde.linha = linha
            hyde.coluna = coluna_do_jogador
            return hyde
        end
    end
    nil
end


def encontra_fantasma mapa
    caractere_do_fantasma = "F"
    novo_mapa = copia_mapa mapa
    mapa.each_with_index do |linha_atual, linha|
        linha_atual.chars.each_with_index do |caractere_atual, coluna|
            definitivamente_um_fantasma = caractere_atual == caractere_do_fantasma
            if definitivamente_um_fantasma
                fantasmas = [linha, coluna]
                move_fantasma mapa, novo_mapa, fantasmas
            end
        end
    end
    novo_mapa
end

def move_fantasma mapa, novo_mapa, fantasmas
    consequencias = posicoes_validas_a_partir_de mapa, novo_mapa, fantasmas
    if consequencias.empty?
        return
    end
    numero_de_consequencias = consequencias.size 

    consequencia = consequencias[rand(numero_de_consequencias)]
    mapa[fantasmas[0]][fantasmas[1]] = " "
    novo_mapa[consequencia[0]][consequencia[1]] = "F"
end

def posicoes_validas_a_partir_de mapa, novo_mapa, posicoes
    movimentos = []
    possibilidades = [[+1,0], [0,+1], [-1,0], [0,-1]]
    possibilidades.each do |movimento|
        nova_posicao = soma_vetor movimento, posicoes
        valida_mapas = posicao_valida?(mapa, nova_posicao) && posicao_valida?(novo_mapa, nova_posicao)
        if valida_mapas
            movimentos << nova_posicao
        end
    end
    movimentos
end

def soma_vetor vetor1, vetor2
    [vetor1[0] + vetor2[0], vetor1[1] + vetor2[1]]
end

def posicao_valida? mapa, posicao
    linha_mapa = mapa.size - 1
    coluna_mapa =  mapa[0].size - 1
    estouro_linha = posicao[0] < 0 || posicao[0] > linha_mapa
    estouro_coluna = posicao[1] < 0 || posicao[1] > coluna_mapa

     if estouro_linha || estouro_coluna
        return false
    end

    heroi = mapa[posicao[0]][posicao[1]]
    if heroi == "X" || heroi == "F"
        return false
    end

    true
end

def mapa_limita_bomba? mapa, posicao
    linha_mapa = mapa.size - 1
    coluna_mapa =  mapa[0].size - 1
    estouro_linha = posicao.linha < 0 || posicao.linha > linha_mapa
    estouro_coluna = posicao.coluna < 0 || posicao.coluna > coluna_mapa

    if estouro_linha || estouro_coluna
        return false
    end
    true
end

def exclui_do_mapa mapa, posicao, quantidade   
    if mapa_limita_bomba? mapa, posicao
        if mapa[posicao.linha][posicao.coluna] == "X"
            return
        end
        posicao.remove_do mapa
        explode mapa, posicao, quantidade - 1
    end
end

def explode mapa, posicao, quantidade
    if quantidade == 0
        return
    end
    exclui_do_mapa mapa, posicao.direita, quantidade
    exclui_do_mapa mapa, posicao.cima, quantidade
    exclui_do_mapa mapa, posicao.esquerda, quantidade
    exclui_do_mapa mapa, posicao.baixo, quantidade
end

def voce_perdeu? mapa
    perdeu = !encontra_jogador(mapa)
end

def jogar
    nome = boas_vindas
    numero = escolha_de_mapa
    mapa = le_mapa numero

    while true
        desenha_mapa mapa
        direcao = pede_movimento
        hyde = encontra_jogador mapa
        
        nova_posicao_jogador = hyde.movimenta_jogador(direcao)
        if !posicao_valida? mapa, nova_posicao_jogador.to_array
            next
        end
    
        hyde.remove_do mapa
        if mapa[nova_posicao_jogador.linha][nova_posicao_jogador.coluna] == "*"
            explode mapa, nova_posicao_jogador, 4
        end
        nova_posicao_jogador.coloca_no mapa

        mapa = encontra_fantasma mapa
        if voce_perdeu? mapa 
            game_over
            break
        end
    end
    

end

def inicia_jogo
    jogar
end