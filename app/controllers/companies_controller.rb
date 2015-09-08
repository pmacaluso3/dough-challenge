class CompaniesController < ApplicationController
  def search_form
  end

  def index
    @companies = Company.first(20)
  end

  def search
    companies_by_name = Company.where("LOWER(name) LIKE ?", "#{params[:query].downcase}%")
    companies_by_stock_symbol = Company.where("LOWER(stock_symbol) LIKE ?", "#{params[:query].downcase}%")
    unsorted_companies = companies_by_name.concat(companies_by_stock_symbol)
    @companies = unsorted_companies.sort {|a, b| a.name <=> b.name }.first(20)
    render :"companies/index"
  end

  def show

  end
end
