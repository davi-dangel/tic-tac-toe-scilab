function posicaoPotencial = getPosicaoParaDuasTriplas(tabuleiro, triplas, player)
    posicoesVazias = find(tabuleiro == 0); 

    for i = 1:length(posicoesVazias)
        tempTabuleiro = tabuleiro;
        tempTabuleiro(posicoesVazias(i)) = player; 

        matchingTriplas = 0;
        posicaoPotencial = 0;

        for j = 1:size(triplas, 1)
            tripla = triplas(j, :);
            if sum(tempTabuleiro(tripla) == player) == 2 & (tempTabuleiro(tripla(1)) == 0 | tempTabuleiro(tripla(2)) == 0 | tempTabuleiro(tripla(3)) == 0)
                matchingTriplas = matchingTriplas + 1;
                posicaoPotencial = posicoesVazias(i);
            end
        end

        if matchingTriplas >= 2
            return;
        end
    end

    posicaoPotencial = 0;
endfunction


tabuleiro = [1, 0, 1, 0, 0, 0, 0, 0, 0];
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

player = 1;

posicaoPotencial = getPosicaoParaDuasTriplas(tabuleiro, triplas, player);
disp(posicaoPotencial)