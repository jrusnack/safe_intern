# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

require 'spec_helper'

describe SafeIntern::NilPatch do
  context '#intern' do
    rnd = rand(100_000).to_s.extend(SafeIntern::NilPatch)
    it_behaves_like 'safe-intern', SafeIntern::NilPatch, :intern, rnd
  end

  context '#to_sym' do
    rnd = rand(100_000).to_s.extend(SafeIntern::NilPatch)
    it_behaves_like 'safe-intern', SafeIntern::NilPatch, :to_sym, rnd
  end
end
