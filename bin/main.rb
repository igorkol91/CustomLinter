require_relative '../lib/file_reader'
require_relative '../lib/linter_errors'

get_file = Linter.new('./test_file.rb')
get_file.check_errors
