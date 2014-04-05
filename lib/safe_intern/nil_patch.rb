# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

module SafeIntern
  module NilPatch
    %w(intern to_sym).each do |method|
      define_method(method) do |allow_unsafe = nil|
        if allow_unsafe == :allow_unsafe || SafeIntern.symbol_defined?(self)
          super()
        else
          nil
        end
      end
    end
  end
end
