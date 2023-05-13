# frozen_string_literal: true

require "date"

module Goldman
  class Presenter
    def initialize(schedules:, formatter:, date_list:)
      @schedules = schedules
      @formatter = formatter
      @date_list = date_list
    end

    def exec
      raise Goldman::OperationError.new("No data for schedule. Please define them in the config file.") \
        if @schedules.empty?

      @date_list.each do |date|
        @schedules[date.cwday]&.each do |time|
          @formatter.schedule(date, time)
        end
      end
    end
  end
end
