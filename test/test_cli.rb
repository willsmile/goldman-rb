# frozen_string_literal: true

require "test_helper"

class TestCli < Minitest::Test
  def test_cli_with_default_argv
    argv = ["-g"]
    Goldman::Cli.new(argv).run
  end

  def test_cli_with_often_used_argv
    argv = ["-g", "-s", "2023-05-01", "-d", "10"]
    Goldman::Cli.new(argv).run
  end

  def test_cli_with_invalid_argv
    argv = ["-x"]
    Goldman::Cli.new(argv).run
  end

  def test_cli_with_none_of_argv
    argv = []
    Goldman::Cli.new(argv).run
  end
end
