
import Data.List
import Data.Char
import qualified Data.Map as Map

-- Data.List의 word 함수: 문자열을 단어 리스트로 반환
-- word :: String -> [String]
wds = words "this is sentance"
-- ["this","is","sentance"]


-- Data.List group: 리스트의 인접한 요소들끼리 서로 동일하다면 그룹화
-- group :: Eq a => [a] -> [[a]]
grps = group (replicate 3 1 ++ replicate 3 2 ++ replicate 3 3)
-- [[1,1,1],[2,2,2],[3,3,3]]

-- 문장을 단어로 나누고 각 단어별로 몇번 등장했는지 출력
countWords :: String -> [(String, Int)]
-- countWords sentance =
--   let sortedWords = (sort . words) sentance
--       wordGroups = group sortedWords
--   in map (\group -> (head group, length group)) wordGroups
countWords = map (\ws -> (head ws, length ws)) . group . sort . words


-- 건초 더미에서 바늘 찾기
-- 두개의 리스트를 받아서 첫번쨰 리스트가 두번째 리스트의 어느 부분으로 포함되었는지 구하여하
-- ex) [3, 4]는 [1, 2, 3, 4, 5]에 포함, [2, 4]는 미포함
-- 검색될 리스트를 건초(haystack) 찾을 리스트를 바늘(needle)이라 할꺼임
-- tails 함수
-- tails :: [a] -> [[a]]
tls = tails "needle"
-- ["needle","eedle","edle","dle","le","e",""]

-- isPrefixOf 함수
-- isPrefixOf :: Eq a => [a] -> [a] -> Bool
pr = "ha" `isPrefixOf` "hawai"

-- any 함수: 조건식과 리스트의 요소가 조건을 만족하는지 검사
-- any :: Foldable t => (a -> Bool) -> t a -> Bool
a = any (=='F') "Fruit"


isIn :: Eq a => [a] -> [a] -> Bool
isIn needle = any (needle `isPrefixOf`) . tails
-- isIn "ok" "this is okay": true
-- isIn "ok" "this is 0kay": false

-- 시저암호 -> char를 일정수준 쉬프팅함
-- Data.Char에 있는 기본 함수들을 이용
-- ord :: Char -> Int -> char의 유니코드 문자표에서의 위치를 반
encode :: Int -> String -> String
encode offset = map (\c -> chr $ ord c + offset)

decode :: Int -> String -> String
decode offset = map (\c -> chr $ ord c - offset)


-- 엄격한 foldl
-- foldl은 재귀적으로 구현되고 지연되는 연산이 길면 스택이 터질 수 있음
-- 이를 방지하기위해 Data.List의 foldl' 이용
lazy = foldl (+) 0 (replicate 100000000 1)  -- *** Exception: stack overflow
strict = foldl' (+) 0 (replicate 100000000 1) -- 100000000


-- 페어 리스트에서 원하는 값 찾기
findKey :: Eq k => k -> [(k, v)] -> Maybe v
findKey _ [] = Nothing
findKey key ((k, v): pairs)
  | key == k = Just v
  | otherwise = findKey key pairs

-- Data.Map -> dictionary와 비슷
-- Data.Map은 Prelude 및 Data.List와 충돌나기 때문에 qualified import를 할꺼임
-- import qualified Data.Map as Map
-- fromList :: Ord k => [(k, a)] -> Map.Map k a -> 리스트를 맵으로 바
-- 특이점: key가 Ord임 -> 더 효율적으로 값 찾을 수 있음
-- Map.lookup :: Ord k => k -> Map.Map k a -> Maybe a
phoneBook = Map.fromList [("alice", "123"), ("bob", "24"), ("john", "1244")]
johnNumber = Map.lookup "john" phoneBook
zeeNumber = Map.lookup "zee" phoneBook

-- 값 insert
-- Map.insert :: Ord k => k -> a -> Map.Map k a -> Map.Map k a
newPhoneBook = Map.insert "zee" "3433" phoneBook

-- Map.size :: Ord k => Map k a -> Int
size = Map.size newPhoneBook

-- 전화번호 문자열을 int 리스트로 반환
number = "2133-1233"
string2digits :: String -> [Int]
string2digits = map digitToInt . filter isDigit

-- Map.map :: (a -> b) -> Map.Map k a -> Map.Map k b
intBook = Map.map string2digits newPhoneBook

-- fromListWith :: Ord k => (a -> a -> a) -> [(k, a)] -> Map.Map k a
-- 중복되는 키값에 어떻게 저장할껀지 함수 a -> a를 받음
-- 중복되는거는 리스트로 보관하게할꺼임
doubleList =
  [
    ("a", "1"), ("b", "2"), ("c", "3"),
    ("a", "11"), ("b", "22")
  ]
list2doublePhoneBook :: [(String, String)] -> Map.Map String [String]
list2doublePhoneBook = Map.fromListWith (++) . map (\(k, v) -> (k, [v]))
-- 가독성 존나구리네;;
