# frozen_string_literal: true

require "date"

module Goldman
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date_str:, end_date_str:, day_str:, week_str:)
      @week = to_integer!(week_str, "week") || default_week
      @day = to_integer!(day_str, "day") || default_day
      @start_date = to_date!(start_date_str, "start_date") || default_start_date
      @end_date = to_date!(end_date_str, "end_date") || calculate_end_date
      validate!
    end

    def to_array
      (@start_date..@end_date).to_a
    end

    alias_method :to_a, :to_array

    private

    def calculate_end_date
      if @week > 0
        @start_date + @week * 7 - 1
      elsif @day > 0
        @start_date + @day - 1
      else
        nil
      end
    end

    def validate!
      if @end_date.nil?
        end_date_err_msg = "The parameter of week (#{@week}) or day (#{@day}) is invalid."
        raise Goldman::ParameterError.new(end_date_err_msg)
      elsif @start_date > @end_date
        date_range_err_msg = "The start_date (#{@start_date}) should be before end_date (#{@end_date})."
        raise Goldman::ParameterError.new(date_range_err_msg)
      end
    end

    def to_date!(str, source)
      return if str.nil?

      begin
        Date.parse(str)
      rescue Date::Error, TypeError
        raise Goldman::ParameterError.new("The parameter of #{source} (#{str}) is invalid.")
      end
    end

    def to_integer!(str, source)
      return if str.nil?

      begin
        Integer(str)
      rescue ArgumentError, TypeError
        raise Goldman::ParameterError.new("The parameter of #{source} (#{str}) is invalid.")
      end
    end

    def default_start_date
      Date.today
    end

    def default_week
      0
    end

    def default_day
      7
    end
  end
end
