task :default => ["lexer.rb","parser.rb"]
file "lexer.rb" => ["lexer.rex"] do
  `rex lexer.rex -o lexer.rb`
end
file "parser.rb" => ["parser.y"] do
  `racc parser.y -o parser.rb`
end
