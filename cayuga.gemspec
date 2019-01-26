lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cayuga/version'

Gem::Specification.new do |spec|
  spec.name = 'cayuga'
  spec.version = Cayuga::VERSION
  spec.authors = ['patrick']
  spec.email = ['peateas@gmail.com']
  spec.summary = 'Holder for Cayuga applications and utilities.'
  spec.homepage = ''

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host' to allow pushing to a single host or delete this section
  # to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "http://rubygems.org"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been
  # added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features|.idea|bin)/})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'facets', '~>3.1'
  spec.add_runtime_dependency 'ice_nine', '~>0.11'
  spec.add_runtime_dependency 'puma', '~> 3.0'
  spec.add_runtime_dependency 'semantic_logger', '~>4.3'
  spec.add_runtime_dependency 'sinatra', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'capybara', '~> 3.0'
  spec.add_development_dependency 'file-tail', '~>1.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'selenium-webdriver', '~> 3.0'

end
