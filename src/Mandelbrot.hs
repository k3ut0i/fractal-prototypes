module Mandelbrot (
  vMandelbrot
  )where
import Data.Array
import Data.Complex

maxIterations = 100
minConvergeValue = 0.000001

vMandelbrotCurve :: Complex Double -> Complex Double
vMandelbrotCurve z = z * z - 1

vMandelbrot :: (Double,Double) -> Double -> Array (Double,Double) Integer
vMandelbrot center radius = undefined

converges :: (Complex Double -> Complex Double)
          -> Double -> Integer -> Complex Double -> Bool
converges f minVal iterations initVal =
  if magnitude (f initVal) < minVal
  then True
  else converges f minVal (iterations - 1) (f initVal)

