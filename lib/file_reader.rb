class ParseFile
  def initialize(file_path = nil)
    raise 'Path Undefined' if file_path.nil?
    @file = File.open(file_path)
    @file_data = @file.readlines(&:chomp)
  end
end
