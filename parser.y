class CX86
rule
  program: function {result=[val[0]]}
  | function program {result=[val[0],val[1]].flatten}
  function: TYPE IDENT OPEN_PAREN CLOSE_PAREN block {result={:type=>val[0],:name=>val[1],:code=>val[4]}}
  block: OPEN_CURLY statements CLOSE_CURLY {result=val[1]}
  statements: statement {result=[val[0]]}
  | statement statements {result=[val[0],val[1]].flatten}
  statement: RETURN expression SEMICOLON {result={:type=>:return,:expr=>val[1]}}
  | TYPE IDENT SEMICOLON {result={:type=>:vardecl,:vartype=>val[0],:varname=>val[1]}}
  | TYPE IDENT EQUALS expression SEMICOLON {result={:type=>:vardeclinit,:vartype=>val[0],:varname=>val[1],:init=>val[3]}}
  | expression SEMICOLON {result={:type=>:expr,:expr=>val[0]}}
  factor: NUM {result={:type=>:number,:value=>val[0]}}
  | MINUS factor {result={:type=>:neg,:expr=>val[1]}}
  | COMP factor {result={:type=>:comp,:expr=>val[1]}}
  | LNEG factor {result={:type=>:lneg,:expr=>val[1]}}
  | OPEN_PAREN expression CLOSE_PAREN {result=val[1]}
  | IDENT {result={:type=>:var,:name=>val[0]}}
  term: factor
  | term MUL factor {result={:type=>:mul,:expr1=>val[0],:expr2=>val[2]}}
  | term DIV factor {result={:type=>:div,:expr1=>val[0],:expr2=>val[2]}}
  | term MOD factor {result={:type=>:mod,:expr1=>val[0],:expr2=>val[2]}}
  additivexp: term
  | additivexp PLUS term {result={:type=>:plus,:expr1=>val[0],:expr2=>val[2]}}
  | additivexp MINUS term {result={:type=>:minus,:expr1=>val[0],:expr2=>val[2]}}
  shiftexp: additivexp
  | shiftexp SHL additivexp {result={:type=>:shl,:expr1=>val[0],:expr2=>val[2]}}
  | shiftexp SHR additivexp {result={:type=>:shr,:expr1=>val[0],:expr2=>val[2]}}
  relationalexp: shiftexp
  | relationalexp LT shiftexp {result={:type=>:lt,:expr1=>val[0],:expr2=>val[2]}}
  | relationalexp GT shiftexp {result={:type=>:gt,:expr1=>val[0],:expr2=>val[2]}}
  | relationalexp LE shiftexp {result={:type=>:le,:expr1=>val[0],:expr2=>val[2]}}
  | relationalexp GE shiftexp {result={:type=>:ge,:expr1=>val[0],:expr2=>val[2]}}
  equalityexp: relationalexp
  | equalityexp NE relationalexp {result={:type=>:ne,:expr1=>val[0],:expr2=>val[2]}}
  | equalityexp EQ relationalexp {result={:type=>:eq,:expr1=>val[0],:expr2=>val[2]}}
  andexp: equalityexp
  | andexp AND equalityexp {result={:type=>:and,:expr1=>val[0],:expr2=>val[2]}}
  xorexp: andexp
  | xorexp XOR andexp {result={:type=>:xor,:expr1=>val[0],:expr2=>val[2]}}
  orexp: xorexp
  | orexp OR xorexp {result={:type=>:or,:expr1=>val[0],:expr2=>val[2]}}
  landexp: orexp
  | landexp LAND orexp {result={:type=>:land,:expr1=>val[0],:expr2=>val[2]}}
  lorexp: landexp
  | exp LOR landexp {result={:type=>:lor,:expr1=>val[0],:expr2=>val[2]}}
  assignexp: lorexp
  | IDENT EQUALS expression {result={:type=>:assign,:name=>val[0],:expr=>val[2]}}
  | IDENT SETEQ expression {result={:type=>:assign,:name=>val[0],:expr=>{:type=>val[1],:expr1=>{:type=>:var,:name=>val[0]},:expr2=>val[2]}}}
  expression: assignexp
  | expression COMMA expression {result={:type=>:comma,:expr1=>val[0],:expr2=>val[2]}}

end

---- header
  require "./lexer.rb"

---- inner
  def initialize()
    @yydebug=true
  end
  def parse(input)
    scan_str(input)
  end
