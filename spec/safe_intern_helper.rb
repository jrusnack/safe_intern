# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

# takes patch and method to test. nxstr is string that would result in new
# symbol defined when intern is called on it
shared_examples 'safe-intern' do |patch, method, nxstr|
  it 'should convert to Symbol if it already exists' do
    'Object'.extend(patch).send(method).should be_eql(:Object)
  end

  it 'should not create new Symbol if it does not already exist' do
    case patch.name
    when 'SafeIntern::NilPatch'
      nxstr.send(method).should be_nil
    when 'SafeIntern::ExceptionPatch'
      expect { nxstr.send(method) }.to raise_error
    else
      fail
    end
    Symbol.all_symbols.map(&:to_s).should_not include(nxstr)
  end

  it 'should accept :allow_unsafe as optional parameter' do
    Symbol.all_symbols.map(&:to_s).should_not include(nxstr)
    nxstr.intern(:allow_unsafe)
    Symbol.all_symbols.map(&:to_s).should include(nxstr)
  end
end
