# frozen_string_literal: true

require "test_helper"

class TestSchedule < Minitest::Test
  def test_schedule_with_valid_data_in_config
    expected_data = {
      1 => ["12:00~13:00", "16:00~17:00", "18:00~19:00"],
      2 => ["12:00~13:00", "18:00~19:00"],
      3 => ["12:00~13:00", "18:00~19:00"],
      4 => ["12:00~13:00", "18:00~19:00"],
      5 => ["12:00~13:00", "18:00~19:00"]
    }
    data = {
      Weekday: ["12:00~13:00", "18:00~19:00"],
      Monday: ["16:00~17:00"]
    }
    schedules = Goldman::Schedule.new(data: data).generate
    assert_equal schedules, expected_data
  end

  def test_schedule_with_none_data_in_config
    expected_data = {}
    schedules = Goldman::Schedule.new(data: {}).generate
    assert_equal schedules, expected_data
  end
end
