module Main where

main :: IO ()

main = putStrLn "Hello world!"

-- list
list = [1, 2, 3]
list2 = list ++ [4]
list3 = 0:list
list4 = 1:2:3:[]

value1 = list !! 1


li1 = [1, 2, 3]
li2 = [2, 3, 4]
li3 = [2]

-- list의 비교연산자는 엠티와 논엠티를 비교할때 논엠티가 크다고 간주
-- li1 > li2: false
-- li1 >= li2: false
-- li1 > li3: false
-- li2 > li3: true -> 첫번쨰 원소 큼, 두번쨰부터 큼
-- li2 >= li3: true -> 상 동일
-- li2 < li3: false -> 두번째 원소부터 다름

h = head [1, 2, 3]  -- 1
t = tail [1, 2, 3]  -- [2,3]
l = last [1, 2, 3]  -- 3
i = init [1, 2, 3]  -- [1, 2]

len = length [1, 2, 3]  -- 3
n = null [] -- true
rev = reverse [1, 2, 3] -- [3, 2, 1]
tk = take 2 [1, 2, 3] -- [1, 2]

drp = drop 1 [1, 2, 3]  -- [2, 3]
drp100 = drop 100 [1, 2, 3] -- []

mx = maximum list -- 3
mn = minimum list -- 1

sm = sum list -- 1 + 2 + 3
prd = product list    -- 1 * 2 * 3

isElement = 3 `elem` list   -- true


-- enumerations
n1to20 = [1..20]
odd1to20 = [1,3..19]  -- initial, next .. end

powers = [2,4..]  -- [2,4,6,8 .... ]

clk = take 10 (cycle [1, 2, 3]) -- [1, 2, 3, 1, 2, 3, 1, 2 ,3, 1]
rept = take 10 (repeat 1) -- [1, 1, 1, 1, 1, 1,1, 1, 1]
rep = replicate 2 10  -- [10, 10]

-- list comprehension
-- x <- [1..10] x는 1..10으로 만들어지는 각 항목을 가져온다. 각 항목과 x를 바인딩 한다.
-- | 앞쪽 부분은 리스트 통합의 결과 부분인데 결과 리스트들이 어떠야 하는지 나타냄
comlist = [x*2 | x <- [1..10]]
-- 조건(서술부)이 맨 나중에 추가될 수 있음
-- 서술부를 이용하여 리스트의 일부를 없애는 것을 필터링 이라함
complistb12 = [x * 2 | x <- [1..10], x*2 >= 12]
-- ex) 50 ~ 100 까지의 수 중에서 7로 나눈 나머지가 3인 경우
n7modBy3 = [x | x <- [50..100], x `mod` 7 == 3]

-- 10보다 작은 홀수는 "큼" 작으면 "작"으로 홀수가 아니면 제거한거의 초기 10개
ranges xs = [if x < 10 then "L" else "G" | x <- xs, odd x]

not131517 xs = [x | x <- xs, x /= 13, x /= 15, x /= 17]

combi = [x + y | x <- [1, 2, 3], y <- [0, 10, 100]]

-- 모든 원소를 1로 바꾸고 합
length' xs = sum [1 | _ <- xs]

-- 중첩된 리스트에서 홀수들을 모두 제거
removeOdds xxs = [
    [x | x <- xs, odd x == False] | xs <- xxs
  ]


-- tuple
f = fst (1, 2)
s = snd (1, 2)

-- zip
infinite_numbers = [1..]
letters = ['a', 'b', 'c']
first3Letters = zip infinite_numbers letters

-- 직각 삼각형 찾기
-- 조건1: 세변의 길리는 모두 정수이다
-- 조건2: 각 변의 길이는 10보다 작다
-- 조건3: 삼각형의 둘레의 길이 합은 24이다
rightTriangles = [
    (a, b, c) | c <- [1..10], b <- [1..c], a <- [1..b],
    a^2 + b^2 == c^2, a + b + c == 24
  ]
