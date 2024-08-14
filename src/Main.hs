import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Interface.IO.Game

-- Definindo variáveis globais
larguraTela :: Float
larguraTela = 800.0

alturaTela :: Float
alturaTela = 600.0

larguraPersonagem :: Float
larguraPersonagem = 50.0

alturaPersonagem :: Float
alturaPersonagem = 50.0

limiteAlturaJogo :: Float
limiteAlturaJogo = alturaTela / 2 - alturaPersonagem --260

limiteLarguraJogo :: Float
limiteLarguraJogo = larguraTela / 2 - larguraPersonagem --360


-- Define o estado inicial do jogo (posição do jogador)
type EstadoJogador = (Float, Float)

-- Posição inicial do jogador
estadoInicial :: EstadoJogador
estadoInicial = (0, 0)

-- Renderiza o estado do jogo
desenhaEstadoJogador :: EstadoJogador -> Picture
desenhaEstadoJogador (x, y) = translate x y $ color blue $ rectangleSolid larguraPersonagem alturaPersonagem

-- Atualiza o estado com base nas teclas e a área delimitada do jogo
reageEvento :: Event -> EstadoJogador -> EstadoJogador
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) (x, y)
    | x  > limiteLarguraJogo = (x, y)
    | otherwise = (x + 10, y)
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) (x, y)
    | x < -1 * limiteLarguraJogo = (x, y)
    | otherwise = (x - 10, y)
reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (x, y)
    | y > limiteAlturaJogo = (x, y)
    | otherwise = (x, y + 10)
reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (x, y)
    | y < -1 * limiteAlturaJogo = (x, y)
    | otherwise = (x, y - 10)
reageEvento _ estado = estado

-- Atualiza o estado do jogo
atualizaEstadoJogador :: Float -> EstadoJogador -> IO EstadoJogador
atualizaEstadoJogador _ estado@(x, y) = do
    putStrLn $ "Current position: x = " ++ show x ++ ", y = " ++ show y
    return estado

-- Função principal que inicia o jogo
main :: IO ()
main = playIO
    (InWindow "Jogo Haskell" (round larguraTela, round alturaTela) (100, 100)) -- Tamanho da janela
    white                                         -- Cor do fundo
    60                                            -- Frames por segundo
    estadoInicial
    (return . desenhaEstadoJogador)
    (\e s -> return $ reageEvento e s)                                 -- EstadoJogador inicial                                -- Função de evento
    atualizaEstadoJogador                                -- Função de atualização
