import UI.NCurses

data Snake = Snake { size :: Int }

main :: IO()
main = runCurses $ do
  setEcho False
  win <- defaultWindow

  let snake = Snake 3
  drawSnake win snake

  updateWindow win $ do
    drawBorder Nothing Nothing Nothing Nothing Nothing Nothing Nothing Nothing

  render
  readInput win (\e -> e == EventCharacter 'q')

readInput :: Window -> (Event -> Bool) -> Curses ()
readInput win f = loop where
  loop = do
    event <- getEvent win Nothing
    case event of
      Nothing -> loop
      Just e' -> if f e' then return () else loop

drawSnake :: Window -> Snake -> Curses ()
drawSnake win snake =
  updateWindow win $ do
    moveCursor 4 4
    drawString "A"
