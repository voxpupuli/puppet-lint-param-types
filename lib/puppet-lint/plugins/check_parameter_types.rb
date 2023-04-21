PuppetLint.new_check(:parameter_types) do
  def check
    (class_indexes + defined_type_indexes).each do |idx|
      next if idx[:param_tokens].nil?

      # https://github.com/puppetlabs/puppet-specifications/blob/master/language/catalog_expressions.md
      # Each individual parameter in the parameter list must start with
      # either a datatype or a variable name, so testing whether the parameter is typed
      # is easy.
      state = :ST_BEGIN
      paren_stack = []
      data_stack = []
      idx[:param_tokens].each do |token|
        next if %i[NEWLINE WHITESPACE INDENT COMMENT MLCOMMENT SLASH_COMMENT].include?(token.type)

        case state
        when :ST_BEGIN
          paren_stack = []
          data_stack = []
          if (token.type == :TYPE) or (token.value =~ /^[A-Z]/)
            state = :ST_SKIP_TYPE
          elsif token.type == :VARIABLE
            notify :warning, {
              message: "missing datatype for parameter #{idx[:name_token].value}::#{token.value}",
              line: token.line,
              column: token.column,
            }
            state = :ST_SKIP
          end
        # skip over the parameter default which can contain complex data types with variable references
        # so a simple comma check isn't enough, brackets must be counted.
        when :ST_SKIP
          if token.type == :LPAREN
            paren_stack.push(true)
          elsif token.type == :RPAREN
            paren_stack.pop
          elsif token.type == :LBRACE || token.type == :LBRACK
            data_stack.push(true)
          elsif token.type == :RBRACE || token.type == :RBRACK
            data_stack.pop
          elsif token.type == :COMMA && data_stack.empty? && paren_stack.empty?
            state = :ST_BEGIN
          end
        # Datatypes cannot have variables so when a variable is found it must be
        # end of the data type
        when :ST_SKIP_TYPE
          state = :ST_SKIP if token.type == :VARIABLE
        end
      end
    end
  end
end
