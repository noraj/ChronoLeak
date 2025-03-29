#!/usr/bin/env ruby
# frozen_string_literal: true

# Standard library
require 'logger'
require 'open3'
require 'time'
# Project internal
require 'chronoleak/version'

# Display ICMP timestamp in human form
module ChronoLeak
  # @param timestamp_ms [Integer]
  # @return [Time]
  def self.timestamp_to_time(timestamp_ms)
    seconds_since_midnight = timestamp_ms / 1000
    Time.at(seconds_since_midnight)
  end

  # @param timestamp_ms [Integer]
  # @return [String]
  def self.timestamp_to_time_bis(timestamp_ms)
    timestamp_h = timestamp_ms / 3_600_000.0
    hours = timestamp_h.to_i
    minutes_f = (timestamp_h - hours) * 60
    minutes = minutes_f.to_i
    seconds = ((minutes_f - minutes) * 60).to_i
    format('%<h>02d:%<m>02d:%<s>02d', h: hours, m: minutes, s: seconds)
  end

  # @param timestamp_ms [Integer]
  # @return [String]
  def self.timestamp_to_time_ter(timestamp_ms)
    total_seconds = timestamp_ms / 1000
    hours = (total_seconds / 3600).floor % 24
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60
    format('%<h>02d:%<m>02d:%<s>02d', h: hours, m: minutes, s: seconds)
  end

  # @param timestamp_ms [Integer]
  def self.display_times(timestamp_ms)
    remote_time = timestamp_to_time(timestamp_ms)
    puts TermLog.colorize(:blue, 'Remote time:')
    puts format_time(remote_time.utc)
    puts format_time(remote_time.getlocal)
    puts
    puts TermLog.colorize(:blue, 'Local time:')
    mytime = Time.now
    puts format_time(mytime.utc)
    puts format_time(mytime.getlocal)
    puts
    puts TermLog.colorize(:blue, 'Time shift:')
    puts time_diff(remote_time, mytime)
  end

  # @param time [Time]
  def self.format_time(time)
    "#{time.strftime('%H:%M:%S')} #{time.zone}"
  end

  # @param time_a [Time]
  # @param time_b [Time]
  # @return [String]
  def self.time_diff(time_a, time_b)
    a = Time.new(1970, 1, 1, time_a.hour, time_a.min, time_a.sec)
    b = Time.new(1970, 1, 1, time_b.hour, time_b.min, time_b.sec)
    diff = a > b ? a - b : b - a
    Time.at(diff).utc.strftime('%H:%M:%S')
  end

  # Wrapper around the Logger class to get shorter syntax
  class TermLog
    COLORS = {
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      pink: 35,
      light_blue: 36
    }.freeze

    def initialize
      @logger = Logger.new($stdout)
    end

    def self.colorize(color, msg)
      "\e[#{COLORS[color]}m#{msg}\e[0m"
    end

    def fatal(msg)
      @logger.fatal(TermLog.colorize(:red, msg))
    end

    def close
      @logger.close
    end
  end
end
