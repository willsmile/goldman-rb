# frozen_string_literal: true

require "test_helper"

class TestFormatter < Minitest::Test
  def test_formatter_with_valid_customized_format
    format = {
      schedule: "%{date}(%{wday}) %{time}",
      date: "%Y-%m-%d",
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
    formatter = Goldman::Formatter.new(customized: format)
    assert formatter.customized_format != nil
    assert_equal "%Y-%m-%d", formatter.format(:date)
  end

  def test_formatter_with_part_customized_format
    format = {
      schedule: "%{date}, %{wday} %{time}",
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
    formatter = Goldman::Formatter.new(customized: format)
    assert formatter.customized_format != nil
    assert_equal "%Y/%m/%d", formatter.format(:date)
    assert_equal "%{date}, %{wday} %{time}", formatter.format(:schedule)
  end

  def test_formatter_with_none_customized_format
    formatter = Goldman::Formatter.new(customized: nil)
    assert_nil formatter.customized_format
    assert_equal "%Y/%m/%d", formatter.format(:date)
  end
end
