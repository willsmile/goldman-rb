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

# Borrow from the following gist (thanks and respect)
# https://gist.github.com/moertel/11091573
def slient_output
  original_stdout, original_stderr = $stdout.clone, $stderr.clone
  $stderr.reopen File.new("/dev/null", "w")
  $stdout.reopen File.new("/dev/null", "w")
  yield
ensure
  $stdout.reopen original_stdout
  $stderr.reopen original_stderr
end
