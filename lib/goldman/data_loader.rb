# frozen_string_literal: true

module Goldman
  class DataLoader
    def initialize(config)
      @raw_data = config.raw_data
    end

    def data
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

    private

    def sort(periods)
      periods.sort_by { _1.split(":").first.to_i }
    end

    def wday(name)
      @raw_data[name]
    end

    def weekday
      @raw_data[:Weekday]
    end

    def weekend
      @raw_data[:Weekend]
    end

    def everyday
      @raw_data[:Everyday]
    end
  end
end
