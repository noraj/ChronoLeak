# frozen_string_literal: true

require 'minitest/autorun'
require 'chronoleak'

class ChronoLeakTest < Minitest::Test
  def test_chronoleak_timestamp_to_time
    assert_equal(Time.new(1970, 1, 1, 21, 20, 53, '+00:00'), ChronoLeak.timestamp_to_time(76_853_656))
  end

  def test_chronoleak_timestamp_to_time_alt
    assert_equal('21:20:53', ChronoLeak.timestamp_to_time_bis(76_853_656))
    assert_equal('21:20:53', ChronoLeak.timestamp_to_time_ter(76_853_656))
  end

  def test_chronoleak_format_time
    # hard to test since it will depends on local timezone of the test machine
    # setting TZ in "+01:00" is not enough to get TZ name
    # for that it requires a TZ library, which is overkill just to test this
  end

  def test_chronoleak_time_diff
    time_a = Time.new(1970, 1, 1, 21, 20, 53)
    time_b = Time.new(1970, 1, 1, 21, 20, 54)
    assert_equal('00:00:01', ChronoLeak.time_diff(time_a, time_b))
    assert_equal('00:00:01', ChronoLeak.time_diff(time_b, time_a))
  end
end
