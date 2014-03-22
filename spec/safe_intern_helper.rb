# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

shared_examples 'safe-intern' do |patch, method|
  it 'should convert to Symbol if it already exists' do
    'Object'.extend(patch).send(method).should be_eql(:Object)
  end

  it 'should not create new Symbol if it does not already exist' do
    case patch.name
    when 'SafeIntern::NilPatch'
      'DoesNotExist'.extend(patch).send(method).should be_nil
    when 'SafeIntern::ExceptionPatch'
      expect { 'DoesNotExist'.extend(patch).send(method) }.to raise_error
    else
      fail
    end
    Symbol.all_symbols.map(&:to_s).should_not include('DoesNotExist')
  end

  it 'should accept :allow_unsafe as optional parameter' do
    rnd = rand(100_000).to_s
    Symbol.all_symbols.map(&:to_s).should_not include(rnd)
    rnd.extend(patch).send(method, :allow_unsafe).should be_eql(rnd.to_sym)
  end
end
