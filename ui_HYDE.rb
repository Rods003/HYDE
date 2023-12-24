def boas_vindas
    puts "\n\n"
    puts "*******   BEM VINDOS À HYDE!   *******"
    puts "\n\n"
    puts "\"Olá... Alguém ai?!\""
    puts "\"Hey, ainda bem que encontrei você!\""
    puts "\"Qual o seu nome?\""
    puts "\n"
    nome = gets.strip
    puts "\n"
    puts "\"Olá #{nome}, eu sou o Hyde...\nEsse lugar está infestado de fantasmas e nós precisamos nos esconder... Rápido!!!\""
    nome
end

def escolha_de_mapa
    puts "\n"
    puts "\"Oh não... E agora? Qual porta devemos seguir? 1, 2, 3 ou 4?"
    numero = gets.strip
    numero
end

def desenha_mapa mapa
    puts "\n"
    puts mapa
    puts "\n"
end

def pede_movimento
    puts "\n"
    puts "\"Cuidado... tem fantasma nessa sala, não podemos ser pegos!\""
    puts "EM QUAL DIREÇÃO VOCÊ DESEJA SEGUIR? (W/A/S/D)"
    direcao = gets.strip.upcase
    direcao
end

def game_over
    puts "\n\n\n"
    puts "***   GAME OVER!   ***"
    puts "\n\n\n"
end