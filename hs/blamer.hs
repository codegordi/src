-- ## blamer.hs
-- ## adapted from www.haskell.org
-- ## cgutierrez

module Main where

import qualified Data.Map as M

errorsPerLine = M.fromList
    [ ("Chris", 2), ("Donalda", 4), ("Simon", -5) ]

main = do putStrLn "Who are you?"
          name <- getLine
          case M.lookup name errorsPerLine of
              Nothing -> putStrLn "I don't know you"
              Just n  -> do putStr "Errors per line: "
                            print n
