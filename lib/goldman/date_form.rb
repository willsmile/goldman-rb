# frozen_string_literal: true

require "date"

module Goldman
  class DateForm
    def initialize(options)
      @week_num = parse_num!(options[:week], "week")
      @day_num = parse_num!(options[:day], "day") || default_day_num
      @start_date = parse_date!(options[:start_date], "start_date") || today
      @end_date = parse_date!(options[:end_date], "end_date")
      validate_end_date!
    end

    def range
      return @start_date..@end_date if @end_date

      @start_date..(@start_date + interval_day)
    end

    def interval_day
      return @week_num * 7 - 1 if @week_num

      @day_num - 1
    end

    private

    def validate_end_date!
      return if @end_date.nil?

      err_msg = "The date in start_date (#{@start_date}) should be before the date in end_date (#{@end_date})."
      raise Goldman::ParameterError.new(err_msg) if @start_date > @end_date
    end

    def parse_date!(str, source)
      return if str.nil?

      begin
        Date.parse(str)
      rescue Date::Error, TypeError
        raise Goldman::ParameterError.new("The parameter of #{source} (#{str}) is invalid.")
      end
    end

    def parse_num!(str, source)
      return if str.nil?

      begin
        Integer(str)
      rescue ArgumentError, TypeError
        raise Goldman::ParameterError.new("The parameter of #{source} (#{str}) is invalid.")
      end
    end

    def today
      Date.today
    end

    def default_day_num
      7
    end
  end
end
