Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-param-types'
  spec.version     = '0.0.1'
  spec.homepage    = 'https://github.com/hostnet/puppet-lint-param-types'
  spec.license     = 'MIT'
  spec.author      = 'Hostnet'
  spec.email       = 'opensource@hostnet.nl'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint check that validates that all parameters are typed'
  spec.description = <<-EOF
    A new check for puppet-lint that validates that all parameters are typed.
  EOF

  spec.add_dependency             'puppet-lint', '>= 1.1', '< 3.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
end
