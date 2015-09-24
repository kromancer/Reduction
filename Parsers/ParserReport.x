{
module Main (main) where
import System.IO
import System.Environment
}

%wrapper "basic"

$digit   = 0-9

@decimal = $digit+
@float   = @decimal \. @decimal
		         
tokens :-

       $white+				;
       @float                     	{ \s -> TFloat s }
       "void reduce"			{ \s -> TKernel }
       $printable			;

{

data Token =
     	   TKernel |
	   TFloat String
	   deriving (Eq,Show)

getTokens = alexScanTokens

getString (TFloat s) = s

get_runtime :: [Token] -> String
get_runtime y = get_runtime' y 0
 where
  get_runtime' (x:xs) i = 
   case x of
          TKernel -> getString (y !! (i-3))
          otherwise -> get_runtime' xs (i+1)	    	     	  

main:: IO ()
main = do
  args         <- getArgs
  input_handle <- openFile (args!!0) ReadMode
  input        <- hGetContents input_handle
  let tokens   =  getTokens input
  appendFile (args!!1) ( (args!!2) ++ " , " ++ (get_runtime tokens) ++ "\n" ) 
  hClose input_handle
}
