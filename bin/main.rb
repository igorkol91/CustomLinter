require_relative '../lib/file_reader.rb'
require_relative '../lib/linter_errors.rb'

@getFile = Linter.new('./test_file.rb')
@getFile.check_errors