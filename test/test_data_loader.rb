# frozen_string_literal: true

require "test_helper"

class TestDataLoader < Minitest::Test
  DummyConfig = Struct.new(:raw_data, :customized_format)

  def test_data_loader_with_valid_data_in_config
    expected_data = {
      1 => ["12:00~13:00", "16:00~17:00", "18:00~19:00"],
      2 => ["12:00~13:00", "18:00~19:00"],
      3 => ["12:00~13:00", "18:00~19:00"],
      4 => ["12:00~13:00", "18:00~19:00"],
      5 => ["12:00~13:00", "18:00~19:00"]
    }
    config_data = {
      Weekday: ["12:00~13:00", "18:00~19:00"],
      Monday: ["16:00~17:00"]
    }
    config = DummyConfig.new(config_data, nil)
    data = Goldman::DataLoader.new(config).data
    assert_equal data, expected_data
  end

  def test_data_loader_with_none_data_in_config
    config_data = {}
    expected_data = {}
    config = DummyConfig.new(config_data, nil)
    data = Goldman::DataLoader.new(config).data
    assert_equal data, expected_data
  end
end
