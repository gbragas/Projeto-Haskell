import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Interface.IO.Game

-- Definindo variáveis globais
larguraTela, alturaTela, larguraPersonagem, alturaPersonagem, limiteAlturaJogo, limiteLarguraJogo, limiteAlturaEstrada, limiteLarguraEstrada, larguraObstaculo, alturaObstaculo, velocidadeObstaculo :: Float
larguraTela = 800.0
alturaTela = 600.0
larguraPersonagem = 50.0
alturaPersonagem = 50.0

larguraObstaculo = 40.0
alturaObstaculo = 20.0

limiteAlturaJogo = alturaTela / 2 - alturaPersonagem -- 260
limiteLarguraJogo = larguraTela / 2 - larguraPersonagem -- 360
limiteAlturaEstrada = alturaTela / 3
limiteLarguraEstrada = larguraTela / 2 - larguraObstaculo

velocidadeObstaculo = 50.0



-- Tipo Estado (posição do jogador e lista de obstáculos)
type Estado = (Float, Float, [Obstacle])  -- (posicaoX, posicaoY, lista de obstáculos)

-- Tipo Obstacle
type Obstacle = (Float, Float)

-- Posição inicial do jogador
estadoInicial :: Estado
estadoInicial = (0, limiteAlturaJogo, [(limiteLarguraEstrada, limiteAlturaEstrada), (limiteLarguraEstrada, -1 * limiteAlturaEstrada)])


-- Renderiza o estado do Jogador
desenhaJogador :: (Float, Float) -> Picture
desenhaJogador (x, y) = translate x y $ color blue $ rectangleSolid larguraPersonagem alturaPersonagem


-- Função para desenhar os obstáculos
desenhaObstaculos :: [Obstacle] -> Picture
desenhaObstaculos obstaculos = Pictures [translate ox oy $ color red $ rectangleSolid larguraObstaculo alturaObstaculo | (ox, oy) <- obstaculos]


-- Função principal de desenho
desenhaEstado :: Estado -> Picture
desenhaEstado (x, y, obstaculos) = Pictures [desenhaJogador (x, y), desenhaObstaculos obstaculos]



-- Atualiza o estado com base nas teclas e a área delimitada do jogo
reageEvento :: Event -> Estado -> Estado
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) (x, y, obstaculos)
    | x > limiteLarguraJogo = (x, y, obstaculos)
    | otherwise = (x + 10, y, obstaculos)
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) (x, y, obstaculos)
    | x < -limiteLarguraJogo = (x, y, obstaculos)
    | otherwise = (x - 10, y, obstaculos)
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (x, y, obstaculos)
    | y > limiteAlturaJogo = (x, y, obstaculos)
    | otherwise = (x, y + 10, obstaculos)
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (x, y, obstaculos)
    | y < -limiteAlturaJogo = (x, y, obstaculos)
    | otherwise = (x, y - 10, obstaculos)
reageEvento _ estado = estado


-- Atualiza o estado do jogo
atualizaEstado :: Float -> Estado -> Estado
atualizaEstado tempo (x, y, obstaculos) =
    let
        -- Velocidade dos obstáculos
        velocidade = 50.0

        -- Nova posição dos obstáculos
        novosObstaculos = [( if ox < -limiteLarguraEstrada then
         limiteLarguraEstrada 
         else 
            ox - velocidade * tempo, oy) | (ox, oy) <- obstaculos]
    in
        (x, y, novosObstaculos)


-- Função principal que inicia o jogo
main :: IO ()
main = play
    (InWindow "Jogo Haskell" (round larguraTela, round alturaTela) (100, 100))
    white
    60
    estadoInicial
    desenhaEstado
    reageEvento
    atualizaEstado
                               -- Função de atualização

{-
  Definicao de tipos de dados
-}



{-
  Funcoes auxiliares, que nos irao ajudar a criar o jogo
-}



{-
  Funcoes que criam o mapa do jogo
-}



{-
  Funcoes que criam o boneco do jogo
-}



{-
  Funcoes que capturam os eventos do teclado
-}



{-
  Funcoes que fazem a movimentacao do boneco
-}



{-
  Funcoes que criam os obstaculos do jogo
-}



{-
  Funcoes que fazem a movimentacao dos obstaculos
-}



{-
  Funcoes que fazem os obstaculos aparecerem/desaparecerem
-}



{-
  Funcoes que fazem a colisao do boneco com os obstaculos
-}



{-
  Funcoes que criam o estado inicial do jogo
-}
