.mode columns
.headers on
.nullvalue NULL

SELECT EQUIPA, NOME_JOGADOR, NACIONALIDADE_JOGADOR, MAX(TMP) GOLOS_MAIS_ASSISTENCIAS, (CASE WHEN MAX(TMP) = (SELECT MAX(G_A)
																												FROM (SELECT COUNT(*) G_A
																												FROM JOGO JOIN GOLO JOIN JOGADOR JOIN CLUBE
																												ON JOGO.idJogo = GOLO.idJogo AND (GOLO.idMarcador = JOGADOR.idJogador OR GOLO.idAssistente = JOGADOR.idJogador) AND JOGADOR.idClube = CLUBE.idClube
																												WHERE CLUBE.idClube = ID AND 10 < idJornada AND idJornada <= 20
																												GROUP BY idJogador)
																												) THEN 'SIM' ELSE 'NAO' END) AS MELHOR_DA_EQUIPA
FROM (
		SELECT CLUBE.idClube ID, CLUBE.nome EQUIPA, JOGADOR.nome NOME_JOGADOR, nacionalidade NACIONALIDADE_JOGADOR, COUNT(*) TMP
		FROM JOGO JOIN GOLO JOIN JOGADOR JOIN CLUBE
		ON JOGO.idJogo = GOLO.idJogo AND (GOLO.idMarcador = JOGADOR.idJogador OR GOLO.idAssistente = JOGADOR.idJogador) AND JOGADOR.idClube = CLUBE.idClube
		WHERE nacionalidade <> 'Brasil' AND 10 < idJornada AND idJornada <= 20
		GROUP BY idJogador
		)
GROUP BY ID
ORDER BY 4 DESC, 3
