class CX86
macro
BLANK [\ \t\n]+
rule
int {[:TYPE,:INT]}
\( {[:OPEN_PAREN,"("]}
\) {[:CLOSE_PAREN,")"]}
\{ {[:OPEN_CURLY,"{"]}
\} {[:CLOSE_CURLY,"}"]}
; {[:SEMICOLON,";"]}
- {[:MINUS,"-"]}
~ {[:COMP,"~"]}
! {[:LNEG,"!"]}
\+= {[:SETEQ,:plus]}
\-\= {[:SETEQ,:minus]}
\/\= {[:SETEQ,:mul]}
\*\= {[:SETEQ,:div]}
\%\= {[:SETEQ,:mod]}
\<\<\= {[:SETEQ,:shl]}
\>\>\= {[:SETEQ,:shr]}
\&\= {[:SETEQ,:and]}
\|\= {[:SETEQ,:or]}
\^\= {[:SETEQ,:xor]}
\+ {[:PLUS,"+"]}
\* {[:MUL,"*"]}
\/ {[:DIV,"/"]}
% {[:MOD,"%"]}
\& {[:AND,"&"]}
\| {[:OR,"|"]}
\^ {[:XOR,"^"]}
<< {[:SHL,"<<"]}
>> {[:SHR,">>"]}
\&\& {[:LAND,"&&"]}
\|\| {[:LOR,"||"]}
\=\= {[:EQ,"=="]}
\!\= {[:NE,"!="]}
\< {[:LT,"<"]}
\<\= {[:LE,"<="]}
\> {[:GT,">"]}
\>\= {[:GE,">="]}
= {[:EQUALS,"="]}
, {[:COMMA,","]}
return {[:RETURN,"return"]}
\d+ {[:NUM,text.to_i]}
\w+ {[:IDENT,text]}
{BLANK} {}
inner
def tokenize(code)
  scan_setup(code)
  tokens = []
  while token = next_token
    tokens << token
  end
  tokens
end
end
