# frozen_string_literal: true

require_relative "goldman/config"
require_relative "goldman/data_loader"
require_relative "goldman/date_form"
require_relative "goldman/formatter"
require_relative "goldman/generator"
require_relative "goldman/version"
require_relative "goldman/wday"

module Goldman
  DEFAULT_FORMAT = {
    schedule: "%{date}(%{wday}) %{time}",
    date: "%Y/%m/%d",
    wday: {
      monday: "Mon",
      tuesday: "Tue",
      wednesday: "Wed",
      thursday: "Thu",
      friday: "Fri",
      saturday: "Sat",
      sunday: "Sun"
    }
  }

  class Error < StandardError; end
  class ParameterError < Error; end
  class ConfigurationError < Error; end
  class OperationError < Error; end
end
