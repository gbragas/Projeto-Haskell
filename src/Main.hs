import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

-- Definindo variáveis globais
larguraTela, alturaTela, larguraPersonagem, alturaPersonagem, limiteAlturaJogo, limiteLarguraJogo, limiteAlturaEstrada, limiteLarguraEstrada, larguraObstaculo, alturaObstaculo, distanciaObstaculo :: Float
larguraTela = 800.0
alturaTela = 600.0
larguraPersonagem = 50.0
alturaPersonagem = 50.0

larguraObstaculo = 40.0
alturaObstaculo = 20.0

limiteAlturaJogo = alturaTela / 2 - alturaPersonagem / 2 -- 260
limiteLarguraJogo = larguraTela / 2 - larguraPersonagem -- 360
limiteAlturaEstrada = alturaTela / 3
limiteLarguraEstrada = larguraTela / 2 - larguraObstaculo

distanciaObstaculo = 50.0


-- Tipo Estado (posição do jogador e lista de obstáculos)
type Estado = (Float, Float, [Obstacle])  -- (posicaoX, posicaoY, lista de obstáculos)

-- Tipo Obstacle
type Obstacle = (Float, Float)

-- Posição inicial do jogador
estadoInicial :: Estado
estadoInicial = (0, limiteAlturaJogo, [(limiteLarguraEstrada, limiteAlturaEstrada), (limiteLarguraEstrada - distanciaObstaculo,- (1 * limiteAlturaJogo))])

-- Fundo fixo
desenhaRua :: Picture
desenhaRua = translate 0 (-50) $ color (light black) $
    rectangleSolid larguraTela (500 + alturaObstaculo)

-- Renderiza o estado do Jogador
desenhaJogador :: (Float, Float) -> Picture
desenhaJogador (x, y) = translate x y $ color blue $ rectangleSolid larguraPersonagem alturaPersonagem

-- Função para desenhar os obstáculos
desenhaObstaculos :: [Obstacle] -> Picture
desenhaObstaculos obstaculos = Pictures [translate ox oy $ color red $ rectangleSolid larguraObstaculo alturaObstaculo | (ox, oy) <- obstaculos]

-- Função principal de desenho
desenhaEstado :: Estado -> Picture
desenhaEstado (x, y, obstaculos) = Pictures [desenhaRua, desenhaJogador (x, y), desenhaObstaculos obstaculos]

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
reageEvento (EventKey (SpecialKey KeySpace) Down _ _) _ = estadoInicial
reageEvento _ estado = estado

posicaoJogador :: Estado -> (Float, Float)
posicaoJogador (x, y, _) = (x, y)

posicaoObstaculos :: Estado -> [Obstacle]
posicaoObstaculos (_, _, obstaculos) = obstaculos

-- Verifica colisão
verificaColisao :: Estado -> Bool
verificaColisao state =
  let (px, py) = posicaoJogador state
  in any (\(ox, oy) -> colidio (px, py) (ox, oy)) (posicaoObstaculos state)

colidio :: (Float, Float) -> Obstacle -> Bool
colidio (jogadorX, jogadorY) (obstaculoX, obstaculoY) =
  jogadorX - larguraPersonagem / 2 < obstaculoX + larguraObstaculo / 2 &&
  jogadorX + larguraPersonagem / 2 > obstaculoX - larguraObstaculo / 2 &&
  jogadorY - alturaPersonagem / 2 < obstaculoY + alturaObstaculo / 2 &&
  jogadorY + alturaPersonagem / 2 > obstaculoY - alturaObstaculo / 2

-- Atualiza o estado do jogo
atualizaEstado :: Float -> Estado -> Estado
atualizaEstado _ estado
    | verificaColisao estado = estadoInicial
atualizaEstado tempo (x, y, obstaculos) =
    let
        -- Velocidade dos obstáculos
        velocidade = 80.0

        -- Nova posição dos obstáculos
        novosObstaculos = [(novoOx, novoOy) | (ox, oy) <- obstaculos,
            let novoOx = if ox < -limiteLarguraJogo then limiteLarguraJogo else ox - velocidade * tempo,
            let novoOy = if ox < -limiteLarguraJogo && y < limiteAlturaEstrada then y - alturaPersonagem else oy]

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
