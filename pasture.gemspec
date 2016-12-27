lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'pasture'
  spec.version = '0.0.0'
  spec.authors = ['Kevin Henner']
  spec.email = ['kevin@puppetlabs.com']
  spec.summary = 'Cowsay as a service (CaaS).'
  spec.description = "Pasture provides a RESTful API to serve all your cowsay needs."
  spec.homepage = 'http://github.com/puppetlabs/pltraining-pasture'
  spec.license = 'Apache 2.0'

  spec.files = %w( README.md LICENSE )
  spec.files += Dir['{bin,lib}/**/*']
  spec.executables = ['pasture']
  spec.require_paths = ['lib']
  spec.add_dependency 'cowsay', '~> 0.3' 
  spec.add_dependency 'gli', '~> 2.12'
  spec.add_dependency 'sinatra', '~> 1.4'
  spec.add_dependency 'mono_logger', '~> 1.1'
end
