# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{net-ldap}
  s.version = "0.2.0"

  s.authors = ["Francis Cianfrocca", "Emiel van de Laar", "Rory O'Connell", "Kaspar Schiess", "Austin Ziegler"]
  s.email = ["blackhedd@rubyforge.org", "gemiel@gmail.com", "rory.ocon@gmail.com", "kaspar.schiess@absurd.li", "austin@rubyforge.org"]

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = Date.today.to_s
  s.description = %q{Pure Ruby LDAP library.}
  s.files = %w(LICENSE Rakefile README.txt) + Dir.glob("{lib}/**/*")
  s.homepage = %q{http://net-ldap.rubyforge.org/}

  s.rdoc_options = ["--main", "README.txt"]

  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = %q{net-ldap}
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Pure Ruby LDAP support library with most client features and some server features.}
  s.test_files = ["test/test_entry.rb", "test/test_filter.rb", "test/test_ldif.rb", "test/test_password.rb", "test/test_rename.rb", "test/test_snmp.rb"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'flexmock'
  s.add_development_dependency 'sdoc'
end
