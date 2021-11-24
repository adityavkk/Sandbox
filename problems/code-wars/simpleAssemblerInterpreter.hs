-- Simple Assembler Interpreter (https://www.codewars.com/kata/58e24788e24ddee28e000053)

module SimpleAssembler (simpleAssembler) where
import qualified Data.Map.Strict as M
import Data.Char

type Register  = Char
type Registers = M.Map Register Int
type AST       = M.Map Int Token
type Instructions = [Token]

data Token   = Mov Register Int
             | Inc Register
             | Dec Register
             | Jnz Register Int
             deriving (Show)

toToken :: String -> Token
toToken ('m':'o':'v':' ':r:' ':v:_) = Mov r (digitToInt v)
toToken ('j':'n':'z':' ':r:' ':number) = Jnz r (read number)
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
      run (Mov r x) i state    = go (i + 1) ast (M.insert r x state)
      run (Inc r) i state      = go (i + 1) ast (M.insertWith (+) r 1 state)
      run (Dec r) i state      = go (i + 1) ast (M.insertWith (flip (-)) r 1 state)
      run (Jnz r jump) i state = if (state M.! r) /= 0 then go (i + jump) ast state else go (i + 1) ast state

simpleAssembler :: [String] -> Registers
simpleAssembler = eval . tokenize


































---------------------------------------- TESTS ---------------------------------------- 
case1 = ["mov a 5", "inc a", "dec a", "dec a", "jnz a -1", "inc a"]
case2 = ["mov a 5", "inc a", "dec a", "mov b 1", "dec b"]
