require 'csv'


class SymbolNameImporter
  attr_reader :filename

  def initialize(filename)
    @filename = filename
    @array_of_arrays = get_array_of_arrays
  end

  def get_array_of_arrays
    raw_text = File.read(filename)
    no_literal_quotes = raw_text.gsub("\"", "")
    split_lines = no_literal_quotes.split(/[\r\n]+/)
    split_lines.map {|l| l.split(",")}
  end

  def build_company_objects

  end

end

SymbolNameImporter.new('../../db/company_csvs/amex.csv').import
