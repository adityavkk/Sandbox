-- Simple Assembler Interpreter (https://www.codewars.com/kata/58e24788e24ddee28e000053)

module SimpleAssembler (simpleAssembler) where
import qualified Data.Map.Strict as M
import Data.Char

type Register  = Char
type Registers = M.Map Register Int
type AST       = M.Map Int Token
type Instructions = [Token]

data Token   = MovI Register Int
             | MovR Register Register
             | Inc Register
             | Dec Register
             | JnzI Register Int
             | JnzR Register Register
             deriving (Show)

isRegister [x] = isAlpha x
isRegister _ = False

toToken :: String -> Token
toToken ('m':'o':'v':' ':r:' ':val) = if isRegister val then MovR r (head val) else MovI r (read val)
toToken ('j':'n':'z':' ':r:' ':val) = if isRegister val then JnzR r (head val) else JnzI r (read val)
toToken ('i':'n':'c':' ':r:_)       = Inc r
toToken ('d':'e':'c':' ':r:_)       = Dec r

tokenize :: [String] -> Instructions
tokenize instructions = map toToken instructions

eval :: Instructions -> Registers
eval instructions = go 1 ast M.empty
    where 
      ast                      = M.fromList $ zip [1..length instructions] instructions
      isDone i                 = i > length instructions
      go i ast state           = if isDone i then state else run (ast M.! i) i state
      run (MovI r x) i state   = go (i + 1) ast (M.insert r x state)
      run (MovR r x) i state   = go (i + 1) ast (M.insert r (state M.! x) state)
      run (Inc r) i state      = go (i + 1) ast (M.insertWith (+) r 1 state)
      run (Dec r) i state      = go (i + 1) ast (M.insertWith (flip (-)) r 1 state)
      run (JnzI r jump) i state = if (state M.! r) /= 0 then go (i + jump) ast state else go (i + 1) ast state
      run (JnzR r register) i state = if (state M.! r) /= 0 then go (i + (state M.! register)) ast state else go (i + 1) ast state

format rs = M.fromList ( map (\ (k, v) -> ([k], v)) $ M.toList rs)

simpleAssembler = format . eval . tokenize


































---------------------------------------- TESTS ---------------------------------------- 
case1 = ["mov a 5", "inc a", "dec a", "dec a", "jnz a -1", "inc a"]
case2 = ["mov a 5", "inc a", "dec a", "mov b 1", "dec b"]
case3 = ["mov a -10","mov b a","inc a","dec b","jnz a -2"]
