# frozen_string_literal: true

module Goldman
  class Formatter
    DEFAULT_FORMAT = {
      schedule: "%{date}(%{wday}) %{time}",
      date: "%Y/%m/%d",
      wday: {
        Monday: "Mon",
        Tuesday: "Tue",
        Wednesday: "Wed",
        Thursday: "Thu",
        Friday: "Fri",
        Saturday: "Sat",
        Sunday: "Sun"
      }
    }

    attr_reader :customized_format, :default_format

    def initialize(customized:, default: DEFAULT_FORMAT)
      @customized_format = customized
      @default_format = default
    end

    def schedule(date, option)
      {
        date: formatted_date(date),
        wday: formatted_wday(date.cwday),
        time: option
      }
    end

    def schedule_format
      format(:schedule)
    end

    def format(target)
      return @customized_format[target] if @customized_format&.has_key?(target)

      @default_format[target]
    end

    private

    def formatted_wday(wday_num)
      wday_name = Goldman::Wday.to_name(wday_num)
      format(:wday)[wday_name]
    end

    def formatted_date(date)
      format = format(:date)
      date.strftime(format)
    end
  end
end
