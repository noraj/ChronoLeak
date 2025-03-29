# Usage examples

## CLI

### General help

```
$ chronoleak -h
bin/chronoleak <IP_address_or_domain>

Version: 0.0.1 - ICMP Timestamp Remote Time Leaker

Nessus - ICMP Timestamp Request Remote Date Disclosure - https://www.tenable.com/plugins/nessus/10114
CVE-1999-0524 - https://www.tenable.com/cve/CVE-1999-0524
```

### Examples

```
$ chronoleak 10.10.205.11
Remote time:
23:23:00 UTC
00:23:00 CET

Local time:
23:23:01 UTC
00:23:01 CET

Time shift:
00:00:01
```

## Library

The library will only do time conversion and will not retrieve the ICMP timestamp since this requires root privileges. That's why it's handled only in the CLI with system call to `hping` and `sudo` elevation of privilege.

```ruby
require 'chronoleak'

timestamp_in_ms = 76853656

# Transform a ICMP timestamp to a Time object
remote_time = ChronoLeak.timestamp_to_time(timestamp_in_ms) # => 1970-01-01 22:20:53 +0100

# Display remote time in humanly readable format
ChronoLeak.format_time(remote_time) # => "22:20:53 CET"
```
