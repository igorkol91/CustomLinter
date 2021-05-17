# spec/linter_error_spec.rb

require_relative '../lib/linter_errors'

describe Linter do
  let(:test_linter) { Linter.new('./test_file.rb') }
  describe '#line_length' do
    it 'counts line width and returns an arror if line is more than 80 chars long' do
      expect(test_linter.line_length).to eql('Line 13 too long 160/80')
    end
  end

  describe '#brackets_whitespace' do
    it 'checks for missing white space before } or after {' do
      expect(test_linter.brackets_whitespace).to eql('Missing white-space after { on line 14')
    end
  end

  describe '#trailing_whitespace' do
    it 'for white spaces after the line is over' do
      expect(test_linter.trailing_whitespace).to eql('Trailing white-space on line 16')
    end
  end

  describe '#identation' do
    it 'countes identation that we have and compares it with expected identation' do
      expect(test_linter.identation).to eql('Wrong identation on line 20 expected 2 got 0')
    end
  end

  describe '#missing_ends' do
    it 'counts missing ends or extra ends if there are any' do
      expect(test_linter.missing_ends).to eql('Missing end on line 19')
    end
  end

  describe '#missing_endline' do
    it 'checks for missing endline at the end of the file' do
      expect(test_linter.missing_endline).not_to be true
    end
  end
end
