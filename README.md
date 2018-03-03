# puppet-lint-param-types

This plugin validates that all class and defined type parameter are typed.

## Installation

To use this plugin, add the following line to the Gemfile in your Puppet code
base and run `bundle install`.

```ruby
gem 'puppet-lint-param-types
```

Verify that plugin is installed correctly.

```bash
$ puppet-lint -h | grep parameter_types
    --no-parameter_types-check   Skip the parameter_types check.
```

## Usage


### parameter_types

**--fix-support: No**

Will raise a warning if a class parameter without data type specification is
found.

```
WARNING: missing datatype for parameter mysql::service_ensure on line 5
```

What you did:

```
class foo (
  $bar,
  $baz,
) { ... }
```

What you should have done:

```
class foo (
  Integer $bar,
  Array[String] $baz,
) { ... }
```

## References

https://puppet.com/docs/puppet/latest/lang_data_type.html
