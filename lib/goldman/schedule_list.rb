# frozen_string_literal: true

module Goldman
  class ScheduleList
    Schedule = Struct.new(:date, :option)

    def initialize(data:, dates:)
      @data = data
      @dates = dates
    end

    def generate
      return [] if @data.nil? || @data.empty?

      list = []
      @dates.each do |date|
        options = select_options_by_date(date)
        next if options.empty?
        sorted_options = sort(options)
        sorted_options.each do |option|
          list << Schedule.new(date, option)
        end
      end

      list
    end

    private

    def select_options_by_date(date)
      options = []
      wday_name = Goldman::Wday.to_name(date.cwday)
      options += wday(wday_name) unless wday(wday_name).nil?
      options += everyday unless everyday.nil?
      options += weekday if Goldman::Wday.weekday?(wday_name) && !weekday.nil?
      options += weekend if Goldman::Wday.weekend?(wday_name) && !weekend.nil?

      return options
    end

    def sort(options)
      options.sort_by { _1.split(":").first.to_i }
    end

    def wday(name)
      @data[name]
    end

    def weekday
      @data[:Weekday]
    end

    def weekend
      @data[:Weekend]
    end

    def everyday
      @data[:Everyday]
    end
  end
end
