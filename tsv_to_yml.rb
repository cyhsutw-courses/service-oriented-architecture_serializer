require 'csv'
require 'yaml'

def tsv_to_yml(src, dst)
  data = CSV.read(src, col_sep: "\t")
  column_names = data.shift
  data = data.map { |values| hashify(column_names, values) }
  File.open(dst, 'w') { |file| file.write data.to_yaml }
end

def hashify(keys, values)
  Hash[keys.zip(values)]
end

if ARGV.size == 2
  tsv_to_yml ARGV[0], ARGV[1]
else
  STDERR.puts 'usage: ruby tsv_to_yml.rb /path/to/tsv /path/to/yml'
end
