# frozen_string_literal: true

require_relative "goldman/config"
require_relative "goldman/date_range"
require_relative "goldman/formatter"
require_relative "goldman/presenter"
require_relative "goldman/schedule_list"
require_relative "goldman/version"
require_relative "goldman/wday"

module Goldman
  class Error < StandardError; end
  class ParameterError < Error; end
  class ConfigurationError < Error; end
  class OperationError < Error; end
end
