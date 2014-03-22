# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

require 'spec_helper'

describe SafeIntern::NilPatch do
  context '#intern' do
    it_behaves_like 'safe-intern', SafeIntern::NilPatch, :intern
  end

  context '#to_sym' do
    it_behaves_like 'safe-intern', SafeIntern::NilPatch, :to_sym
  end
end
