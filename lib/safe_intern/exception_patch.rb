# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

module SafeIntern
  module ExceptionPatch
    def intern(allow_unsafe = nil)
      if allow_unsafe == :allow_unsafe || SafeIntern.symbol_defined?(self)
        super()
      else
        fail UnsafeInternException
      end
    end

    def to_sym(allow_unsafe = nil)
      if allow_unsafe == :allow_unsafe || SafeIntern.symbol_defined?(self)
        super()
      else
        fail UnsafeInternException
      end
    end
  end
end
