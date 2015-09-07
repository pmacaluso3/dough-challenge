require 'csv'
require_relative "../../app/models/company"


class SymbolNameImporter
  attr_reader :filename, :array_of_arrays

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
    array_of_arrays.each do |company_array|
      stock_symbol = company_array[0]
      name = company_array[1]
      this_company = Company.find_or_initialize_by(stock_symbol: stock_symbol)
      if this_company.new_record?
        this_company.name = name
        this_company.save
      end
    end
  end
end
