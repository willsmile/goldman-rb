# frozen_string_literal: true

require "psych"

module Goldman
  class Config
    attr_reader :data, :format

    def initialize(path:)
      @path = path
      @config = load_file
      @data = load_data
      @format = load_format
    end

    private

    def load_file
      Psych.safe_load_file(@path, symbolize_names: true)
    end

    def load_data
      return {} unless @config.has_key?(:data)

      @config[:data]
    end

    def load_format
      return {} unless @config.has_key?(:format)

      @config[:format]
    end
  end
end
