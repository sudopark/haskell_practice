
-- 파일명과 모듈명이 동일해야함

-- 모듈 정의

module Geometry
(
  sphereVolume,
  sphereArea,
  cubeVolume,
  cubeArea,
  cuboidVolume,
  cuboidArea
) where


sphereVolume :: Float -> Float
sphereVolume radius = (4.0 / 3.0) * pi * (radius ^ 3)
s

sphereArea :: Float -> Float
sphereArea radius = 4 * pi * (radius ^ 2)

cubeVolume :: Float -> Float
cubeVolume side = cuboidVolume side side side

cubeArea :: Float -> Float
cubeArea side = cuboidArea side side side

cuboidVolume :: Float -> Float -> Float -> Float
cuboidVolume a b c = a * b * c

cuboidArea :: Float -> Float -> Float -> Float
cuboidArea a b c = 2 * (rectArea a b + rectArea a c + rectArea b c)

rectArea :: Float -> Float -> Float
rectArea a b = a * b
