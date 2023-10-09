module ContentChecker
  class Configuration
    attr_accessor :api_key, :model, :max_tokens, :temperature, :version

    def initialize
      @api_key = nil
      @model = nil
      @version = "v1"
      @max_tokens = 1
      @temperature = 0
    end
  end
end
