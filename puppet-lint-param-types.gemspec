Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-param-types'
  spec.version     = '1.0.0'
  spec.homepage    = 'https://github.com/hostnet/puppet-lint-param-types'
  spec.license     = 'MIT'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.summary     = 'puppet-lint check that validates that all parameters are typed'
  spec.description = <<-EOF
    A new check for puppet-lint that validates that all parameters are typed.
  EOF

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_dependency 'puppet-lint', '>= 3', '< 5'
end
