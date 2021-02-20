-- 함수 합성:
-- (.) :: (b -> c) -> (a -> b) -> a -> c
-- f . g = \x -> f (g x)

-- 리스트의 수의 절대값을 구해 음수로 바꾸
-- negs = map (\x -> negate (abs x)) [1, 2, 3]
negs = map (negate . abs) [1, 2, 3]


-- 여러 매개변수를 받는 합성함수
-- 각각의 함수가 하나의 매개변수만 받도록 부분적용 해줘야함
-- s = sum (replicate 5 (max 6 8))
s = (sum . replicate 5) (max 6 8)
ss = sum . replicate 5 $ max 6 8

sss = replicate 2 (product (map (*3) (zipWith max [1, 2] [4, 5])))
sss' = replicate 2 . product . map (*3) $ zipWith max [1, 2] [4, 5]


-- * point free style
sum' :: (Num a) => [a] -> a
-- sum' xs = foldl (+) 0 xs
sum' = foldl (+) 0

fn x = ceiling (negate (tan (cos (max 50 x))))
-- fn = ceiling (negate (tan (cos (max 50)))) -> cos에 max 50 부분적용을 이용할 수 앖음
-- 이를 함수 합성으로 풀자
fn'  = ceiling . negate . tan . cos . max 50
-- 함수가 복ㅈ바할 경우 point free 스타일을 과도하게 사용하면 가독성이 떨어짐 -> 이경우 let 바인딩을 이용
