# frozen_string_literal: true

require "test_helper"

class TestGenerator < Minitest::Test

  def test_generator_with_data
    expected_output = "2023/04/03(月) 12:00~13:00\n"\
                      "2023/04/03(月) 16:00~17:00\n"\
                      "2023/04/03(月) 18:00~19:00\n"\
                      "2023/04/04(火) 12:00~13:00\n"\
                      "2023/04/04(火) 18:00~19:00\n"\
                      "2023/04/05(水) 12:00~13:00\n"\
                      "2023/04/05(水) 18:00~19:00\n"
    path = fixture_path("config.yml")
    date_list = Goldman::DateRange.new(start_date_str: "2023-04-01",
                                       end_date_str: "2023-04-05",
                                       day_str: nil,
                                       week_str: nil).date_list
    config = Goldman::Config.new(path: path)
    formatter = Goldman::Formatter.new(customized: config.customized_format)
    data = Goldman::DataLoader.new(config).data
    generator = Goldman::Generator.new(data, formatter, date_list)
    output, _ = capture_io do
      generator.exec
    end
    assert_equal expected_output, output
  end

  def test_generator_without_data
    path = fixture_path("no_data_config.yml")
    date_list = Goldman::DateRange.new(start_date_str: "2023-04-01",
                                       end_date_str: "2023-04-05",
                                       day_str: nil,
                                       week_str: nil).date_list
    config = Goldman::Config.new(path: path)
    formatter = Goldman::Formatter.new(customized: config.customized_format)
    data = Goldman::DataLoader.new(config).data
    generator = Goldman::Generator.new(data, formatter, date_list)
    assert_raises Goldman::OperationError do
      generator.exec
    end
  end
end
