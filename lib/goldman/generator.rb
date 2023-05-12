# frozen_string_literal: true

require "date"

module Goldman
  class Generator
    def initialize(data, formatter, date_list)
      @data = data
      @formatter = formatter
      @date_list = date_list
    end

    def exec
      raise Goldman::OperationError.new("No data for schedule. Please define them in the config file.") if @data.empty?

      @date_list.each do |date|
        @data[date.cwday]&.each do |time|
          @formatter.schedule(date, time)
        end
      end
    end
  end
end
