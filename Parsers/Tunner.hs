module Main (main) where
import System.IO
import System.Environment
import ParserTunning




unroll :: Int -> String
unroll x = unroll' x x
 where
  unroll'  0 i       = "\ttemp_sum = " ++ (unroll'' i)
  unroll'  i j       = "\tint a"++show (i-1)++" = block_data[tid+"++show (i-1)++"*blockDim.x];\n"++(unroll' (i-1) j)
  unroll'' 1         = "a0;\n\n"
  unroll'' i         = "a"++show (i-1)++" + "++unroll'' (i-1)


read_DB_PER_TB :: [Token] -> Int
read_DB_PER_TB (x:xs)
  | x == TUDefinition = token_int (head xs)
  | otherwise         = read_DB_PER_TB xs


determine_insertion_position :: [Token] -> Int
determine_insertion_position (x:xs) =
  case x of
  TUstart p    -> get_line p
  _            ->  determine_insertion_position xs


insert :: Int -> String -> [String] -> [String]
insert y s xs  =  as++(s:bs)
                  where (as,bs) = splitAt y xs


collapse :: [String] -> String
collapse (x:[]) = x
collapse (x:xs) = x ++ "\n" ++ (collapse xs)


main :: IO()
main = do
  args         <- getArgs
  input_handle <- openFile (args!!0) ReadMode
  input        <- hGetContents input_handle
  let tokens   =  getTokens input
  let input'   =  lines input
  let x        =  read_DB_PER_TB tokens
  let y        =  determine_insertion_position tokens
  let s        =  unroll x
  let output'  =  insert y s input'
  let output   =  collapse output'
  writeFile (args!!1) output
  hClose input_handle
