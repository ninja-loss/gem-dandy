# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gem-dandy}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["ninja-loss"]
  s.date = %q{2010-11-09}
  s.default_executable = %q{gemdandy}
  s.description = %q{Enjoy Gem management.}
  s.email = %q{ninja-loss@gmail.com}
  s.executables = ["gemdandy"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/gemdandy",
     "gem-dandy.gemspec",
     "lib/gem_dandy.rb",
     "lib/gem_dandy/command.rb",
     "lib/gem_dandy/config_file.rb",
     "lib/gem_dandy/configuration.rb",
     "lib/gem_dandy/output.rb",
     "lib/gem_dandy/rubyforge_profile.rb",
     "spec/gem-dandy_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/midas/gem-dandy}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Utilities to use to manage your gems.}
  s.test_files = [
    "spec/gem-dandy_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_runtime_dependency(%q<trollop>, ["= 1.16.2"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<trollop>, ["= 1.16.2"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<trollop>, ["= 1.16.2"])
  end
end
