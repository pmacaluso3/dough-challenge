# require 'googlecharts'
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
    yahoo_client = YahooFinance::Client.new
    @company = Company.find_by(id: params[:id])
    unaveraged_data = yahoo_client.historical_quotes(@company.stock_symbol, {start_date: Time::now - 50.days, end_date: Time::now})
    @averaged_days = unaveraged_data.map do |day|
      [day.open.to_f, day.close.to_f, day.high.to_f, day.low.to_f].reduce(:+)/4.0
    end.first(30)
    days = unaveraged_data.map{|d|d.trade_date}
    price_range = [@averaged_days.min/1.25, @averaged_days.max*1.25]
    @chart =  Gchart.line(
              size: '500x500',
              title: @company.name,
              bg: {color: 'cccccc', type: 'gradient'},
              data: @averaged_days,
              axis_with_labels: ['x', 'y'],
              axis_range: [[1,11,21,30],price_range],
              axis_labels: [[days[0], days[10], days[20], days.last]])
  end
end
