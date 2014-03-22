/* Copyright (C) 2014 Jan Rusnacko
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions of the
 * MIT license.
 */

#include "ruby.h"

VALUE
symbol_defined(VALUE self, VALUE str)
{
    if(rb_check_id(&str)) {
        return Qtrue;
    } else {
        return Qfalse;
    }
}

VALUE cSafeIntern;

void Init_symbol_defined()
{
    cSafeIntern = rb_define_module("SafeIntern");
    rb_define_module_function(cSafeIntern, "symbol_defined?", symbol_defined, 1);
}