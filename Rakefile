require 'rake'
require 'rake/clean'

CLEAN.include %w[
  **/*.o
  **/*.hi
  **/*.midi
]

task :default => :run

desc "export test data to zip"
task :export do
  sh 'zip -r export/test_data.zip test_data'
end
