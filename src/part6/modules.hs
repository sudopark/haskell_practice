
-- 하스켈 모듈(module)은 함수, 타입, 타입 클래스를 정의한 파일이며 하스켈 프로그램은 모듈들의 집합
-- 모듈의 일부를 외부로 노출시킬때 export

-- 모듈 import 하기
import Data.List


-- 모듈의 특정 함수만 임포트 하는 방법
-- import Data.List (nub, sort)
-- 모듈의 특정 함수만 제외하고 임포트
-- import Data.List hiding (nub)

-- 이름이 충돌하는 것을 피하며 임포트하는 다른 방식은 qualified import
import qualified Data.Map
-- qualified import를 줄이는 방법
import qualified Data.Map as M

-- 리스트가 가지고있는 요소 중 고유값이 얼마나 있는지 확인
numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub

-- 함수들을 검색하거나 어디있는지 찾으려면: Hoogle 참조
