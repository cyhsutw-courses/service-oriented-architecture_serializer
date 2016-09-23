# frozen_string_literal: true

require 'csv'
require 'yaml'

def yml_to_tsv(src, dst)
  data = YAML.load_file(src)
  keys = extract_keys(from_data: data)
  csv_data = keys.map { |key| extract_values(from_data: data, using_key: key) }
                 .transpose
  write_csv(to_file: dst, header_row: keys, data_rows: csv_data)
end

# utilities
def extract_keys(from_data: data)
  from_data.map(&:keys).flatten.uniq
end

def extract_values(from_data: [], using_key: nil)
  from_data.map { |data| data[using_key] }
end

def write_csv(to_file: nil, header_row: [], data_rows: [])
  CSV.open(to_file, 'w', col_sep: "\t") do |csv|
    csv << header_row
    data_rows.each { |row| csv << row }
  end
end

if ARGV.size == 2
  yml_to_tsv ARGV[0], ARGV[1]
else
  STDERR.puts 'usage: ruby yml_to_tsv.rb /path/to/yml /path/to/tsv'
end
