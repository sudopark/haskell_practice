-- 목표
-- 가독성 좋은 함수 작성
-- 값을 빠르게 분해 및 if else 구문 피하기
-- 중간 계산값을 저장하여 재사용하기

-- 패턴매칭(pattern matching)
-- 패턴매칭은 여러 데이터가 따라야 하는 패턴을 지정하거나, 그 패턴에 따라 데이터를 분해하기 위해 사용
-- 함수를 정의할때 다른 패턴에 대해서도 별도의 함수 내용(body)를 만들 수 있음

-- 간단한 함수를 만들고 이 함수에 전달된 값이 7인지 검사
lucky :: Int -> String
lucky 7 = "is 7"
lucky x = "not 7"
-- lucky 실행시에 아래에서 위까지 패턴을 검사, 매칭되는경우 해당 내용이 이용됨

-- 재귀적인 팩토리얼
factorial :: Int -> Int
factorial 0 = 1
factorial x = x * factorial (x-1)

-- 패턴매칭이 실패하는 경우
charName :: Char -> String
charName 'a' = "this is a"
charName 'b' = "this is b"
-- charName 'g' -> error -> 책에서는 에러난다는데 안나네

-- tuple 패턴매칭
addVector :: (Double, Double) -> (Double, Double) -> (Double, Double)
-- addVector a b = (fst a + fst b, snd a + snd b)
addVector (a, b) (c, d) = (a + c, b + d)


-- list pattern matching
xs = [(1, 2), (3, 4)]
xs_sum = [x + y | (x, y) <- xs]
-- custom head
head' :: [a] -> a
head' [] = error "no head on an empty list"
head' (x:_) = x

tell :: (Show a) => [a] -> String
tell [] = "this list is empty"
tell (x:[]) = "this list has one element: " ++ show x
tell (x:y:[]) = "this list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:_) = "this element more than two elements: [" ++ show x ++ ", " ++ show y ++ "...]"


----------------------------------------------------------------
-- as- 패턴
-- as-패턴(as-pattern)은 패턴에 따라 항목을 분해하는 반면 원본 항목에 대한 참조는 유지함
-- as-패턴을 만들기 위해서는 이름과 @문자열을 일반적인 패턴 앞에 위치
firstLetters :: String -> String
firstLetters "" = "empty"
firstLetters all@(x:xs) = "first letter of " ++ all ++ "is " ++ [x]


----------------------------------------------------------------
-- gurad 패턴
-- 함수에 전달된 값들이 어떤 방법으로 구축되었는지 검사하기 위해 패턴을 사용, 값들의 속성을 검사할때 가드를 이용
tellBMI :: Double -> String
tellBMI bmi
  | bmi <= 18.5 = "저체중"
  | bmi <= 25.0 = "정상"
  | bmi <= 30 = "고체중"
  | otherwise = "비만 ㅇㅇ"
-- 가드는 파이프라인(|) 문자 다음에 불리언 표현식이 나오고 표현식이 true일 경우에만 사용될 수 있는 함수의 내용이 뒤에 따라옴
-- false의 경우 아래쪽 가드로 내려감
-- 가드는 한칸 이상의 들여쓰기가 되어야한다
-- 마지막 otherwise가 없다면 다음 패턴으로 진행 가능


----------------------------------------------------------------
-- where
-- 다른 언어에서 변수에 결과값을 저장하는것과 같이 중간 계산 결과를 저장할떄 쓰임
bmiTell :: Double -> Double -> String
bmiTell weight height
  | bmi <= 18.5 = "저체중"
  | bmi <= 25.0 = "정상"
  | bmi <= 30 = "고체중"
  | otherwise = "비만 ㅇㅇ"
  where bmi = weight / height ^ 2
-- 여기사 where를 이용하여 반복되는 bmi 계산을 피할 수 있음
-- 가드 다음에 하나 이상의 변수나 함수를 정의할 수 있음, 정의된것들은 가드의 모든 스코프에 들어감
bmiTell' :: Double -> Double -> String
bmiTell' weight height
  | bmi <= skinny = "저체중"
  | bmi <= normal = "정상"
  | bmi <= fat = "고체중"
  | otherwise = "비만 ㅇㅇ"
  where bmi = weight / height ^ 2
        skinny = 18.5
        normal = 25.0
        fat = 30
