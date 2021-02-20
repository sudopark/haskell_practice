
-- maximum
-- base는 빈 리스트면 에러, 싱글톤이면 원소값
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "empty"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

-- base는 반복횟수가 0이하인 경우
replicate' :: Int -> a -> [a]
replicate' n x
  | n <= 0  = []
  | otherwise = x: replicate' (n-1) x

-- base는 n이 0보다 작거나 리스트가 빈 경우
take' :: Int -> [a] -> [a]
take' n _
  | n <= 0  = []
take' _ []  = []
take' n (x:xs) = x: take' (n-1) xs

-- base는 빈 리스트
reverse' :: [a] -> [a]
reverse' []  = []
reverse' (x:xs) = reverse' xs ++ [x]

repeat' :: a -> [a]
repeat' x = x: repeat' x

-- base는 둘 중 빈 경우
zip' :: [a] -> [b] -> [(a, b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x, y): zip' xs ys

-- base는 빈 리스트 -> 헤드부터 차례로 검사
elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' v (x:xs)
  | v == x = True
  | otherwise = v `elem'` xs

-- quick sort
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) =
  let lse = [v | v <- xs, v <= x]
      gt  = [v | v <- xs, v > x]
  in quickSort lse ++ [x] ++ quickSort gt
