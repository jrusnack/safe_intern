# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

require 'spec_helper'

describe SafeIntern::ExceptionPatch do
  context 'intern' do
    rnd = rand(100_000).to_s.extend(SafeIntern::ExceptionPatch)
    it_behaves_like 'safe-intern', SafeIntern::ExceptionPatch, :intern, rnd
  end

  context 'to_sym' do
    rnd = rand(100_000).to_s.extend(SafeIntern::ExceptionPatch)
    it_behaves_like 'safe-intern', SafeIntern::ExceptionPatch, :to_sym, rnd
  end
end
