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

function posicaoLivreParaMovimento = getPosicaoLivre(tabuleiro)
    posicaoLivreParaMovimento = 0;
    if(tabuleiro(5) == 0)
        posicaoLivreParaMovimento = 5;
        return;
    end
    cantos = [1 3 7 9];
    for i = 1:4
        if(tabuleiro(cantos(i)) == 0)
            posicaoLivreParaMovimento = cantos(i);
            return;
        end
    end
    return
endfunction

jogadorHumano = 1
jogadorComputador = 2
tabuleiro = [0 0 0 0 0 0 0 0 0];

triplas = [
       1,2,3 ;
       4,5,6 ;
       7,8,9 ;
       1,4,7 ;
       2,5,8 ;
       3,6,9 ;
       1,5,9 ;
       3,5,7  
    ];
k = size(triplas);
ganhou = 0;

disp( [
 tabuleiro(1) tabuleiro(2) tabuleiro(3);
 tabuleiro(4) tabuleiro(5) tabuleiro(6);
 tabuleiro(7) tabuleiro(8) tabuleiro(9)])
fim = 0;
while fim == 0
    // entra casa do adversário
    casa = input("selecione uma casa: ")
    if(casa > 0 & casa <= 9)
        if(tabuleiro(casa) == 0 )
            tabuleiro(casa) = 1;
            casaOk = 1;
        else
            printf('casa ocupada\n');
            casaOk = 0;
        end
    else
        printf('casa inválida\n');
        casaOk = 0;
    end
 
    // faz um lance
    if casaOk ==1
        fim = 1;
        posicaoGanhadora = GetPosicaoParaGanhar(tabuleiro, triplas, jogadorComputador);
        if posicaoGanhadora ~= 0
            tabuleiro(posicaoGanhadora) = jogadorComputador;
            fim = 0;
        else
            posicaoGanhadoraAdversario = GetPosicaoParaGanhar(tabuleiro, triplas, jogadorHumano);
            if posicaoGanhadoraAdversario ~= 0
                tabuleiro(posicaoGanhadoraAdversario) = jogadorComputador;
                fim = 0;
            else
                posicaoPotencial = getPosicaoParaDuasTriplas(tabuleiro, triplas, jogadorComputador);
                if posicaoPotencial ~= 0
                    tabuleiro(posicaoPotencial) = jogadorComputador;
                    fim = 0;
                else
                    posicaoPotencialAdversario = getPosicaoParaDuasTriplas(tabuleiro, triplas, jogadorHumano);
                    if posicaoPotencialAdversario ~= 0
                        tabuleiro(posicaoPotencialAdversario) = jogadorComputador;
                        fim = 0;
                    else
                        posicaoLivre = getPosicaoLivre(tabuleiro);
                        if posicaoLivre ~= 0
                            tabuleiro(posicaoLivre) = jogadorComputador;
                            fim = 0;
                        else
                            for i=1:1:9
                                if tabuleiro(i)== 0
                                    tabuleiro(i) = 2;
                                    fim = 0;
                                    break;
                                end
                            end
                        end
                    end
                end
            end
        end
 
        // verifica se alguém ganhou
        for i=1:1:k(1) 
            if (tabuleiro(triplas(i,1)) ==  tabuleiro(triplas(i,2))) & (tabuleiro(triplas(i,1)) ==  tabuleiro(triplas(i,3))  & tabuleiro(triplas(i,1)) <> 0)
                ganhou = tabuleiro(triplas(i,1))
                printf('jogador %d ganhou', ganhou);
                fim = 1;
                break;
            end
        end

        if fim == 1 & ganhou == 0
            printf('empatou');
        end
 
    end
    disp( [
    tabuleiro(1) tabuleiro(2) tabuleiro(3);
    tabuleiro(4) tabuleiro(5) tabuleiro(6);
    tabuleiro(7) tabuleiro(8) tabuleiro(9)])
end