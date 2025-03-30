# About

## Context, why this tool exists?

Knowing the time of a remote machine is important to perform time sensitive attacks.

For example, Time-based One Time Password (TOTP) generates a code that is valid only 30 seconds, but if the remote machine time drifted because it is not using NTP or has a timezone issue (sync with hardware clock) or whatever, the attack will fail because you are not targeting the right time range.

Other examples are network protocols, some have a handcheck sensitive to time, or even for the validity of a token or certificate were you could be denied because it is no yet or no longer valid. So you could have authentication issue just because you are not synchronized with the time of the remote machine.

Hopefully, ongoing ICMP timestamp requests (13), and outgoing ICMP timestamp replies (14) are rarelly filtered, allowing to [disclose the remote machine time](https://www.tenable.com/plugins/nessus/10114) ([CVE-1999-0524](https://www.tenable.com/cve/CVE-1999-0524)) remotly while being unauthenticated.

However, it should be noted that timestamps returned from machines running some versions of Windows are deliberately incorrect within 1000 seconds of the actual system time as a protection to deafeat such attacks.

## Logo

Logo made with [DesignEvo](https://www.designevo.com).

## User documentation

The user documentation is made with [Github Pages](https://pages.github.com) powered by [Jekyll](https://jekyllrb.com),
the theme used is [Alembic](https://github.com/daviddarnes/alembic).
