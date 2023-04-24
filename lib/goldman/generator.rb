# frozen_string_literal: true

require "date"

module Goldman
  class Generator
    def initialize(data, formatter, date_form)
      @data = data
      @formatter = formatter
      @date_form = date_form
    end

    def exec
      raise Goldman::OperationError.new("No data for schedule. Please define them in the config file.") if @data.empty?

      @date_form.range.each do |date|
        @data[date.cwday]&.each do |time|
          @formatter.schedule(date, time)
        end
      end
    end
  end
end
