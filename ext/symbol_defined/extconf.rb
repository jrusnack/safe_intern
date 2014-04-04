# Copyright (C) 2014 Jan Rusnacko
#
# This copyrighted material is made available to anyone wishing to use,
# modify, copy, or redistribute it subject to the terms and conditions of the
# MIT license.

require 'mkmf'
# enable faster symbol lookup for Ruby 2
$CFLAGS += ' -DRUBY2' if RUBY_VERSION.start_with?('2')
create_makefile('symbol_defined')
