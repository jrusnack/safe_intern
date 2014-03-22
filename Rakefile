require 'rspec/core/rake_task'
require 'rake/extensiontask'
require 'rubocop/rake_task'
require 'benchmark'
$:.unshift File.expand_path('../lib', __FILE__)
require 'safe_intern'

RSpec::Core::RakeTask.new

Rake::ExtensionTask.new "symbol_defined" do |ext|
end

Rubocop::RakeTask.new

desc 'Benchmark implemented methods'
task :benchmark do
  i = 2000000

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
