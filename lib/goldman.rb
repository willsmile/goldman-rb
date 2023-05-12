# frozen_string_literal: true

require_relative "goldman/config"
require_relative "goldman/data_loader"
require_relative "goldman/date_range"
require_relative "goldman/formatter"
require_relative "goldman/generator"
require_relative "goldman/version"
require_relative "goldman/wday"

module Goldman
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

  class Error < StandardError; end
  class ParameterError < Error; end
  class ConfigurationError < Error; end
  class OperationError < Error; end
end
