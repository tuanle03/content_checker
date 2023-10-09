module ContentChecker
  attr_accessor :configuration

  def self.configure
    @config ||= ContentChecker::Configuration.new
    yield(@config) if block_given?
    @config
  end

  def self.configuration
    @config
  end

end