-- where 절 이수 변수명 들여쓰기가 맞아야함 ㅇㅇ

-- where절 범위
-- 정의한 함수에서만 보임. where 바인딩도 서로 다른 패턴의 함수에 공유 x
-- greet :: String -> String
-- greet "sam" = niceGreeting ++ "sam"
-- greet "bob" = niceGreeting ++ "bob"
-- greet name = badGreeting ++ name
--   where niceGreeting = "hi~ "
--         badGreeting = "ㅇㅇ "

-- where와 함께 패턴매칭
-- 패턴매칭을 위해 where 바인딩을 이용 가능
initials :: String -> String -> String
initials fnm lnm = [f] ++ "." ++ [l]
    where (f:_) = fnm
          (l:_) = lnm


-- where 블록속의 함수
calcBmis :: [(Double, Double)] -> [Double]
calcBmis xs = [bmi w h | (w, h) <- xs]
  where bmi weight height = weight / height ^ 2


-- * let
-- 높이와 반지름으로 실린더 면젇 계산
cylinder :: Double -> Double -> Double
cylinder r h =
  let sideArea = 2 * pi * r * h
      topArea = pi * r^2
  in sideArea + 2 * topArea
-- let은 <표현식>에 let <바인딩> 형태를 취함, let으로 정의된 변수는 let 표현식 내부에 노출

-- where와 let의 차이
-- let은 바인딩을 앞에두고 표현식을 뒤에둠
-- 다음과 같은 방식도 가능 4 * (let a = 9 in a + 1) + 2 -> 42

-- 1. 로컬 영역의 함수를 실행하기 위해 사용
-- [let square x = x * x in (square 5, square 3, square 2)]
-- => [25, 9, 4]

-- 2. 세미콜론으로 구분 가능, 여러 변수를 바인딩, 하지만 줄바꿈 해주면 안뎀
-- (let a = 100; b = 200; c = 300 in a*b*c, let foo = "hey "; bar = "there!" in foo ++ bar)
-- => (6000000, "hey there!")

-- 3. let 표현식으로 하는 패턴매칭은 튜플을 해체하고 요소들을 명칭으로 바인딩
-- (let (a, b, c) = (1, 2, 3) in a+b+c) * 100
-- => 600
-- tuple (1, 2,, 3)을 해체하기 위하여 이용됨

-- 4. 리스트 통합(list comprephension)에서 사용 가능
-- bmi를 계산하여 비만인 사람만 출력
-- bmi 계산을 let으로 바인딩하고 리스트 통합의 결과로 표시
calcBmis2 :: [(Double, Double)] -> [Double]
calcBmis2 xs = [bmi | (w, h) <- xs, let bmi = (w / h^2), bmi > 25.0]

-- GHCi에서의 let
-- in 생략 가능 -> 전체 인터랙티브 섹터 내에 노출


-- * case 표현식
-- case 표현식은 특정 변수의 특정 값에 대한 코드블럭을 실행할 수 있게 해줌(일반적인 case 구문)
-- 하스켈의 특징은 여기에 패턴매칭도 가능함
head1 :: [a] -> a
head1 [] = error "empty"
head1 (x:_) = x

head2 :: [a] -> a
head2 xs = case xs of [] -> error "empty"
                      (x:_) -> x
-- case 표현식 패턴 -> 결과
--            패턴 -> 결과
--            ...
-- 매칭되는 패턴이 없으면 런타임 에러
-- case 패턴매칭은 함수 매개변수의 패턴매칭과 다르게 표현식 중간에 이용 가능
describrList :: (Show a) => [a] -> String
describrList ls = "This list is " ++ case ls of [] -> "empty"
                                                (x:[]) -> "single element: " ++ show x
                                                (x:y:[]) -> "two elements: " ++ show x ++ ", " ++ show y
                                                xs -> "many elements"

desLis :: (Show a) => [a] -> String
desLis ls = "This list is " ++ what ls
  where what [] = "empty"
        what (x:[]) = "single element: " ++ show x
        what (x:y:[]) = "two elements: " ++ show x ++ ", " ++ show y
        what xs = "many elements"
