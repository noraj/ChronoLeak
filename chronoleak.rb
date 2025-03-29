#!/usr/bin/env ruby
# frozen_string_literal: true

require 'logger'
require 'open3'
require 'time'

module ChronoLeak
  VERSION = '0.0.1'

  # @return [Time]
  def self.timestamp_to_time(timestamp_ms)
    seconds_since_midnight = timestamp_ms / 1000
    Time.at(seconds_since_midnight)
  end

  # @return [String]
  def self.timestamp_to_time_bis(timestamp_ms)
    timestamp_h = timestamp_ms / 3_600_000.0
    hours = timestamp_h.to_i
    minutes_f = (timestamp_h - hours) * 60
    minutes = minutes_f.to_i
    seconds = ((minutes_f - minutes) * 60).to_i
    sprintf("%02d:%02d:%02d", hours, minutes, seconds)
  end

  # @return [String]
  def self.timestamp_to_time_ter(timestamp_ms)
    total_seconds = timestamp_ms / 1000
    hours = (total_seconds / 3600).floor % 24
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60
    sprintf("%02d:%02d:%02d", hours, minutes, seconds)
  end

  def self.display_times(timestamp_ms)
    remote_time = timestamp_to_time(timestamp_ms)
    puts TermLog.colorize(:blue, "Remote time:")
    puts format_time(remote_time.utc)
    puts format_time(remote_time.getlocal)
    puts
    puts TermLog.colorize(:blue, "Local time:")
    mytime = Time.now
    puts format_time(mytime.utc)
    puts format_time(mytime.getlocal)
    puts
    puts TermLog.colorize(:blue, "Time shift:")
    puts time_diff(remote_time, mytime)
  end

  # @param [Time] time
  def self.format_time(time)
    "#{time.strftime("%H:%M:%S")} #{time.zone}"
  end

  # @param [Time] time_a
  # @param [Time] time_b
  # @return [String]
  def self.time_diff(time_a, time_b)
    a = Time.new(1970,1,1,time_a.hour,time_a.min,time_a.sec)
    b = Time.new(1970,1,1,time_b.hour,time_b.min,time_b.sec)
    Time.at(b - a).utc.strftime("%H:%M:%S")
  end

  class TermLog
    COLORS = {
      red: 31,
      green: 32,
      yellow: 33,
      blue: 34,
      pink: 35,
      light_blue: 36
    }

    def initialize
      @logger = Logger.new(STDOUT)
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

if __FILE__ == $PROGRAM_NAME
  log = ChronoLeak::TermLog.new
  if ARGV.size == 1
    ip_addr = ARGV.first
    hping = "sudo hping3 #{ip_addr} --icmp --icmp-ts -c 1"
    out = ''
    Open3.popen3(hping) do |stdin, stdout, stderr, thread|
      out = stdout.read
      err = stderr.read
      if /hping3: command not found/.match?(err)
        log.fatal "hping not installed - 'hping3' command must be accessible in PATH"
        log.fatal 'See the package for your distro on https://repology.org/project/hping/versions.'
        raise(StandardError, "Command failed: #{hping}")
      elsif /100\% packet loss/.match?(err)
        log.fatal 'ICMP timestamp requests (13) or ICMP timestamp replies (14) filtered.'
        raise(StandardError, "hping command executed successfully but received no response.")
      end
    end
    timestamp_ms = out.match(/Transmit=(?<timestamp>\d+)/)[:timestamp].to_i
    puts ChronoLeak.display_times(timestamp_ms)
  else
    puts "#{__FILE__} <IP_address_or_domain>"
    puts
    puts "Version: #{ChronoLeak::VERSION} - ICMP Timestamp Remote Time Leaker"
    puts
    puts "Nessus - ICMP Timestamp Request Remote Date Disclosure - https://www.tenable.com/plugins/nessus/10114"
    puts "CVE-1999-0524 - https://www.tenable.com/cve/CVE-1999-0524"
  end
  log.close
end
