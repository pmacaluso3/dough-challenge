
namespace "db" do
  desc "imports the data from csv's located in db/company_csvs/*"
  task :import => :environment do
    require_relative '../importer/symbol_name_importer'
    csvs_dir = File.expand_path('../../..', __FILE__) + '/db/company_csvs/*'
    csvs_files = Dir[csvs_dir]
    csvs_files.each do |file|
      SymbolNameImporter.new(file).build_company_objects
    end
  end
end
