# ChronoLeak

[![GitHub forks](https://img.shields.io/github/forks/noraj/chronoleak)](https://github.com/noraj/chronoleak/network)
[![GitHub stars](https://img.shields.io/github/stars/noraj/chronoleak)](https://github.com/noraj/chronoleak/stargazers)
[![GitHub license](https://img.shields.io/github/license/noraj/chronoleak)](https://github.com/noraj/chronoleak/blob/master/LICENSE)
[![Rawsec's CyberSecurity Inventory](https://inventory.raw.pm/img/badges/Rawsec-inventoried-FF5050_flat.svg)](https://inventory.raw.pm/tools.html#chronoleak)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/noraj/chronoleak/ruby.yml?branch=master)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/noraj/chronoleak)

## ICMP Timestamp Remote Time Leaker

![ChronoLeak logo](https://noraj.github.io/ChronoLeak/docs/media/chronoleak-logo.png)

> Leaks time on a remote machine by using ICMP timestamp requests (13) and replies (14).

## Context

Knowing the time of a remote machine is important to perform time sensitive attacks.

For example, Time-based One Time Password (TOTP) generates a code that is valid only 30 seconds, but if the remote machine time drifted because it is not using NTP or has a timezone issue (sync with hardware clock) or whatever, the attack will fail because you are not targeting the right time range.

Other examples are network protocols, some have a handcheck sensitive to time, or even for the validity of a token or certificate were you could be denied because it is no yet or no longer valid. So you could have authentication issue just because you are not synchronized with the time of the remote machine.

Hopefully, ongoing ICMP timestamp requests (13), and outgoing ICMP timestamp replies (14) are rarelly filtered, allowing to [disclose the remote machine time](https://www.tenable.com/plugins/nessus/10114) ([CVE-1999-0524](https://www.tenable.com/cve/CVE-1999-0524)) remotly while being unauthenticated.

However, it should be noted that timestamps returned from machines running some versions of Windows are deliberately incorrect within 1000 seconds of the actual system time as a protection to deafeat such attacks.

## Installation

```bash
gem install chronoleak
```

Check the [installation](https://noraj.github.io/ChronoLeak/docs/installation.html) page on the documentation to discover more methods.

[![Packaging status](https://repology.org/badge/vertical-allrepos/chronoleak.svg)](https://repology.org/project/chronoleak/versions)
[![Gem Version](https://badge.fury.io/rb/chronoleak.svg)](https://badge.fury.io/rb/chronoleak)
![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/noraj/chronoleak)

## Documentation

Homepage / Documentation: https://noraj.github.io/ChronoLeak/

## Author

Made by Alexandre ZANNI ([@noraj](https://pwn.by/noraj/)).
