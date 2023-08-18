function posicaoParaGanhar = GetPosicaoParaGanhar(tabuleiro, triplas, jogador)
    for i = 1:size(triplas, 1)
        tripla = triplas(i, :);
        if tabuleiro(tripla(1)) == 0 && tabuleiro(tripla(2)) == jogador && tabuleiro(tripla(3)) == jogador
            posicaoParaGanhar = tripla(1);
            return;
        elseif tabuleiro(tripla(1)) == jogador && tabuleiro(tripla(2)) == 0 && tabuleiro(tripla(3)) == jogador
            posicaoParaGanhar = tripla(2);
            return;
        elseif tabuleiro(tripla(1)) == jogador && tabuleiro(tripla(2)) == jogador && tabuleiro(tripla(3)) == 0
            posicaoParaGanhar = tripla(3);
            return;
        end
    end
    posicaoParaGanhar = 0;
end

tabuleiro = [0, 0, 0, 0, 0, 0, 0, 0, 0];
triplas = [
    1, 2, 3;
    4, 5, 6;
    7, 8, 9;
    1, 4, 7;
    2, 5, 8;
    3, 6, 9;
    1, 5, 9;
    3, 5, 7
];

posicaoGanhadora = posicaoParaGanhar(tabuleiro, triplas);
disp(posicaoGanhadora)
