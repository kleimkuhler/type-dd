module Exercises_3

import Data.Vect

-- 1
readToBlank : IO (List String)
readToBlank = do x <- getLine
                 if (x == "")
                    then pure []
                    else do xs <- readToBlank
                            pure (x :: xs)

-- 2
-- Found out about `unlines` after this...
readAndSave : IO ()
readAndSave = do putStrLn "Enter list (blank line to end):"
                 lines <- readToBlank
                 putStr "Enter filename: "
                 filename <- getLine
                 let input = concat (intersperse "\n" lines)
                 Right succ <- writeFile filename input
                     | Left err => printLn err
                 pure succ

-- 3
-- Implemented with readFile
readVectFile : (filename : String) -> IO (n ** Vect n String)
readVectFile filename = do Right input <- readFile filename
                               | Left err => pure (_ ** [])
                           pure (readVect (lines input))
  where
    readVect : (List String) -> (n ** Vect n String)
    readVect [] = (_ ** [])
    readVect (x :: xs) = let (_ ** rest) = readVect xs in
                             (_ ** x :: rest)

readVectFile' : (filename : String) -> IO (n ** Vect n String)
readVectFile' filename = do Right h <- openFile filename Read
                                | Left err => pure (_ ** [])
                            Right content <- readFile' h
                                | Left err => pure (_ ** [])
                            closeFile h
                            pure content 
  where
    readFile' : (h : File) -> IO (Either FileError (n ** Vect n String))
    readFile' h = do eof <- fEOF h
                     if eof
                        then pure (Right (_ ** []))
                        else do Right line <- fGetLine h
                                    | Left err => pure (Left err)
                                Right (_ ** rest) <- readFile' h
                                    | Left err => pure (Left err)
                                pure (Right (_ ** line :: rest))
