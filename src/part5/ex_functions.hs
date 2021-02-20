
-- zipWith: 함수와 두 리스트를 받아 두 리스트를 합치는데 함수를 적용
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = f x y: zipWith' f xs ys
-- zipWith' (+) [1, 2, 3] [1, 1] = [2, 3]
-- zipWith' max [1, 2, 3] [2, 1, 4] = [2, 2, 4]
-- zipWith' (++) ["Apple", "Banana", "Melon"] (repeat " IceCream") = ["Apple IceCream","Banana IceCream","Melon IceCream"]
-- zipWith' (*) [1, 2, 3] [1 | _ <- [1..]] = [1, 2, 3]


-- flip :: (a -> b -> c) -> b -> a -> c
flip' :: (a -> b -> c) -> b -> a -> c
flip' f y x = f x y
-- flip' f = g
  -- where g x y = f y x

-- map
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs


-- filter
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
  | f x  = x : filter' f xs
  | otherwise = filter' f xs

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
-- quickSort (x:xs) = quickSort lte ++ [x] ++ quickSort gt
--   where lte = filter (<=x) xs
--         gt = filter (>x) xs
quickSort (x:xs) =
    let lte = filter (<=x) xs
        gt = filter (>x) xs
    in quickSort lte ++ [x] ++ quickSort gt

-- 3,829로 나눌 수 있는 수 중 100,000보다 작은 제일 큰 수
findLargestDivable :: Integer
findLargestDivable = head (filter p [100000, 99999..])
  where p x = x `mod` 3829 == 0


-- 10,000 보다 작은 모든 홀수의 재곱근을 합한값 찾기
-- hint) using takeWhile :: (a -> Bool) -> [a] -> [a]
s = sum (takeWhile (<10000)(filter odd (map (^2) [1..])))
s1 = sum (takeWhile (<10000) (map (^2) (filter odd [1..])))


-- Collatz seq
-- 어떤 자연수로 시작
-- 그 숫자가 1이면 멈춘다
-- 그 숫자가 짝수이면 2로 나눈다
-- 그 숫자가 홀수이면 3을 곱하고 1을 더한다
-- 결과숫자로 이 알고리즘을 반복
-- Question: 1~100 까지의 숫자로 시작한 콜라츠 수열중에 길이가 15보다 큰것은 몇개인가?
chain :: Int -> [Int]
chain 1 = [1]
chain n
  | even n = [n] ++ chain (n `div` 2)
  | odd n = [n] ++ chain (n * 3 + 1)
collatzLengthGt15 :: Int
collatzLengthGt15 = length (filter (isLong) (map chain [1..100]))
  where isLong xs = length xs > 15
