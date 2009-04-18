# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{syscmd}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Till Salzer"]
  s.date = %q{2009-04-18}
  s.email = %q{till.salzer@googlemail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "lib/syscmd", "lib/syscmd/popen.rb", "lib/syscmd.rb", "spec/command_exec_spec.rb", "spec/command_spec.rb", "spec/spec_helper.rb", "spec/syscmd_spec.rb", "spec/tester.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tsalzer/syscmd}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Wrapper for OS command execution}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
