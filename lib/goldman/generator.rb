# frozen_string_literal: true

module Goldman
  class Generator
    attr_reader :schedules

    def initialize(data:)
      @data = data
      @schedules = load_schedules
    end

    private

    def load_schedules
      result = {}
      Goldman::Wday.members.each do |w|
        periods = []
        periods += wday(w) unless wday(w).nil?
        periods += everyday unless everyday.nil?
        periods += weekday if Goldman::Wday.weekday?(w) && !weekday.nil?
        periods += weekend if Goldman::Wday.weekend?(w) && !weekend.nil?
        result[Goldman::Wday.to_num(w)] = sort(periods) unless periods.empty?
      end

      result
    end

    def sort(periods)
      periods.sort_by { _1.split(":").first.to_i }
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
