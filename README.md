# SafeIntern

Safe implemetation of `String#intern` and `String#to_sym` methods.

## Description

One of the common security issues of Ruby applications is calling `intern` or 
`to_sym` on strings from untrusted source. Since symbols are not garbage 
collected in Ruby, yet take up some memory, this allows attacker to mount 
Denial of Service attack. Just by feeding the application with large number of
strings and creating large number of symbols, memory consumption of the Ruby
process would grow till machine runs out of memory.

One approach to solving this problem is to prevent calls to .intern on 
untrusted strings by whitelisting expected inputs:

    whitelist(untrusted_string).to_sym

This gets tedious very quickly - developer has to know all of the permitted 
values beforehand and has to maintain the list. 

Another approach is to allow conversion from string to symbol, but prevent 
allocation of new (previously unseen) symbol. This works most of the time since
all useful symbols are already allocated in application when its source is
parsed.

## How it works

Symbols are stored in a structure `global_symbols` which maintains mapping
between frozen strings that are the "name" of symbol and numeric IDs, which
are used by Ruby interpreter. All currently allocated Symbols can be listed
by calling `Symbol.all_symbols`.

Starting from Ruby 2.0, API provides `rb_check_id` function, which allows to
query `global_symbols` for particular symbol without allocating it. This is 
much more efficient than doing something like

    Symbol.all_symbols.map(&:to_s).include?(untrusted_string)

With the ability to query for known symbols, `intern` and `to_sym` methods can 
be patched. There are two possible behaviours when called on unknown string:

* return nil
* raise exception

This gem provides implementation of both in `SafeIntern::ExceptionPatch` and
`SafeIntern::NilPatch` modules. 

## Usage

1. Install using gem command:
      
        $ gem install safe_intern

  or include in Gemfile:

        gem 'safe_intern'

2. Patch the String:

        require 'safe_intern/string'

  This will patch `String#intern` and `String#to_sym` methods to throw 
  exception when new Symbol would be allocated. To return nil instead, patch 
  the String with

      require 'safe_intern'

      class ::String
        prepend SafeIntern::NilPatch
      end

  Prepending the `SafeIntern::NilPatch` module is important, since including it
  would result in the wrong order of method lookup.

  Only particular strings can be patched too:

      require 'safe_intern'
    
      unstrusted_string.extend(SafeIntern::ExceptionPatch)

  Calling `.to_sym` and `.intern` on unstrusted string that would result in
  new symbol allocation returns nil or throws exception:

      > untrusted_string.extend(SafeIntern::NilPatch)
      => "does_not_exist"
      > untrusted_string.intern
      => nil 
      > untrusted_string.extend(SafeIntern::ExceptionPatch)
      => "does_not_exist" 
      > untrusted_string.intern
      UnsafeInternException: UnsafeInternException
        from /home/jrusnack/.gem/ruby/gems/safe_intern-1.0.0/lib/safe_intern/exception_patch.rb:7:in `intern'
        from (irb):4
        from /usr/bin/irb:12:in `<main>'

  When String class is patched, creating new symbol from trusted string is
  possible with

      trusted_string.intern(:allow_unsafe)

## Requirements
* [Ruby] >= 2.0.0

## See also

Similar functionality is provided by [Symbol Lookup] gem. Read about addition 
of new method to query for already allocated Symbols in [Issue 7854].

Kudos to [Martin Povolny] for the initial idea.

## License
[SafeIntern] is released under the MIT License.

[Ruby]: http://www.ruby-lang.org
[Symbol Lookup]: https://github.com/phluid61/symbol_lookup-gem
[Issue 7854]: https://bugs.ruby-lang.org/issues/7854
[SafeIntern]: https://github.com/jrusnack/safe_intern
[Martin Povolny]: https://github.com/martinpovolny