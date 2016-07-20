require_relative "lib/whitespace/version"

Gem::Specification.new do |s|
  s.author = "Dwayne Crooks"
  s.email  = "me@dwaynecrooks.com"

  s.description = <<-DESCRIPTION.strip.gsub(/\s+/, " ")
    An interpreter written in Ruby for the imperative,
    stack based language called Whitespace.
  DESCRIPTION

  s.summary  = "A Whitespace interpreter written in Ruby"
  s.homepage = "https://github.com/dwayne/whitespace-ruby"
  s.license  = "MIT"

  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")

  s.name          = "whitespace-ruby"
  s.require_paths = ["lib"]
  s.version       = Whitespace::VERSION

  s.required_ruby_version = ">= 2.3"

  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "minitest", "~> 5.9"
  s.add_development_dependency "pry-byebug", "~> 3.4"
  s.add_development_dependency "rake", "~> 11.2"
end
