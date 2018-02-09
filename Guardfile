guard :rspec, cmd: 'bundle exec rspec' do
  # spec helpers
  watch('spec/spec_helper.rb')                        { "spec" }

  # app
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }

  # lib
  watch(%r{^lib/(.+)\.rb$})                           { |m| "spec/lib/#{m[1]}_spec.rb" }

  # specs
  watch(%r{^spec/.+_spec\.rb$})
end
