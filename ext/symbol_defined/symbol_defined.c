/* Copyright (C) 2014 Jan Rusnacko
 * 
 * This copyrighted material is made available to anyone wishing to use,
 * modify, copy, or redistribute it subject to the terms and conditions of the
 * MIT license.
 */

#include "ruby.h"

#ifdef RUBY2

VALUE
symbol_defined(VALUE self, VALUE str)
{
    if(rb_check_id(&str)) {
        return Qtrue;
    } else {
        return Qfalse;
    }
}

#else

st_table *cached_symbols;

VALUE
symbol_defined(VALUE self, VALUE str)
{
    int i;
    VALUE string;
    st_data_t data;
    
    ID to_s;
    VALUE symbols;

    to_s = rb_intern("to_s");
    // extremely slow, but necessary to see when new symbol has been added
    symbols = rb_sym_all_symbols();

    if(cached_symbols == NULL || cached_symbols->num_entries != RARRAY_LEN(symbols)){
        cached_symbols = st_init_strtable_with_size(2000);
        for (i = 0; i < RARRAY_LEN(symbols); i++)
        {
            string = rb_funcall(rb_ary_entry(symbols, i), to_s, 0, NULL);
            st_add_direct(cached_symbols, (st_data_t)StringValueCStr(string), NULL);
        }
    }

    if (st_lookup(cached_symbols, StringValueCStr(str), &data)) {
        return Qtrue;
    } else {
        return Qfalse;
    }
}

#endif

VALUE cSafeIntern;

void Init_symbol_defined()
{
    cSafeIntern = rb_define_module("SafeIntern");
    rb_define_module_function(cSafeIntern, "symbol_defined?", symbol_defined, 1);

#ifndef RUBY2
    st_init_table_with_size(&cached_symbols, 1000);
#endif
}