# frozen_string_literal: true

require "test_helper"

class TestDateRange < Minitest::Test
  def test_date_range_with_nil_params
    date_range = Goldman::DateRange.new(
      start_date_str: nil,
      end_date_str: nil,
      day_str: nil,
      week_str: nil
    )
    assert_equal 7, date_range.date_list.length
  end

  def test_date_range_with_options_start_date_only
    start_date = Date.new(2023, 04, 01)
    date_range = Goldman::DateRange.new(
      start_date_str: start_date.strftime("%F"),
      end_date_str: nil,
      day_str: nil,
      week_str: nil
    )
    assert_equal start_date, date_range.start_date
    assert_equal Date.new(2023, 04, 07), date_range.end_date
    assert_equal 7, date_range.date_list.length
  end

  def test_date_range_with_options_start_date_and_day
    start_date = Date.new(2023, 04, 01)
    date_range = Goldman::DateRange.new(
      start_date_str: start_date.strftime("%F"),
      end_date_str: nil,
      day_str: "10",
      week_str: nil
    )
    assert_equal start_date, date_range.start_date
    assert_equal Date.new(2023, 04, 10), date_range.end_date
    assert_equal 10, date_range.date_list.length
  end

  def test_date_range_with_options_start_date_and_week
    start_date = Date.new(2023, 04, 01)
    date_range = Goldman::DateRange.new(
      start_date_str: start_date.strftime("%F"),
      end_date_str: nil,
      day_str: nil,
      week_str: "2"
    )
    assert_equal start_date, date_range.start_date
    assert_equal Date.new(2023, 04, 14), date_range.end_date
    assert_equal 14, date_range.date_list.length
  end

  def test_date_range_with_options_start_date_and_end_date
    start_date = Date.new(2023, 04, 01)
    end_date = Date.new(2023, 04, 05)
    date_range = Goldman::DateRange.new(
      start_date_str: start_date.strftime("%F"),
      end_date_str: end_date.strftime("%F"),
      day_str: nil,
      week_str: nil
    )
    assert_equal start_date, date_range.start_date
    assert_equal end_date, date_range.end_date
    assert_equal 5, date_range.date_list.length
  end

  def test_date_range_with_options_start_date_is_after_end_date
    start_date = Date.new(2023, 04, 01)
    end_date = Date.new(2023, 03, 31)
    assert_raises Goldman::ParameterError do
      Goldman::DateRange.new(
        start_date_str: start_date.strftime("%F"),
        end_date_str: end_date.strftime("%F"),
        day_str: nil,
        week_str: nil
      )
    end
  end

  def test_date_range_with_options_invalid_start_date
    assert_raises Goldman::ParameterError do
      Goldman::DateRange.new(
        start_date_str: "invalid date",
        end_date_str: nil,
        day_str: nil,
        week_str: nil
      )
    end
  end

  def test_date_range_with_options_invalid_day
    assert_raises Goldman::ParameterError do
      Goldman::DateRange.new(
        start_date_str: nil,
        end_date_str: nil,
        day_str: "invalid day",
        week_str: nil
      )
    end
  end
end
