# frozen_string_literal: true

require "test_helper"

class TestFormatter < Minitest::Test
  DummyConfig = Struct.new(:raw_data, :customized_format)

  def test_formatter_with_valid_customized_format
    format = {
      schedule: "%{date}(%{wday}) %{time}",
      date: "%Y-%m-%d",
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
    config = DummyConfig.new(nil, format)
    formatter = Goldman::Formatter.new(config)
    assert formatter.customized_format != nil
    assert_equal "%Y-%m-%d", formatter.format(:date)
  end

  def test_formatter_with_part_customized_format
    format = {
      schedule: "%{date}, %{wday} %{time}",
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
    config = DummyConfig.new(nil, format)
    formatter = Goldman::Formatter.new(config)
    assert formatter.customized_format != nil
    assert_equal "%Y/%m/%d", formatter.format(:date)
    assert_equal "%{date}, %{wday} %{time}", formatter.format(:schedule)
  end

  def test_formatter_with_none_customized_format
    config = DummyConfig.new(nil, nil)
    formatter = Goldman::Formatter.new(config)
    assert_nil formatter.customized_format
    assert_equal "%Y/%m/%d", formatter.format(:date)
  end
end
