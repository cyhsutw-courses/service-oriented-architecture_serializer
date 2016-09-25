# frozen_string_literal: true
require 'csv'
require 'yaml'

def tsv_to_yml(src, dst)
  data = CSV.read(src, col_sep: "\t")
  keys = data.shift
  data = data.map { |values| hashify(keys, values) }
  File.open(dst, 'w') { |file| file.write data.to_yaml }
end

def hashify(keys, values)
  keys.zip(values).to_h
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.size == 2
    tsv_to_yml(*ARGV)
  else
    STDERR.puts 'usage: ruby tsv_to_yml.rb /path/to/tsv /path/to/yml'
  end
end
