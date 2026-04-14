# `skychengzeng` botnet investigation

This repository contains an investigation into a coordinated spam network using GitHub repositories to distribute short-links and manipulate search ranking.

## TL;DR

The observed activity appears to be a coordinated SEO spam operation:

- Large numbers of low-activity GitHub accounts are created with near-identical README templates.
- Repositories include AI-generated motivational text followed by `.cn` short-links.
- Domains resolve to a sequential IP block and share the same nameserver infrastructure.
- Redirect endpoints show behavior consistent with gated traffic handling and analytics tracking.

## What this report covers

- How the account pattern was identified
- Why `skychengzeng` appears to be an early/seed account in the network
- Domain, DNS, WHOIS, and server-response evidence
- Likely campaign purpose and abuse-response recommendations

## Full report

Please read the full PDF for complete evidence, screenshots, and technical details:

- [main.pdf](main.pdf)

(Authoring source is available in [main.typ](main.typ).)
