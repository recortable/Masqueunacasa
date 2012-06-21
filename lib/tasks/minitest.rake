require "rake/testtask"

Rake::TestTask.new(:test => "db:test:prepare") do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

Rake::TestTask.new(:'test:unit' => "db:test:prepare") do |t|
  t.libs << "test"
  t.pattern = "test/unit/**/*_test.rb"
end




task :default => :test

