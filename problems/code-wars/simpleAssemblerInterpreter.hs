-- We want to create a simple interpreter of assembler which will support the following instructions:

-- mov x y - copies y (either a constant value or the content of a register) into register x
-- inc x - increases the content of the register x by one
-- dec x - decreases the content of the register x by one
-- jnz x y - jumps to an instruction y steps away (positive means forward, negative means backward, y can be a register or a constant), but only if x (a constant or a register) is not zero
-- Register names are alphabetical (letters only). Constants are always integers (positive or negative).

-- Note: the jnz instruction moves relative to itself. For example, an offset of -1 would continue at the previous instruction, while an offset of 2 would skip over the next instruction.

-- The function will take an input list with the sequence of the program instructions and will execute them. The program ends when there are no more instructions to execute, then it returns a dictionary with the contents of the registers.

-- Also, every inc/dec/jnz on a register will always be preceeded by a mov on the register first, so you don't need to worry about uninitialized registers.

-- Approach:
--  - tokenize each operation into a token = AST
--  - AST will be a map with key = index of the instruction to accomodate the jnz instruction

--  - eval index ast state 
--      - run instruction state
--          - Mov r x        = eval (index + 1), state = set r x state
--          - Inc r, Dec r   = eval (index + 1), state = inc, dec r
--          - Jnz r i        = if contents r not 0, then eval (index - i) else eval (index + 1) 
--  - eval 0 ast emptyState

module SimpleAssembler (simpleAssembler) where
import qualified Data.Map.Strict as M

type Register  = Char
type Registers = M.Map Register Int
type AST       = M.Map Int Token

data Token   = Mov Register Int
             | Inc Register
             | Dec Register
             | Jnz Register Int

toToken ('m':'o':'v':' ':r:' ':v:_) = Mov r (digitsToInt v)
toToken ('j':'n':'z':' ':r:' ':v:_) = Jnz r (digitsToInt v)
toToken ('i':'n':'c':' ':r:_)       = Inc r
toToken ('d':'e':'c':' ':r:_)       = Dec r

tokenize instructions = M.fromList $ zip [1..length] (map toToken instructions)

eval ast = go 0 ast M.empty
    where 
        go i ast state           = run (state M.! (ast M.! i)) i state
        run (Mov r x) i state    = go (i + 1) ast (M.insert r x state)
        run (Inc r) i state      = go (i + 1) ast (M.insertWith (+) r 1 state)
        run (Dec r) i state      = go (i + 1) ast (M.insertWith (-) r 1 state)
        run (Jnz r jump) i state = if (state M.! i /= 0) then go (i + jump) ast state else go (i + 1) ast state

simpleAssembler :: [String] -> Registers
simpleAssembler = eval . tokenize


-------------------- TESTS -------------------- 
case1 = ["mov a 5", "inc a", "dec a", "dec a", "jnz a -1", "inc a"]
