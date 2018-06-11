require 'logger'
require 'active_support'
require 'active_support/dependencies'
require 'active_support/inflector'
require 'active_support/core_ext/hash/keys'

module App extend self
  attr_reader :env
  @env = ENV['APP_ENV'] || 'development'

  attr_reader :root
  @root = Pathname.new(File.expand_path('..', __FILE__))

  attr_reader :load_paths
  @load_paths = %W(
    #{root}/app
    #{root}/lib
  )

  attr_reader :log_level
  @log_level = ENV['LOG_LEVEL'] || 'debug'

  attr_reader :logger
  @logger = Logger.new("#{root}/log/#{env}.log")
  @logger.level = "Logger::#{log_level.upcase}".constantize

  def boot!
    load_paths.each do |path|
      $LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)
    end

    setup_autoload
    run_initializers
  end

  private

  def setup_autoload
    ActiveSupport::Dependencies.autoload_paths += @load_paths
  end

  def run_initializers
    Dir["#{File.join(@root, 'config', 'initializers', '*.rb')}"].each do |file|
      require file
    end
  end
end
