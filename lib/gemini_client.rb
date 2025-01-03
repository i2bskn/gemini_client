# frozen_string_literal: true

require "net/http"
require "json"

require_relative "gemini_client/version"

class GeminiClient
  class Error < StandardError; end

  module Model
    GEMINI_1_5_FLASH = "gemini-1.5-flash"
  end

  module Method
    GENERATE_CONTENT = "generateContent"
  end

  API_VERSION = "v1beta".freeze

  def initialize(api_key:, version: API_VERSION, model: Model::GEMINI_1_5_FLASH)
    @api_key = api_key
    @version = version
    @model = model
  end

  def generate_content(payload:, model: nil)
    url = api_url(api_key: @api_key, version: @version, model: model || @model, method_name: Method::GENERATE_CONTENT)
    request(:post, url, payload: JSON.dump(payload), headers: { "Content-Type" => "application/json" })
  end

  def stream_generate_content
    # TODO
  end

  def count_tokens
    # TODO
  end

  def embed_content
    # TODO
  end

  def models
    # TODO
  end

  def model_info(model)
    # TODO
  end

  private

    def api_url(api_key:, version:, model: nil, method_name: nil)
      model_and_method = [model, method_name].compact.join(":")
      "https://generativelanguage.googleapis.com/#{version}/models/#{model_and_method}?key=#{api_key}"
    end

    def request(meth, url, options = {})
      url = URI.parse(url)
      # query strings
      url.query = URI.encode_www_form(options.fetch(:query)) if options.key?(:query)
      req = Net::HTTP.const_get(meth.to_s.capitalize).new(url.request_uri)
      # request http headers
      (options[:headers] || {}).each { |k, v| req[k.to_s] = v }
      # Authorization
      req["Authorization"] = options.fetch(:auth) if options.key?(:auth)
      # Basic Authentication
      req.basic_auth(options.fetch(:user), options.fetch(:password)) if options.key?(:user) && options.key?(:password)
      case
      when options.key?(:form)
        # form data
        req.set_form_data(options.fetch(:form))
      when options.key?(:payload)
        # payload
        req.body = options.fetch(:payload)
      end

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = url.is_a?(URI::HTTPS)
      http.request(req)
    end
end
