require 'rspec/core/rake_task'
require 'rake/extensiontask'
require 'rubocop/rake_task'
require 'benchmark'
$:.unshift File.expand_path('../lib', __FILE__)

task :default => :spec

# :compile task
Rake::ExtensionTask.new "symbol_defined"

# :spec task
RSpec::Core::RakeTask.new
task :spec => :compile

desc 'Test patched String provided by SafeIntern'
task :test_string => :compile do
  system 'rspec spec/safe_intern/string_spec_man.rb'
end

# :rubocop task
Rubocop::RakeTask.new

desc 'Benchmark implemented methods'
task :benchmark => :compile do
  require 'safe_intern'
  i = 20000

  Benchmark.bm(22) do |bm|
    string = 'String'
    bm.report("unpatched:") { i.times do string.intern end }

    str = string.clone.extend(SafeIntern::NilPatch)
    bm.report("Nil patch:") { i.times do str.intern end }
    bm.report("Nil patch(allow):") { i.times do str.intern(:allow_unsafe) end }

    str = string.clone.extend(SafeIntern::ExceptionPatch)
    bm.report("Exception patch:") { i.times do str.intern end }
    bm.report("Exception patch(allow):") { i.times do str.intern(:allow_unsafe) end }
  end
end
