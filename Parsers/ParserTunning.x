{
module ParserTunning (Token(..), getTokens, AlexPosn(..), get_line, token_int) where
}

%wrapper "posn"

$digit   = 0-9
		         
tokens :-

       $white+				;
       "//+1"				{ tok (\p s -> TUstart p)     }
       "#define"$white+"DB_PER_TB"	{ tok (\p s -> TUDefinition)  }
       $digit+                     	{ tok (\p s -> TNum (read s)) }
       $printable			;

{

tok f p s = f p s

data Token =
     	   TUDefinition		|
	   TNum Int		|
	   TUstart AlexPosn 	
	   deriving (Eq,Show)

getTokens = alexScanTokens

token_int  (TNum x)       = x
get_line (AlexPn x y z)   = y
}
