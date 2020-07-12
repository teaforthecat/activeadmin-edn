require File.expand_path('../lib/active_admin/edn/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'activeadmin-edn'
  s.version = ActiveAdmin::Edn::VERSION
  s.author = 'teaforthecat'
  s.email = 'teaforthecat@gmail.com'
  s.homepage = 'https://github.com/teaforthecat/activeadmin-edn'
  s.platform = Gem::Platform::RUBY
  s.date = Time.now.strftime('%Y-%m-%d')
  s.license = 'MIT'
  s.summary = <<-SUMMARY
  Adds excel (edn) downloads for resources within the Active Admin framework.
  SUMMARY
  s.description = <<-DESC
  This gem provides excel/edn downloads for resources in Active Admin.
  DESC

  git_tracked_files = `git ls-files`.split("\n").sort
  gem_ignored_files = `git ls-files -i -X .gemignore`.split("\n")

  s.files = git_tracked_files - gem_ignored_files

  s.add_runtime_dependency 'activeadmin', '>= 1.0.0'
  s.add_runtime_dependency 'edn', '~> 1.1.1'

  s.required_ruby_version = '>= 2.0.0'
  s.require_path = 'lib'
end
