

-- a -> a -> a = (a -> a) -> a = a -> (a -> a)
-- 매개변수가 없는 하나의 함수를 호출하면 남겨둔 만큼의 매개변수를 빋는 부분적용된 함수를 받음
-- ex) max 4를 호출하면 하나의 매개변수를 받는 함수를 호출하는것과 같음
-- 부분적용된 application(적은 매개변수로 함수를 호출하는것)을 이용하면 즉석으로 함수를 생성하는 효과

multiThree :: Int -> Int -> Int -> Int
multiThree x y z = x * y * z
-- multiThree 1 2 3 => ((multiThree 1) 2) 3
-- multiThree에 1이 적용됨 -> 하나의 매개변수를 받아서 함수를 반환하는 함수 생성
-- 이후 2를 적용하면 하나의 매개변수를 받게될 함수를 생성하고 1, 2를 곱한 뒤 그것을 매개변수에 곱함
-- multiThree :: Int -> (Int -> (Int -> Int))
multiTwoWithOne = multiThree 1

compareWithHndred :: Int -> Ordering
-- compareWithHndred x = compare 100 x
compareWithHndred = compare 100


-- section
-- 중위함수는 섹션을 적용하여 부분적으로 적용될 수 있음. 중위 함수에 섹션
-- (하스켈에서 중위 연산자에 인자를 부분적으로 적용하는것을 섹션 이라 함)을 사용하기 위하여
-- 괄호로 그것을 감싸고 한쪽에만 매개변수를 제공
-- => 하나의 매개변수만 받는 함수를 생성하고 operand가 없는 쪽에 적용됨
-- 다음은 잘못된 예제
-- divideByTen :: (Floating a) -> a -> a
-- divideByTen = (/10)
-- divideByTen 200을 호출하는 것은 200 / 10 또는 (/10) 200이라고 호출하는 것과 같음

isUpperCaseAlanum :: Char -> Bool
isUpperCaseAlanum = (`elem` ['A'..'z'])

-- * 함수를 인자로 받는 함수
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
-- applyTwice (+3) 10            = (10 + 3) + 3 = 16
-- applyTwice (++ " HAHA") "Hey"  = ("Hey" ++ " HAHA") ++ " HAHA" = "Hey HAHA HAHA"
-- applyTwice ("HAHA " ++) "Hey" = "HAHA " ++ ("HAHA " ++ "Hey") = "HAHA HAHA Hey"
-- applyTwice (multiThree 2 2) 9 = 2 * 2 * (2 * 2 * 9) = 144
-- applyTwice (3:) [1]         = 3:3:[1] = [3, 3, 1]
