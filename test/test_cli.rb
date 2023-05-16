# frozen_string_literal: true

require "test_helper"

class TestCli < Minitest::Test
  def test_cli_with_default_argv
    argv = ["-g"]
    slient_output { Goldman::Cli.new(argv).run }
  end

  def test_cli_with_argv_of_start_date_and_end_date
    argv = ["-g", "-s", "2023-05-01", "-e", "2023-05-10"]
    slient_output { Goldman::Cli.new(argv).run }
  end

  def test_cli_with_argv_of_start_date_and_day
    argv = ["-g", "-s", "2023-05-01", "-d", "3"]
    slient_output { Goldman::Cli.new(argv).run }
  end

  def test_cli_with_argv_of_start_date_and_week
    argv = ["-g", "-s", "2023-05-01", "-w", "1"]
    slient_output { Goldman::Cli.new(argv).run }
  end

  def test_cli_with_invalid_argv
    argv = ["-x"]
    assert_raises OptionParser::InvalidOption do
      slient_output { Goldman::Cli.new(argv).run }
    end
  end

  def test_cli_with_none_of_argv
    argv = []
    expected_output = ""
    assert_output(expected_output) do
      Goldman::Cli.new(argv).run
    end
  end
end
