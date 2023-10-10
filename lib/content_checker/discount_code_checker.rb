module ContentChecker
  class DiscountCodeChecker
    API_HOST = "https://api.openai.com".freeze
    API_PATH = "/completions".freeze

    def self.check(content, model)
      url = URI("#{API_HOST}/#{ContentChecker.configuration.version}#{API_PATH}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{ContentChecker.configuration.api_key}"
      request["Content-Type"] = "application/json"
      request.body = JSON.dump({
        "model" => model,
        "max_tokens" => ContentChecker.configuration.max_tokens,
        "temperature" => ContentChecker.configuration.temperature,
        "prompt" => "#{content} ->",
      })

      response = https.request(request)
      result = JSON.parse(response.read_body)
      return result&.dig("choices", 0, "text")
    end
  end
end
