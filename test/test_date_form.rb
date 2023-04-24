# frozen_string_literal: true

require "test_helper"

class TestDateForm < Minitest::Test
  def test_date_form_with_empty_options
    options = {}
    default_interval_day = 6
    date_form = Goldman::DateForm.new(options)
    assert_kind_of Range, date_form.range
    assert_kind_of Date, date_form.range.first
    assert_equal default_interval_day, date_form.interval_day
  end

  def test_date_form_with_options_start_date_only
    start_date = Date.new(2023, 04, 01)
    default_interval_day = 6
    options = { start_date: start_date.strftime("%F") }
    date_form = Goldman::DateForm.new(options)
    assert_kind_of Range, date_form.range
    assert_kind_of Date, date_form.range.first
    assert_equal (start_date..start_date + default_interval_day), date_form.range
  end

  def test_date_form_with_options_start_date_and_day
    start_date = Date.new(2023, 04, 01)
    day = 7
    options = {
      start_date: start_date.strftime("%F"),
      day: day
    }
    date_form = Goldman::DateForm.new(options)
    assert_kind_of Range, date_form.range
    assert_kind_of Date, date_form.range.first
    assert_equal (start_date..start_date + day - 1), date_form.range
  end

  def test_date_form_with_options_start_date_and_week
    start_date = Date.new(2023, 04, 01)
    week = 2
    options = {
      start_date: start_date.strftime("%F"),
      week: week
    }
    date_form = Goldman::DateForm.new(options)
    assert_kind_of Range, date_form.range
    assert_kind_of Date, date_form.range.first
    assert_equal (start_date..start_date + week * 7 - 1), date_form.range
  end

  def test_date_form_with_options_start_date_and_end_date
    start_date = Date.new(2023, 04, 01)
    end_date = Date.new(2023, 04, 05)
    options = {
      start_date: start_date.strftime("%F"),
      end_date: end_date.strftime("%F")
    }
    date_form = Goldman::DateForm.new(options)
    assert_kind_of Range, date_form.range
    assert_kind_of Date, date_form.range.first
    assert_equal (start_date..end_date), date_form.range
  end

  def test_date_form_with_options_start_date_is_after_end_date
    start_date = Date.new(2023, 04, 01)
    end_date = Date.new(2023, 03, 31)
    options = {
                start_date: start_date.strftime("%F"),
                end_date: end_date.strftime("%F")
              }
    assert_raises Goldman::ParameterError do
      Goldman::DateForm.new(options)
    end
  end

  def test_date_form_with_options_invalid_start_date
    options = { start_date: "invalid date" }
    assert_raises Goldman::ParameterError do
      Goldman::DateForm.new(options)
    end
  end

  def test_date_form_with_options_invalid_day
    options = { day: "invalid day" }
    assert_raises Goldman::ParameterError do
      Goldman::DateForm.new(options)
    end
  end
end
