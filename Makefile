PARSER_DIR=./Parsers/
TEMPL_DIR=./Templates/
TEM_DIR=./.src/
EXE_DIR=./.exe/
REP_DIR=./.rep/
GHC_FLAGS=-w -i${PARSER_DIR}

build_parsers:
	alex ${PARSER_DIR}ParserReport.x
	alex ${PARSER_DIR}ParserTunning.x
	ghc  ${GHC_FLAGS} ${PARSER_DIR}ParserReport.hs
	ghc  ${GHC_FLAGS} ${PARSER_DIR}ParserTunning.hs
	ghc  ${GHC_FLAGS} ${PARSER_DIR}Tunner.hs

clean:
	rm -r -f ${TEM_DIR} ${EXE_DIR} ${REP_DIR} 
	rm -f ${PARSER_DIR}*.o ${PARSER_DIR}*.hi ${PARSER_DIR}ParserReport ${PARSER_DIR}Tunner
	rm -f Rplots.pdf discard 
	rm -f ${PARSER_DIR}ParserReport.hs ${PARSER_DIR}ParserTunning.hs
