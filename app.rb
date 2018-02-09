require 'logger'
require 'active_support'
require 'active_support/dependencies'
require 'active_support/inflector'
require 'active_support/core_ext/hash/keys'

module App extend self
  attr_reader :env
  @env = ENV['APP_ENV'] || 'development'

  attr_reader :root
  @root = File.expand_path('..', __FILE__)

  attr_reader :load_paths
  @load_paths = %W(
    #{root}/app
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
    load_config
  end

  private

  def setup_autoload
    ActiveSupport::Dependencies.autoload_paths += @load_paths
  end

  def load_config
    Dir["#{File.join(@root, 'config', '*.rb')}"].each do |file|
      require file
    end
  end
end