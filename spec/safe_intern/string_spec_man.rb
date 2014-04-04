# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

require 'spec_helper'

# Run this file manually with:
#
#     rspec spec/safe_intern/string_spec_man.rb
#
# or with rake:
#
#     rake test_string
#
# This cannot be run by rspec along with the rest of the tests, because rspec
# loads this file before running any tests. Upon loading, require loads patched
# String class, which makes other testcases fail, as they extend singleton
# classes of strings, when String class is patched already (so super() calls
# patched methods of String class).
#
# For now, I don`t want to go into forking for just three testcases.

describe 'String patched' do
  require 'safe_intern/string'

  context 'intern' do
    rnd = rand(100_000).to_s
    it_behaves_like 'safe-intern', SafeIntern::ExceptionPatch, :intern, rnd
  end

  context 'to_sym' do
    rnd = rand(100_000).to_s
    it_behaves_like 'safe-intern', SafeIntern::ExceptionPatch, :to_sym, rnd
  end
end
