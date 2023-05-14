# frozen_string_literal: true

require "test_helper"

class TestScheduleList < Minitest::Test
  def test_schedule_list_with_valid_data_in_config
    date_april_1st = Date.new(2023, 04, 01)
    date_april_2nd = Date.new(2023, 04, 02)
    date_april_3rd = Date.new(2023, 04, 03)
    date_april_4th = Date.new(2023, 04, 04)
    schedule1 = Goldman::ScheduleList::Schedule.new(date_april_3rd, "12:00~13:00")
    schedule2 = Goldman::ScheduleList::Schedule.new(date_april_3rd, "16:00~17:00")
    schedule3 = Goldman::ScheduleList::Schedule.new(date_april_3rd, "18:00~19:00")
    schedule4 = Goldman::ScheduleList::Schedule.new(date_april_4th, "12:00~13:00")
    schedule5 = Goldman::ScheduleList::Schedule.new(date_april_4th, "18:00~19:00")

    expected_data = [schedule1, schedule2, schedule3, schedule4, schedule5]
    data = {
      Weekday: ["12:00~13:00", "18:00~19:00"],
      Monday: ["16:00~17:00"]
    }

    dates = (date_april_1st..date_april_4th).to_a
    list = Goldman::ScheduleList.new(data: data, dates: dates).generate
    assert_equal list, expected_data
  end

  def test_schedule_list_with_none_data_in_config
    expected_data = []
    list = Goldman::ScheduleList.new(data: {}, dates: []).generate
    assert_equal list, expected_data
  end
end
