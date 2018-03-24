module ImageUtils(
  writeToPPM,
  writeToPBM,
  writeToPGM
  ) where

import Data.Array
import System.IO(hPutStr,  withFile
                , IOMode(..)
                , hPutChar)

data Color = Color{ red   :: Int
                  , green :: Int
                  , blue  :: Int}

writeToPBM :: Array (Int,Int) Bool -> FilePath -> IO()
writeToPBM a path =  writeNetpbm PBM a (\b -> if b then "1" else "0") path
  
writeToPGM :: Array (Int,Int) Int -> FilePath -> IO()
writeToPGM a path = writeNetpbm PGM a show path

writeToPPM :: Ix i => Array i Color -> FilePath -> IO()
writeToPPM = undefined

data Netpbm = PBM | PGM | PPM

imageHeader :: Netpbm -> Int -> Int -> Int -> String
imageHeader t width height depth = case t of
  PBM -> "P1\n" ++ dimString ++ "\n"
  PGM -> "P2\n" ++ dimString ++ " " ++ (show depth) ++ "\n"
  PPM -> "P3\n" ++ dimString ++ " " ++ (show depth) ++ "\n"
  where
    dimString = (show width) ++ " " ++ (show height)
    
writeNetpbm :: Netpbm -> Array(Int, Int) a -> (a -> String) -> FilePath -> IO()
writeNetpbm t a f path = withFile path WriteMode $ \handle ->
  hPutStr handle (imageHeader t (x2-x1) (y2-y1) depth) >>
  sequence_ (map (\i -> printRow handle i) [i | i <- range(x1,x2)])
  where
    depth = 255
    ((x1,y1), (x2,y2)) = bounds a
    printElem h e = hPutStr h (f e)
    printRow h x  = sequence (map
                               (\j -> printElem h (a ! (x,j)) >>
                                      hPutChar h ' ')
                               [j | j <- range(y1, y2)])
                   >> hPutChar h '\n'
