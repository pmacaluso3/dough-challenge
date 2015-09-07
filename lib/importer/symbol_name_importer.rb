require 'csv'


class SymbolNameImporter
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def import
    raw_text = File.read(filename)
    no_literal_quotes = raw_text.gsub("\"", "")
    split_lines = no_literal_quotes.split(/[\r\n]+/)
    arrays_of_lines = split_lines.map {|l| l.split(",")}

  end


end

SymbolNameImporter.new('../../db/company_csvs/amex.csv').import
