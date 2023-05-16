# frozen_string_literal: true

require "test_helper"

class TestConfig < Minitest::Test
  def test_config_with_valid_config_path
    path = fixture_path("config.yml")
    config = Goldman::Config.new(path: path)
    assert config.data != {}
    assert config.format != {}
  end

  def test_config_with_invalid_config_path
    path = fixture_path("no_exist_config.yml")
    assert_raises Goldman::ConfigurationError do
      Goldman::Config.new(path: path)
    end
  end
end
