# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "goldman"

require "minitest/autorun"

GOLDMAN_TEST_DIR = File.absolute_path __dir__

def testdir
  GOLDMAN_TEST_DIR
end

def fixturedir
  File.join testdir, "fixtures"
end

def fixture_path(filename)
  File.join fixturedir, filename
end
