#let conf(doc) = {
  set text(lang: "en", region: "gb", font: "New Computer Modern")
  set block(above: 1em)
  set page(margin: 35pt)
  set par(linebreaks: "optimized", justify: true)

  set quote(block: true)
  show quote: set pad(top: -1em)

  show heading.where(level: 1): set text(size: 1.5em)
  show heading.where(level: 2): set text(size: 1.3em)
  show heading.where(level: 3): set text(size: 1.2em)
  show heading.where(level: 4): set text(size: 1.1em)

  // pagebraks after second-level headings except the first one
  let saw-first-h2 = state("saw-first-h2", false)

  show heading.where(level: 2): it => context {
    if saw-first-h2.get() { pagebreak(weak: true) }
    else { saw-first-h2.update(true) }
    it
  }

  set table.vline(stroke: 0.75pt + black)
  set table.hline(stroke: 0.75pt + black)
  set table(stroke: (x, y) => (
    left: if x > 0 { 0.5pt + rgb(100, 100, 100)},
    top: if y > 0 { 0.5pt + rgb(100, 100, 100)},
  ))
  show table.cell.where(y: 0): set text(weight: 700)

  show figure.caption: set text(size: 0.75em, fill: rgb(100, 100, 100))

  show link: underline

  doc
}
#show: conf

#align(center)[
  = An analysis on the `skychengzeng` botnet
  Parmjot Singh --- `parmjotsinghrobot` \
  #datetime.today().display("[day] [month repr:long] [year]")
]

#emph[Note: Parts of the discovery and investigation in this report were done with assistance from Claude Sonnet 4.6.]

== Background

I was looking into one of the repositories I was working on (#link("https://github.com/ithinkihave/ithinkihavediscord")[`ithinkihave/ithinkihavediscord`]), and searching the phrase `is this true` on GitHub. This is where I first encountered a string of suspicious repositories.

#figure(
  image("img/is-this-true-search.png", width: 80%),
  caption: [GitHub search results for `is this true`, showing multiple repositories with identical README structure]
)

#figure(
  image("img/repo-with-links.png", width: 80%),
  caption: [One of the repositories, showing the block of motivational text and the list of short-links, found at #link("https://github.com/Sallyarner/w0e_etry")[Sallyarner/w0e_etry]]
)

The repositories shared a clear template: a block of motivational text followed by a list of short-links under `.cn` domains. After finding these, I searched the phrase:

#quote[
  The beauty of life comes from genuine interaction; no matter how ordinary the action,
]

on GitHub, sorted by recently updated. At the last page of results, I found the account `skychengzeng`, whose repositories were all created within the past few days and matched the same README pattern exactly. This account appears to be the seed account for the wider network.

#figure(
  image("img/skychengzeng-first-spotting.png", width: 80%),
  caption: [GitHub repository search for the motivational phrase, sorted by recently updated. The last page of results reveals `skychengzeng`. Two of its repositories appear in the final three results, suggesting it is the oldest account using this template and likely the seed for the wider network.]
)

== The seed account: `skychengzeng`

Every other account in this botnet appears to follow the same pattern, apart from `skychengzeng`. They have created various repositories which appear to be genuine projects, with real-looking READMEs, but everything falls apart as soon as you look at the code, or lack thereof. The repositories are all empty, with no commits other than the initial README.

#figure(
  image("img/skychengzeng-profile.png", width: 80%),
  caption: [Profile view of the `skychengzeng` account]
)

