# puppet-lint-param-types

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-param-types.svg)](https://github.com/voxpupuli/puppet-lint-param-types/blob/master/LICENSE)
[![Test](https://github.com/voxpupuli/puppet-lint-param-types/actions/workflows/test.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-param-types/actions/workflows/test.yml)
[![Release](https://github.com/voxpupuli/puppet-lint-param-types/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-param-types/actions/workflows/release.yml)
[![RubyGem Version](https://img.shields.io/gem/v/puppet-lint-param-types.svg)](https://rubygems.org/gems/puppet-lint-param-types)
[![RubyGem Downloads](https://img.shields.io/gem/dt/puppet-lint-param-types.svg)](https://rubygems.org/gems/puppet-lint-param-types)
[![Coverage Status](https://coveralls.io/repos/github/voxpupuli/puppet-lint-param-types/badge.svg?branch=master)](https://coveralls.io/github/voxpupuli/puppet-lint-param-types?branch=master)
[![Donated by Camptocamp](https://img.shields.io/badge/donated%20by-camptocamp-fb7047.svg)](#transfer-notice)

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

## Transfer Notice

This plugin was originally authored by [hostnet.nl](https://www.hostnet.nl/).
The maintainer preferred that Vox Pupuli take ownership of the gem for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of hostnet.

Previously: https://github.com/hostnet/puppet-lint-param-types

## License

This gem is licensed under the MIT license.

## Release information

To make a new release, please do:
* update the version in the gemspec file
* Install gems with `bundle config --local path .vendor && bundle install --with release`
* generate the changelog with `bundle exec rake changelog`
* Check if the new version matches the closed issues/PRs in the changelog
* Create a PR with it
* After it got merged, push a tag. GitHub actions will do the actual release to rubygems and GitHub Packages
