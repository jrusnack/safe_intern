# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

require 'safe_intern'

# Patch String class to throw exception when new Symbol is created by intern
# or to_sym methods.
#
# Usage: require 'safe_intern/string'
#
class ::String
  prepend SafeIntern::ExceptionPatch
end
