require 'csv'

  namespace :reports do

    desc "accepts a date range and a day, week, or month and returns a breakdown of products sold by quantity per day/week/month"
    task products: :environment do
      ARGV.each { |a| task a.to_sym do ; end }
      #Ex. rake reports:products 2018-04-04 2018-04-06 day
      start_range, end_range, sort_by = ARGV[1..ARGV.length-1]
      
      products_sold =  Placement.sort_by_range(start_range, end_range, sort_by)

      CSV.open("products_sold_#{start_range}_#{end_range}.csv","wb") do |csv|
        CSV.parse(Reports::ProductsSerializer.new(sort_by, products_sold).as_csv) do |row|
          csv << row
        end
      end

    end
  end
