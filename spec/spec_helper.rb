# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

require 'safe_intern'
require 'safe_intern_helper'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = :documentation
end
