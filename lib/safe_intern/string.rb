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
  if RUBY_VERSION.start_with?('2')
    prepend SafeIntern::ExceptionPatch

  else
    old_intern = instance_method(:intern)

    %w(intern to_sym).each do |method|
      define_method(method) do |allow_unsafe = nil|
        if allow_unsafe == :allow_unsafe || SafeIntern.symbol_defined?(self)
          old_intern.bind(self).call
        else
          fail UnsafeInternException
        end
      end
    end
  end
end
