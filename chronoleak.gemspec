# frozen_string_literal: true

require_relative 'lib/chronoleak/version'

Gem::Specification.new do |s|
  s.name          = 'chronoleak'
  s.version       = ChronoLeak::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'ICMP Timestamp Remote Time Leaker.'
  s.description   = 'Leaks time on a remote machine by using ICMP timestamp requests (13) and replies (14).'
  s.authors       = ['Alexandre ZANNI']
  s.email         = 'alexandre.zanni@europe.com'
  s.homepage      = 'https://github.com/noraj/ChronoLeak'
  s.license       = 'MIT'

  s.files         = Dir['bin/*'] + Dir['lib/**/*.rb'] + ['LICENSE']
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/noraj/ChronoLeak/issues',
    'changelog_uri'         => 'https://github.com/noraj/ChronoLeak/releases',
    'documentation_uri'     => 'https://noraj.github.io/chronoleak/',
    'homepage_uri'          => 'https://github.com/noraj/ChronoLeak',
    'source_code_uri'       => 'https://github.com/noraj/ChronoLeak/',
    'funding_uri'           => 'https://github.com/sponsors/noraj',
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = ['>= 3.1.0', '< 4.0']

  s.add_dependency('logger', '< 2.0')
end