#figure(
  grid(
    columns: 4,
    column-gutter: 1em,
    row-gutter: 1em,
    link("https://github.com/skychengzeng/clustering-javascript")[#image("img/skychengzeng-repos/clustering-javascript.png")],
    link("https://github.com/skychengzeng/infrastructure")[#image("img/skychengzeng-repos/infrastructure.png")],
    link("https://github.com/skychengzeng/vimrc")[#image("img/skychengzeng-repos/vimrc.png")],
    link("https://github.com/skychengzeng/codewars")[#image("img/skychengzeng-repos/codewars.png")],
    link("https://github.com/skychengzeng/weather-monitor")[#image("img/skychengzeng-repos/weather-monitor.png")],
    link("https://github.com/skychengzeng/climate-data-dashboard")[#image("img/skychengzeng-repos/climate-data-dashboard.png")],
    link("https://github.com/skychengzeng/fintech-reports")[#image("img/skychengzeng-repos/fintech-reports.png")],
    link("https://github.com/skychengzeng/python-documentation-project")[#image("img/skychengzeng-repos/python-documentation-project.png")],
    link("https://github.com/skychengzeng/tech-giants-investment-brief")[#image("img/skychengzeng-repos/tech-giants-investment-brief.png")],
    link("https://github.com/skychengzeng/aapl-financial-analysis")[#image("img/skychengzeng-repos/aapl-financial-analysis.png")],
    link("https://github.com/skychengzeng/smart-task-scheduler")[#image("img/skychengzeng-repos/smart-task-scheduler.png")],
    link("https://github.com/skychengzeng/rust-programming-language-research")[#image("img/skychengzeng-repos/rust-programming-language-research.png")],
    link("https://github.com/skychengzeng/aapl-investment-thesis/tree/research")[#image("img/skychengzeng-repos/aapl-investment-thesis.png")],
    link("https://github.com/skychengzeng/awesome-components")[#image("img/skychengzeng-repos/awesome-components.png")],
    link("https://github.com/skychengzeng/googleplex-urban-research")[#image("img/skychengzeng-repos/googleplex-urban-research.png")],
  ),
  caption: [All of `skychengzeng`'s non-link repositories, which appear to be efforts to create a facade of legitimacy with real-looking projects and READMEs, but are actually empty and inactive repositories with no commits beyond the initial README creation. Each repository has a different theme, but they all follow the same pattern of being empty and inactive. Seems to be AI-gnenerated content, on some local model, since the text output doesn't seem to match anything I have seen before. All images are linked to the respective repositories, which are all public and can be viewed by anyone.]
)

These repositories appear to have been created to simulate a normal user, making the account look legitimate and less likely to be flagged by spam detection. The profile README continues with this idea; it is a convincingly styled developer bio written in a casual tone, with no obvious tells beyond being AI-generated.

The profile page is where the automation becomes undeniable. The contribution graph shows 410 contributions concentrated entirely in April 2026, with the activity log showing "Created 296 commits in 296 repositories" and "Created 100+ repositories", all in the same burst. No human creates 296 repositories with one commit each in a single session. This is the output of an automated provisioning script running to completion.

Later bot accounts in the network skipped the decoy repositories entirely and went straight to the single-repo pattern, suggesting the operator decided the legitimacy facade was not worth the additional generation cost.

#figure(
  image("img/skychengzeng-readme.png", width: 60%),
  caption: [`skychengzeng`'s README, which appears to be AI-generated and trying to convince us that this is a normal account with genuine content. Located at #link("https://github.com/skychengzeng/skychengzeng")[`skychengzeng/skychengzeng`]]
)

== Account Pattern

Each account in this network follows a consistent structure:

- A single public repository, often named with random or generic strings
- A README consisting solely of the motivational text block and a list of short-links
- No other activity, contributions, followers, or profile information
- Account created within days of posting

Many of these accounts are being created daily. Searching a distinctive phrase from the template text on GitHub's code search surfaces the breadth of the network:

#align(center)[
  `https://github.com/search?q="on+the+road+to+chasing+dreams"&type=code`
]

#figure(
  image("img/on-the-road-to-chasing-dreams.png", width: 60%),
  caption: [GitHub code search for a distinctive phrase from the template text, showing hundreds of matching repositories across many accounts]
)

The motivational text itself is the evasion trick. It is AI-generated English content designed to look human-written, while still generic enough to reuse across hundreds of accounts without exact duplicate detection.

Older repositories in this network used direct Baidu redirect URLs of the form `baidu.com/link?url=...`. The current generation has migrated to a private short-link infrastructure, which is discussed in the next section.

*Note*: at the time of writing, newly created repositories in the network appear to have empty repositories, with no motivational text or links. This could indicate the operator is rotating to a new template not yet deployed, that GitHub's scanner is catching and stripping content faster than before, or that a new generation of the botnet is mid-deployment. It does not appear worth investigating further at this stage given the infrastructure is already fully documented.

== Link Infrastructure

=== Domain Pattern

Every link in the observed repositories follows the schema:

#align(center)[
  `[2-char subdomain].[5-char alpha string].cn`
]

A representative sample from the `skychengzeng` repository:

#align(center)[
  #table(
    columns: 2,
    [Domain], [Resolved IP],
    [`lm.qkvza.cn`], [`154.204.153.226`],
    [`76.abvch.cn`], [`154.204.153.227`],
    [`4s.ogclz.cn`], [`154.204.153.228`],
    [`xy.bnrsr.cn`], [`154.204.153.229`],
    [`kk.hvtno.cn`], [`154.204.153.230`],
    [`s0.rboea.cn`], [`154.204.153.231`],
    [`8g.sydes.cn`], [`154.204.153.232`],
    [`ow.mepto.cn`], [`154.204.153.233`],
    [`4c.mlzbv.cn`], [`154.204.153.234`],
    [`ks.ewnhv.cn`], [`154.204.153.235`],
    [`08.hfvck.cn`], [`154.204.153.236`],
    [`go.zuioe.cn`], [`154.204.153.237`],
  )
]

The twelve domains resolve to twelve perfectly sequential IP addresses (`154.204.153.226`--`.237`), which strongly suggests they were provisioned together as a dedicated block from a Chinese hosting provider. This is very unlikely to be a coincidence. The operator appears to have requested a contiguous range and assigned addresses one-to-one with domains.

Examining the full link list from a single repository (see Appendix) reveals two further observations. First, the same twelve second-level domains are reused throughout with rotating 2-char subdomains --- `lm.qkvza.cn`, `u2.qkvza.cn`, `v3.qkvza.cn`, `5d.qkvza.cn`, and so on --- meaning the short-link space is far larger than one URL per domain: each domain is a shared redirect host serving many distinct paths via the subdomain as a key.

Second, mixed in with the random-string domains are what appear to be real Chinese business domains: `duoduoling.cn`, `wujianying.cn`, `nanjingyj.cn`, `jinanhunche.cn`, `jisedu.cn`, `yaozhun.com.cn`, `baojinhui.cn`, and others. These do not follow the 5-char random-string pattern and have the appearance of legitimate registered businesses. Whether these are compromised third-party sites being used as additional redirect hops, or domains registered to mimic real businesses for credibility, is unclear, but their presence suggests the operation's footprint extends beyond the purpose-built infrastructure and may affect unrelated parties.


```sh
# dig-domain-res.sh

#!/bin/bash
for domain in qkvza.cn abvch.cn ogclz.cn bnrsr.cn hvtno.cn rboea.cn sydes.cn mepto.cn mlzbv.cn ewnhv.cn hfvck.cn zuioe.cn; do
  echo -n "$domain -> "
  dig +short A $domain
  dig +short NS $domain
done

```
The output is below.

=== DNS Infrastructure

All domains share the same two nameservers:

#align(center)[
  `dm1.longmingdns.com` \
  `dm2.longmingdns.com`
]

`longmingdns.com` is not a shared or commercial DNS provider. WHOIS data shows it was registered on 28 February 2025 through Zhengzhou Century Connect Electronic Technology Development Co., Ltd (`abuse@59.cn`). This looks like purpose-built infrastructure set up specifically for this domain network.

=== Domain Registrant

WHOIS data for `qkvza.cn` reveals the following registrant details:

#align(center)[
  #table(
    columns: 2,
    [Field], [Value],
    [Registrant], [丁继城],
    [Email], [`liuxqqx@outlook.com`],
    [Registrar], [阿里云计算有限公司（万网）],
    [Registration date], [2026-04-03 11:16:58],
    [Expiry date], [2027-04-03 11:16:58],
    [Nameservers], [`dm1.longmingdns.com`, `dm2.longmingdns.com`],
  )
]

```
whois qkvza.cn
Domain Name: qkvza.cn
ROID: 20260403s10001s73873180-cn
Domain Status: ok
Registrant: 丁继城
Registrant Contact Email: liuxqqx@outlook.com
Sponsoring Registrar: 阿里云计算有限公司（万网）
Name Server: dm1.longmingdns.com
Name Server: dm2.longmingdns.com
Registration Time: 2026-04-03 11:16:58
Expiration Time: 2027-04-03 11:16:58
DNSSEC: unsigned
```

All twelve domains were registered on the same date, eight days prior to initial discovery. The name (surname 丁) and email prefix (`liu`, a different surname) do not match, suggesting either a shared account or credentials that are not the operator's own identity.

=== Server Behaviour

Probing the redirect servers with `curl` yields a consistent `400 Bad Request` response, with two notable cookies set:

```
Set-Cookie: Hm_lvt=zh; expires=...; Max-Age=43200
Set-Cookie: server_name_session=8b0f07dd...; Max-Age=86400; httponly; path=/
```

`Hm_lvt` is the Baidu Tongji (百度统计) analytics tracker cookie, which is Baidu's own web analytics product and roughly equivalent to Google Analytics. Its presence on the redirect server shows that the operator has instrumented the short-link layer with Baidu Analytics, meaning they are actively measuring click-through traffic arriving from GitHub. This is not passive link spam. The operator has a feedback loop and can see which posts are performing.

The `server_name_session` cookie suggests a backend application managing per-session state, rather than a simple static redirect. The `400` response on direct access is consistent with the server gating redirects on a `Referer` header. In other words, it likely only responds when traffic appears to come from an embedded link, not from direct curl or a browser address bar request.

The 400 persists even when the correct session cookie is replayed. HTTPS (port 443) is not open on these servers either, which confirms HTTP is the only channel and makes Referer-gating the most likely explanation.

== Purpose and Classification

The overall operation looks like a *Baidu SEO link farm* targeting Baidu's search index. GitHub's domain carries high authority in Baidu's crawl, so links posted on GitHub can pass link equity to whatever the `.cn` short-links ultimately redirect to. That is most likely Chinese gambling, pharmaceutical, or adult-content sites that pay for black-hat SEO services.

The migration from direct `baidu.com/link?url=` redirects to a private `.cn` short-link layer suggests the operator previously ran this campaign using Baidu's own redirect infrastructure, got filtered, and then switched to a more resilient setup. The Baidu Tongji instrumentation on the new layer means they are now running analytics themselves instead of relying on Baidu's redirect tracking.

The full infrastructure stack, summarised:

#align(center)[
  #table(
    columns: (auto, 1fr),
    [Layer], [Detail],
    [GitHub accounts], [Hundreds created daily; single-repo; AI-generated README text as classifier evasion],
    [Short-link domains], [`[2].[5].cn` pattern; 12+ domains per batch; same-day bulk registration],
    [Redirect servers], [Sequential IP block; nginx; Baidu Tongji analytics; Referer-gated],
    [DNS], [Purpose-built `longmingdns.com`; registered Feb 2025],
    [Domain registrar], [Alibaba Cloud (阿里云); registrant `liuxqqx@outlook.com`],
  )
]

== Recommended Actions

The following abuse contacts have standing to act on this operation:

#align(center)[
  #table(
    columns: (1fr, 1fr, 2fr),
    [Target], [Contact], [Rationale],
    [GitHub Trust & Safety], [`abuse@github.com`], [Primary; can pattern-match on shared infrastructure and bulk-suspend the account family],
    [Alibaba Cloud], [`abuse@list.alibaba-inc.com`], [Registrar for all domains; can suspend the registrant account and block future bulk registrations under the same identity],
    [59.cn / Zhengzhou Century Connect], [`abuse@59.cn`], [Operates `longmingdns.com`; revoking the nameservers takes all current domains offline simultaneously],
    [Baidu], [`jubao@baidu.com`], [Revoking the Baidu Tongji analytics account removes the operator's traffic feedback loop],
  )
]

A bulk report to GitHub is the highest-leverage single action. The shared infrastructure fingerprint (identical IP block, identical DNS, identical cookie headers, same-day domain registration, same registrant email) is strong evidence of a coordinated inauthentic operation rather than independent actors, and should trigger a network-level response instead of per-account review.

== Appendix: Raw Evidence

I had to fetch these again a couple of days after finding all of this, so there is no guarantee that the data below matches what I originally observed. However, I have no reason to believe it has changed, and it still serves as a useful reference for the technical details of the infrastructure.

=== Domain DNS Resolution and Nameserver Lookup

```
$ ./dig-domain-res.sh 
qkvza.cn -> 154.204.153.226
dm1.longmingdns.com.
dm2.longmingdns.com.
abvch.cn -> 154.204.153.227
dm1.longmingdns.com.
dm2.longmingdns.com.
ogclz.cn -> 154.204.153.228
dm2.longmingdns.com.
dm1.longmingdns.com.
bnrsr.cn -> 154.204.153.229
dm1.longmingdns.com.
dm2.longmingdns.com.
hvtno.cn -> 154.204.153.230
dm2.longmingdns.com.
dm1.longmingdns.com.
rboea.cn -> 154.204.153.231
dm1.longmingdns.com.
dm2.longmingdns.com.
sydes.cn -> 154.204.153.232
dm1.longmingdns.com.
dm2.longmingdns.com.
mepto.cn -> 154.204.153.233
dm2.longmingdns.com.
dm1.longmingdns.com.
mlzbv.cn -> 154.204.153.234
dm1.longmingdns.com.
dm2.longmingdns.com.
ewnhv.cn -> 154.204.153.235
dm2.longmingdns.com.
dm1.longmingdns.com.
hfvck.cn -> 154.204.153.236
dm2.longmingdns.com.
dm1.longmingdns.com.
zuioe.cn -> 154.204.153.237
dm2.longmingdns.com.
dm1.longmingdns.com.
```

=== WHOIS: `qkvza.cn`

```
$ whois qkvza.cn
Domain Name: qkvza.cn
ROID: 20260403s10001s73873180-cn
Domain Status: ok
Registrant: 丁继城
Registrant Contact Email: liuxqqx@outlook.com
Sponsoring Registrar: 阿里云计算有限公司（万网）
Name Server: dm1.longmingdns.com
Name Server: dm2.longmingdns.com
Registration Time: 2026-04-03 11:16:58
Expiration Time: 2027-04-03 11:16:58
DNSSEC: unsigned
```

=== WHOIS: `longmingdns.com`

```
$ whois longmingdns.com
   Domain Name: LONGMINGDNS.COM
   Registry Domain ID: 2963199784_DOMAIN_COM-VRSN
   Registrar WHOIS Server: whois.59.cn
   Registrar URL: http://www.59.cn
   Updated Date: 2025-12-15T10:19:27Z
   Creation Date: 2025-02-28T01:22:45Z
   Registry Expiry Date: 2028-02-28T01:22:45Z
   Registrar: Zhengzhou Century Connect Electronic Technology Development Co., Ltd
   Registrar IANA ID: 2805
   Registrar Abuse Contact Email: abuse@59.cn
   Registrar Abuse Contact Phone: +86.37156699061
   Domain Status: clientDeleteProhibited https://icann.org/epp#clientDeleteProhibited
   Domain Status: clientTransferProhibited https://icann.org/epp#clientTransferProhibited
   Domain Status: clientUpdateProhibited https://icann.org/epp#clientUpdateProhibited
   Name Server: DM1.LONGMINGDNS.COM
   Name Server: DM2.LONGMINGDNS.COM
   DNSSEC: unsigned
   URL of the ICANN Whois Inaccuracy Complaint Form: https://www.icann.org/wicf/
>>> Last update of whois database: 2026-04-14T11:10:07Z <<<

For more information on Whois status codes, please visit https://icann.org/epp

NOTICE: The expiration date displayed in this record is the date the
registrar's sponsorship of the domain name registration in the registry is
currently set to expire. This date does not necessarily reflect the expiration
date of the domain name registrant's agreement with the sponsoring
registrar.  Users may consult the sponsoring registrar's Whois database to
view the registrar's reported date of expiration for this registration.

TERMS OF USE: You are not authorized to access or query our Whois
database through the use of electronic processes that are high-volume and
automated except as reasonably necessary to register domain names or
modify existing registrations; the Data in VeriSign Global Registry
Services' ("VeriSign") Whois database is provided by VeriSign for
information purposes only, and to assist persons in obtaining information
about or related to a domain name registration record. VeriSign does not
guarantee its accuracy. By submitting a Whois query, you agree to abide
by the following terms of use: You agree that you may use this Data only
for lawful purposes and that under no circumstances will you use this Data
to: (1) allow, enable, or otherwise support the transmission of mass
unsolicited, commercial advertising or solicitations via e-mail, telephone,
or facsimile; or (2) enable high volume, automated, electronic processes
that apply to VeriSign (or its computer systems). The compilation,
repackaging, dissemination or other use of this Data is expressly
prohibited without the prior written consent of VeriSign. You agree not to
use electronic processes that are automated and high-volume to access or
query the Whois database except as reasonably necessary to register
domain names or modify existing registrations. VeriSign reserves the right
to restrict your access to the Whois database in its sole discretion to ensure
operational stability.  VeriSign may restrict or terminate your access to the
Whois database for failure to abide by these terms of use. VeriSign
reserves the right to modify these terms at any time.

The Registry database contains ONLY .COM, .NET, .EDU domains and
Registrars.
```

=== Server Response Headers

```
HTTP/1.1 400 Bad Request
Server: nginx
Content-Type: text/html; charset=utf-8
Set-Cookie: Hm_lvt=zh; expires=Sat, 11-Apr-2026 19:47:14 GMT; Max-Age=43200
Set-Cookie: server_name_session=8b0f07dd9cc62c1fb9211d20995163f9;
            Max-Age=86400; httponly; path=/
```

=== Sample Repository Content (`skychengzeng/t71_e1n1`)

```md
Learn to calmly deal with the ups and downs of life; those experiences make us more resilient, moving bravely forward, reaping the brightness of sunshine.
The beauty of life comes from genuine interaction; no matter how ordinary the action, it could be the catalyst for changing the world, worth anticipating.
- http://u2.qkvza.cn
- http://ai.abvch.cn
- http://r8.ogclz.cn
- http://qr.bnrsr.cn
- http://dl.hvtno.cn
- http://t1.rboea.cn
- http://9h.sydes.cn
- http://px.mepto.cn
- http://5d.mlzbv.cn
- http://dl.ewnhv.cn
- http://t1.hfvck.cn
- http://9h.zuioe.cn
- http://px.uusfp.cn
- http://5d.mnpry.cn
- http://lt.ilulw.cn
- http://19.qlukd.cn
- http://hp.tkijc.cn
- http://x5.nnwkm.cn
- http://dl.wvrea.cn
- http://t1.xrkjo.cn
- http://9h.xnvnj.cn
- http://px.aeetc.cn
- http://5d.bngdg.cn
- http://lt.hvddv.cn
- http://19.dcdqi.cn
- http://hp.tjvsc.cn
- http://x5.zfmdz.cn
- http://dl.dngzx.cn
- http://tt.tdanm.cn
- http://19.kjncv.cn
- http://hp.eacxj.cn
- http://x5.ggssm.cn
- http://dl.ljmzf.cn
- http://t1.wikhu.cn
- http://9h.veppn.cn
- http://px.ubcau.cn
- http://5d.tutpq.cn
- http://lt.ijfvr.cn
- http://19.sjslz.cn
- http://hp.qvdxl.cn
- http://x5.yzobc.cn
- http://dl.qrkmv.cn
- http://t1.rsroe.cn
- http://9h.enlpz.cn
- http://pw.ygqpi.cn
- http://4c.fvpzy.cn
- http://ks.krsxh.cn
- http://08.oveki.cn
- http://gg.xyaej.cn
- http://ow.ulfwh.cn
- http://4c.cbazx.cn
- http://ks.wnthh.cn
- http://08.baojinhui.cn
- http://go.lp010.cn
- http://w4.8ur4e.cn
- http://ck.sg569.cn
- http://s0.x3vfs.cn
- http://8g.duoduoling.cn
- http://ow.wujianying.cn
- http://4c.dc4d.cn
- http://ks.w977.cn
- http://08.fg3j.cn
- http://go.nanjingyj.cn
- http://w4.jinanhunche.cn
- http://ck.yhyljj.cn
- http://s0.wbtcw.cn
- http://8g.yongxinyimin.cn
- http://ow.yadesign.cn
- http://w4.semou.cn
- http://ck.erainedu.cn
- http://s0.tsyouxi.cn
- http://8g.kohmi.cn
- http://ow.acmggph.cn
- http://4c.58wuyouchengshi.cn
- http://ks.kweny.cn
- http://08.caijinghr.com.cn
- http://go.mojingmianmo.cn
- http://w4.lingyouhuiquan.cn
- http://ck.ciguru.cn
- http://s0.todownload.cn
- http://8g.bstqqc.cn
- http://ow.blamv.cn
- http://4c.ynzzbj.cn
- http://ks.yaozhun.com.cn
- http://08.szcykj88.cn
- http://go.qjkonggu.cn
- http://w4.fbktkfl.cn
- http://bb.npqxflm.cn
- http://jr.f1b9s.cn
- http://z7.ai718.cn
- http://fn.ri12j.cn
- http://v3.pzdzqs.cn
- http://bj.zscwzh.cn
- http://rz.360qcw.cn
- http://7f.zn1ist.cn
- http://nv.czlpgdzb.cn
- http://3b.hssyj.cn
- http://jr.zixunfuwugedai.cn
- http://z7.jisedu.cn
- http://fn.ycydfs.cn
- http://v3.qkvza.cn
- http://bj.abvch.cn
- http://rz.ogclz.cn
- http://7f.bnrsr.cn
- http://nv.hvtno.cn
- http://3b.rboea.cn
- http://jr.sydes.cn
- http://rz.mepto.cn
- http://7f.mlzbv.cn
- http://nv.ewnhv.cn
- http://3b.hfvck.cn
- http://jr.zuioe.cn
- http://z7.uusfp.cn
- http://fn.mnpry.cn
- http://v3.ilulw.cn
- http://bj.qlukd.cn
- http://rz.tkijc.cn
- http://7f.nnwkm.cn
- http://nv.wvrea.cn
- http://3b.xrkjo.cn
- http://jr.xnvnj.cn
- http://z7.aeetc.cn
- http://vj.bngdg.cn
- http://op.hvddv.cn
- http://bj.dcdqi.cn
- http://rz.tjvsc.cn
- http://77.zfmdz.cn
- http://fn.dngzx.cn
- http://v3.tdanm.cn
- http://bi.kjncv.cn
- http://qy.eacxj.cn
- http://6e.ggssm.cn
- http://mu.ljmzf.cn
- http://2a.wikhu.cn
- http://iq.veppn.cn
- http://y6.ubcau.cn
- http://em.tutpq.cn
- http://u2.ijfvr.cn
- http://ai.sjslz.cn
- http://qy.qvdxl.cn
- http://6e.yzobc.cn
- http://mu.qrkmv.cn
- http://2a.rsroe.cn
- http://iq.enlpz.cn
- http://y6.ygqpi.cn
- http://em.fvpzy.cn
- http://uu.krsxh.cn
- http://2a.oveki.cn
- http://iq.xyaej.cn
- http://y6.ulfwh.cn
- http://em.cbazx.cn
- http://u2.wnthh.cn
- http://ai.baojinhui.cn
- http://qy.lp010.cn
- http://6e.8ur4e.cn
- http://mu.sg569.cn
- http://2a.x3vfs.cn
- http://iq.duoduoling.cn
- http://y6.wujianying.cn
- http://em.dc4d.cn
- http://u2.w977.cn
- http://ai.fg3j.cn
- http://qy.nanjingyj.cn
- http://6e.jinanhunche.cn
- http://mu.yhyljj.cn
- http://2a.wbtcw.cn
- http://ai.yongxinyimin.cn
- http://qy.yadesign.cn
- http://6e.semou.cn
- http://mu.erainedu.cn
- http://2a.tsyouxi.cn
- http://iq.kohmi.cn
- http://y5.acmggph.cn
- http://dl.58wuyouchengshi.cn
- http://t1.kweny.cn
- http://9h.caijinghr.com.cn
- http://px.mojingmianmo.cn
- http://5d.lingyouhuiquan.cn
- http://lt.ciguru.cn
- http://19.todownload.cn
- http://hp.bstqqc.cn
- http://x5.blamv.cn
- http://dl.ynzzbj.cn
- http://t1.yaozhun.com.cn
- http://9h.szcykj88.cn
- http://pp.qjkonggu.cn
- http://x5.fbktkfl.cn
- http://dl.npqxflm.cn
- http://t1.f1b9s.cn
- http://9h.ai718.cn
- http://px.ri12j.cn
- http://5d.pzdzqs.cn
- http://lt.zscwzh.cn
- http://19.360qcw.cn
- http://hp.zn1ist.cn
- http://x5.czlpgdzb.cn
- http://dl.hssyj.cn
- http://t1.zixunfuwugedai.cn
- http://9h.jisedu.cn
- http://px.ycydfs.cn
- http://5d.qkvza.cn
- http://lt.abvch.cn
- http://19.ogclz.cn
- http://hp.bnrsr.cn
- http://x5.hvtno.cn
- http://5d.rboea.cn
- http://lt.sydes.cn
- http://19.mepto.cn
- http://hp.mlzbv.cn
- http://x5.ewnhv.cn
- http://dl.hfvck.cn
- http://t1.zuioe.cn
- http://9h.uusfp.cn
- http://px.mnpry.cn
- http://5d.ilulw.cn
- http://ks.qlukd.cn
- http://08.tkijc.cn
- http://go.nnwkm.cn
- http://w4.wvrea.cn
- http://ck.xrkjo.cn
- http://s0.xnvnj.cn
- http://8g.aeetc.cn
- http://ow.bngdg.cn
- http://4c.hvddv.cn
- http://kk.dcdqi.cn
- http://s0.tjvsc.cn
- http://8g.zfmdz.cn
- http://ow.dngzx.cn
- http://4c.tdanm.cn
- http://ks.kjncv.cn
- http://08.eacxj.cn
- http://go.ggssm.cn
- http://w4.ljmzf.cn
- http://ck.wikhu.cn
- http://s0.veppn.cn
- http://8g.ubcau.cn
- http://ow.tutpq.cn
- http://4c.ijfvr.cn
- http://ks.sjslz.cn
- http://08.qvdxl.cn
- http://go.yzobc.cn
- http://9u.qrkmv.cn
- http://sg.rsroe.cn
- http://c3.enlpz.cn
- http://fm.ygqpi.cn
- http://8g.fvpzy.cn
- http://ow.krsxh.cn
- http://4c.oveki.cn
- http://ks.xyaej.cn
- http://08.ulfwh.cn
- http://go.cbazx.cn
- http://w4.wnthh.cn
- http://ck.baojinhui.cn
- http://s0.lp010.cn
- http://8g.8ur4e.cn
- http://ow.sg569.cn
- http://4c.x3vfs.cn
- http://ks.duoduoling.cn
- http://z7.wujianying.cn
- http://fn.dc4d.cn
- http://v3.w977.cn
- http://bj.fg3j.cn
- http://rz.nanjingyj.cn
- http://7f.jinanhunche.cn
- http://nn.yhyljj.cn
- http://v3.wbtcw.cn
- http://bj.yongxinyimin.cn
- http://rz.yadesign.cn
- http://7f.semou.cn
- http://nv.erainedu.cn
- http://3b.tsyouxi.cn
- http://jr.kohmi.cn
- http://z7.acmggph.cn
- http://fn.58wuyouchengshi.cn
- http://v3.kweny.cn
- http://bj.caijinghr.com.cn
- http://rz.mojingmianmo.cn
- http://7f.lingyouhuiquan.cn
- http://nv.ciguru.cn
- http://3b.todownload.cn
- http://jr.bstqqc.cn
- http://z7.blamv.cn
- http://fn.ynzzbj.cn
- http://v3.yaozhun.com.cn
- http://3b.szcykj88.cn
- http://jr.qjkonggu.cn
- http://z7.fbktkfl.cn
- http://fn.npqxflm.cn
- http://v3.f1b9s.cn
- http://bj.ai718.cn
- http://rz.ri12j.cn
- http://7f.pzdzqs.cn
- http://nv.zscwzh.cn
- http://3b.360qcw.cn
- http://jr.zn1ist.cn
- http://z7.czlpgdzb.cn
- http://fn.hssyj.cn
- http://v3.zixunfuwugedai.cn
- http://bj.jisedu.cn
- http://rz.ycydfs.cn
- http://7f.qkvza.cn
- http://mu.abvch.cn
- http://2a.ogclz.cn
- http://ii.bnrsr.cn
- http://qy.hvtno.cn
- http://6e.rboea.cn
- http://mu.sydes.cn
- http://2a.mepto.cn
- http://iq.mlzbv.cn
- http://y6.ewnhv.cn
- http://em.hfvck.cn
- http://u2.zuioe.cn
- http://ai.uusfp.cn
- http://qy.mnpry.cn
- http://6e.ilulw.cn
- http://mu.qlukd.cn
- http://2a.tkijc.cn
- http://iq.nnwkm.cn
- http://y6.wvrea.cn
- http://em.xrkjo.cn
- http://u2.xnvnj.cn
- http://ai.aeetc.cn
- http://qy.bngdg.cn
- http://y6.hvddv.cn
- http://em.dcdqi.cn
- http://u2.tjvsc.cn
- http://ai.zfmdz.cn
- http://qy.dngzx.cn
- http://6e.tdanm.cn
- http://mu.kjncv.cn
- http://2a.eacxj.cn
- http://iq.ggssm.cn
- http://y6.ljmzf.cn
- http://em.wikhu.cn
- http://u2.veppn.cn
- http://ai.ubcau.cn
- http://qy.tutpq.cn
- http://6e.ijfvr.cn
- http://mu.sjslz.cn
- http://2a.qvdxl.cn
- http://iq.yzobc.cn
- http://e2.qrkmv.cn
- http://70.rsroe.cn
- http://mt.enlpz.cn
- http://19.ygqpi.cn
- http://hp.fvpzy.cn
- http://x5.krsxh.cn
- http://dl.oveki.cn
- http://t1.xyaej.cn
- http://9h.ulfwh.cn
- http://px.cbazx.cn
- http://5d.wnthh.cn
- http://lt.baojinhui.cn
- http://19.lp010.cn
- http://hp.8ur4e.cn
- http://x5.sg569.cn
- http://dl.x3vfs.cn
- http://t1.duoduoling.cn
- http://9h.wujianying.cn
- http://px.dc4d.cn
- http://5d.w977.cn
- http://lt.fg3j.cn
- http://11.nanjingyj.cn
- http://9h.jinanhunche.cn
- http://px.yhyljj.cn
- http://5d.wbtcw.cn
- http://lt.yongxinyimin.cn
- http://19.yadesign.cn
- http://hp.semou.cn
- http://x5.erainedu.cn
- http://dl.tsyouxi.cn
- http://t1.kohmi.cn
- http://9h.acmggph.cn
- http://px.58wuyouchengshi.cn
- http://5d.kweny.cn
- http://lt.caijinghr.com.cn
- http://19.mojingmianmo.cn
- http://hp.lingyouhuiquan.cn
- http://x5.ciguru.cn
- http://dl.todownload.cn
- http://t1.bstqqc.cn
- http://9h.blamv.cn
- http://hp.ynzzbj.cn
- http://x5.yaozhun.com.cn
- http://dl.szcykj88.cn
- http://t1.qjkonggu.cn
- http://8g.fbktkfl.cn
- http://ow.npqxflm.cn
- http://4c.f1b9s.cn
- http://ks.ai718.cn
- http://08.ri12j.cn
- http://go.pzdzqs.cn
- http://w4.zscwzh.cn
- http://ck.360qcw.cn
- http://s0.zn1ist.cn
- http://8g.czlpgdzb.cn
- http://ow.hssyj.cn
- http://4c.zixunfuwugedai.cn
- http://ks.jisedu.cn
- http://08.ycydfs.cn

There are no shortcuts in life; only through persistence and effort can we realize the value of life through the baptism of years, paving the way for the future.
The road ahead depends on today's choices; bravely chase dreams; let the flame of hope ignite in your heart, achieving a glorious and happy life.
On the road to chasing dreams, sometimes loneliness also adorns the beauty of life; learning to enjoy solitary moments allows you to discover different scenery in your heart.
If you have a dream, go chase it, fearless of all obstacles; let the soul be enriched, and comprehend the meaning and value of growth in every effort.
```
