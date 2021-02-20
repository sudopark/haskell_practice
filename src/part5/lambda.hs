
-- 여러 매개변수를 받는 함수를 매핑 가능 -> 이러면 함수로 매핑됨?
-- let listOfFuns map (*) [0..]
-- listOfFuns !! 4 -> (4*)와 동일
-- (listOfFuns !! 4) 5 -> 4*5와 동일


-- 람다는 단 한번만 함수가 필요할때 이용하는 익명의 함수
-- \로 시작하여 공백 이후에 매개변수 -> 이후에 함수의 내용
-- 일반적으로 괄호로 람다를 감싼다.

chain :: Int -> [Int]
chain 1 = [1]
chain n
  | even n = [n] ++ chain (n `div` 2)
  | odd n = [n] ++ chain (n * 3 + 1)

collatzLengthGt15 :: Int
-- collatzLengthGt15 = length (filter (isLong) (map chain [1..100]))
--   where isLong xs = length xs > 15
collatzLengthGt15 = length (filter (\xs -> length xs > 15) (map chain [1..100]))

m1 = map (+3) [1, 2, 3]
m2 = map (\x -> x + 3) [1, 2, 3]
-- 위의경우 부분적인 application이 더 가독성이 좋음

-- 람다는 여러 매개변수를 받을 수 있음
z = zipWith (\a b -> a * 3 / b) [1, 2, 3] [4, 5, 6]

-- 일반적인 함수처럼 패턴매칭도 이용 가능
-- 패턴매칭 실패시 런타임 에러
m = map (\(a, b) -> (a + b)) [(1, 2), (3, 4)]

add3 :: Int -> Int -> Int -> Int
add3 x y z = x + y + z

-- 커링된 버전
-- 괄호없이 람다를 사용하면 오른쪽 화살표 -> 가 포함된다고 가정(뭔말인지..)
add3' :: Int -> Int -> Int -> Int
add3' = \x -> \y -> \z -> x + y + z

-- 커링을 사용한경우 가독성이 더 좋은 예
flip' :: (a -> b -> c) -> b -> a -> c
flip' f = \x y -> f y x


-- * fold
-- fold는 이항연산자와 시작값 그리고 리스트를 인자로 받음
-- left fold -> 왼쪽부터 폴드
-- ex) sum
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs
-- 커리된 함수를 고려한다면 다음과 같이 더 간결하게 표현 가능
-- sum' = foldl (+) 0


mapR :: (a -> b) -> [a] -> [b]
mapR f xs = foldr (\x acc -> f x : acc) [] xs

mapL :: (a -> b) -> [a] -> [b]
mapL f xs = foldl (\acc x -> acc ++ [f x]) [] xs


-- foldl1, foldr1 -> 1번째(혹은 마지막 원소가) 초기 acc가됨
maximum' :: (Ord a) => [a] -> a
-- maximum' xs = foldl1 (\x acc -> max x acc) xs
maximum' = foldl1 max
-- foldl1, foldr1를 이용한 구현은 빈 리스트가 전달되어도 런타임 에러에서 자유로움

-- fold 예제
reverse' :: [a] -> [a]
-- reverse' xs = foldl (\acc x -> x:acc) [] xs
-- reverse' = foldl (\acc x -> x:acc) []
reverse' = foldl (flip(:)) []

product' :: (Num a) => [a] -> a
-- product' xs = foldl (\acc x -> acc * x) 1 xs
-- product' = foldl (\acc x -> acc * x) 1
product' = foldl (*) 1

filter' :: (a -> Bool) -> [a] -> [a]
-- filter' f xs = foldl (\acc x -> if f x then [x] ++ acc else acc) [] xs
-- filter' f = foldl (\acc x -> if f x then [x] ++ acc else acc) []
filter' f = foldr (\x acc -> if f x then x : acc else acc) []

last' :: [a] -> a
last' xs = foldr1 (\_ acc -> acc) xs


-- 모든 자연수의 제곱근 합이 1000을 초과하기 위해 몇개의 요소가 필요할까?
count :: Int
count = let sqrts = map sqrt [1..]
            sm = scanl (+) 0 sqrts
        in length (takeWhile (<1000) sm)


-- $: function application operator
-- ($) :: (a -> b) -> a -> b
-- ex) sum (filter (>10) [1, 2, 3]) = sum $ filter (>10) [1, 2, 3]
ss = sum (filter (>10) [1, 2, 3])
