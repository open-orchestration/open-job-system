[Skip to main content](https://pulsar.apache.org/docs/next/concepts-overview/#__docusaurus_skipToContent_fallback)

[✨ Apache Pulsar 4.2 is here! ✨](https://pulsar.apache.org/download/)

[![Apache Pulsar logo](https://pulsar.apache.org/img/logo-black.svg)](https://pulsar.apache.org/)

[Get Started](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Concepts](https://pulsar.apache.org/docs/4.2.x/concepts-overview/)
- [Quickstart](https://pulsar.apache.org/docs/4.2.x/)
- [Ecosystem](https://pulsar.apache.org/ecosystem/)
- [Client Libraries](https://pulsar.apache.org/docs/client-libraries/)

[Docs](https://pulsar.apache.org/docs/next/) [Features](https://pulsar.apache.org/features/) [Use Cases](https://pulsar.apache.org/use-cases/)

[Community](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Welcome](https://pulsar.apache.org/community/)
- [Discussions](https://pulsar.apache.org/community/#section-discussions)
- [Governance](https://pulsar.apache.org/community/#section-governance)
- [Meet the Community](https://pulsar.apache.org/community/#section-community)
- [Contribute](https://pulsar.apache.org/community/#section-contribute)
- [Contribution Guide](https://pulsar.apache.org/contribute/)
- [Wiki](https://github.com/apache/pulsar/wiki)
- [Issue Tracking](https://github.com/apache/pulsar/issues)

[Learn](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Blog](https://pulsar.apache.org/blog/)
- [Books](https://pulsar.apache.org/books/)
- [Case Studies](https://pulsar.apache.org/case-studies/)
- [Articles](https://pulsar.apache.org/articles/)
- [Presentations](https://pulsar.apache.org/presentations/)
- [Events](https://pulsar.apache.org/events/)

[Download](https://pulsar.apache.org/download/)

Search`Ctrl`  `K`

Version:

[Next](https://pulsar.apache.org/docs/next/)

- Next
- 4.2.x
- 4.0.x LTS
- 3.0.x LTS
- Others

- [About](https://pulsar.apache.org/docs/next/)
- [Get Started](https://pulsar.apache.org/docs/next/getting-started-home/)

- [Concepts and Architecture](https://pulsar.apache.org/docs/next/concepts-overview/#)

  - [Overview](https://pulsar.apache.org/docs/next/concepts-overview/)
  - [Messaging](https://pulsar.apache.org/docs/next/concepts-messaging/)
  - [Architecture](https://pulsar.apache.org/docs/next/concepts-architecture-overview/)
  - [Clients](https://pulsar.apache.org/docs/next/concepts-clients/)
  - [Broker load balancing](https://pulsar.apache.org/docs/next/concepts-overview/#)

  - [Geo Replication](https://pulsar.apache.org/docs/next/concepts-replication/)
  - [Cluster-level failover](https://pulsar.apache.org/docs/next/concepts-cluster-level-failover/)
  - [Multi Tenancy](https://pulsar.apache.org/docs/next/concepts-multi-tenancy/)
  - [Authentication and Authorization](https://pulsar.apache.org/docs/next/concepts-authentication/)
  - [Topic Compaction](https://pulsar.apache.org/docs/next/concepts-topic-compaction/)
  - [Message throttling](https://pulsar.apache.org/docs/next/concepts-throttling/)
  - [Proxy support with SNI routing](https://pulsar.apache.org/docs/next/concepts-proxy-sni-routing/)
  - [Multiple advertised listeners](https://pulsar.apache.org/docs/next/concepts-multiple-advertised-listeners/)
- [Pulsar Schema](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Pulsar Functions](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Pulsar IO](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Tiered Storage](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Transactions](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Deployment](https://pulsar.apache.org/docs/next/install-deploy-upgrade-landing/)

- [Administration](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Observability](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Security](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Performance](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Client Libraries](https://pulsar.apache.org/docs/client-libraries/)
- [Admin API](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Adaptors](https://pulsar.apache.org/docs/next/concepts-overview/#)

- [Tutorials](https://pulsar.apache.org/docs/next/how-to-landing/)

- [Development](https://pulsar.apache.org/docs/next/developers-landing/)

- [Reference](https://pulsar.apache.org/docs/next/reference-landing/)


This is documentation for the next unreleased version of Pulsar.

We recommend that you use the **[4.2.x](https://pulsar.apache.org/docs/4.2.x/concepts-overview/)** documentation.

- [Home page](https://pulsar.apache.org/)
- Concepts and Architecture
- Overview

Version: Next

On this page

# Pulsar Overview

Pulsar is a multi-tenant, high-performance solution for server-to-server messaging. Originally developed by Yahoo, Pulsar is under the stewardship of the [Apache Software Foundation](https://www.apache.org/).

## Key features [​](https://pulsar.apache.org/docs/next/concepts-overview/\#key-features "Direct link to Key features")

Key features of Pulsar are listed below:

- Native support for multiple clusters in a Pulsar instance, with seamless [geo-replication](https://pulsar.apache.org/docs/next/administration-geo/) of messages across clusters.
- Very low publish and end-to-end latency.
- Seamless scalability to over a million topics.
- A simple [client API](https://pulsar.apache.org/docs/next/concepts-clients/) with bindings for [Java](https://pulsar.apache.org/docs/client-libraries/java/), [Go](https://pulsar.apache.org/docs/client-libraries/go/), [Python](https://pulsar.apache.org/docs/client-libraries/python/), [C++](https://pulsar.apache.org/docs/client-libraries/cpp/), [C#/.NET](https://pulsar.apache.org/docs/client-libraries/dotnet/), [Node.js](https://pulsar.apache.org/docs/client-libraries/node/), and [WebSocket](https://pulsar.apache.org/docs/client-libraries/websocket/).
- Multiple [subscription types](https://pulsar.apache.org/docs/next/concepts-messaging/#subscription-types) ( [exclusive](https://pulsar.apache.org/docs/next/concepts-messaging/#exclusive), [shared](https://pulsar.apache.org/docs/next/concepts-messaging/#shared), [failover](https://pulsar.apache.org/docs/next/concepts-messaging/#failover), and [key\_shared](https://pulsar.apache.org/docs/next/concepts-messaging/#key_shared)) for topics.
- Guaranteed message delivery with [persistent message storage](https://pulsar.apache.org/docs/next/concepts-architecture-overview/#persistent-storage) provided by [Apache BookKeeper](http://bookkeeper.apache.org/).
- A serverless lightweight computing framework [Pulsar Functions](https://pulsar.apache.org/docs/next/functions-overview/) offers the capability for stream-native data processing.
- A serverless connector framework [Pulsar IO](https://pulsar.apache.org/docs/next/io-overview/), which is built on Pulsar Functions, makes it easier to move data in and out of Apache Pulsar.
- [Tiered Storage](https://pulsar.apache.org/docs/next/tiered-storage-overview/) offloads data from hot/warm storage to cold/long-term storage (such as S3 and GCS) when the data is aging out.
- Native support for [transactions](https://pulsar.apache.org/docs/next/transactions/) enabling atomic operations across topics and partitions.
- Flexible [authentication and authorization](https://pulsar.apache.org/docs/next/concepts-authentication/) with support for multiple providers including OAuth/OIDC.

## Contents [​](https://pulsar.apache.org/docs/next/concepts-overview/\#contents "Direct link to Contents")

- [Messaging Concepts](https://pulsar.apache.org/docs/next/concepts-messaging/)
- [Architecture Overview](https://pulsar.apache.org/docs/next/concepts-architecture-overview/)
- [Pulsar Clients](https://pulsar.apache.org/docs/next/concepts-clients/)
- [Geo Replication](https://pulsar.apache.org/docs/next/concepts-replication/)
- [Cluster-level failover](https://pulsar.apache.org/docs/next/concepts-cluster-level-failover/)
- [Multi Tenancy](https://pulsar.apache.org/docs/next/concepts-multi-tenancy/)
- [Authentication and Authorization](https://pulsar.apache.org/docs/next/concepts-authentication/)
- [Topic Compaction](https://pulsar.apache.org/docs/next/concepts-topic-compaction/)
- [Message throttling](https://pulsar.apache.org/docs/next/concepts-throttling/)
- [Proxy support with SNI routing](https://pulsar.apache.org/docs/next/concepts-proxy-sni-routing/)
- [Multiple advertised listeners](https://pulsar.apache.org/docs/next/concepts-multiple-advertised-listeners/)

[Edit this page](https://github.com/apache/pulsar-site/edit/main/docs/concepts-overview.md)

[Previous\\
\\
Run Pulsar locally with Docker Compose](https://pulsar.apache.org/docs/next/getting-started-docker-compose/) [Next\\
\\
Messaging](https://pulsar.apache.org/docs/next/concepts-messaging/)

Was this helpful?

[💡 Suggest changes](https://github.com/apache/pulsar-site/issues/new) [🛟 Get support](https://github.com/apache/pulsar/discussions/new?category=q-a)

- [Key features](https://pulsar.apache.org/docs/next/concepts-overview/#key-features)
- [Contents](https://pulsar.apache.org/docs/next/concepts-overview/#contents)

- [Foundation](https://www.apache.org/)
- [Events](https://www.apache.org/events/current-event.html)

- [License](https://www.apache.org/licenses/)
- [Thanks](https://www.apache.org/foundation/thanks)
- [Sponsorship](https://www.apache.org/foundation/sponsorship)

- [Security](https://pulsar.apache.org/security/)
- [Privacy](https://www.apache.org/foundation/policies/privacy.html)
- [Contact](https://pulsar.apache.org/contact/)

- [![Slack logo](https://pulsar.apache.org/img/slack-white.svg)](https://communityinviter.com/apps/apache-pulsar/apache-pulsar)[![GitHub logo](https://pulsar.apache.org/img/github-white.svg)](https://github.com/apache/pulsar/)


[![Pulsar Logo](https://pulsar.apache.org/img/pulsar-white.svg)](https://pulsar.apache.org/)

![](https://pulsar.apache.org/img/feather-logo-white.svg)
The Apache Software Foundation


Apache Pulsar is available under the Apache License, version 2.0. Apache Pulsar is an open-source, distributed messaging and streaming platform built for the cloud.

Copyright © 2026 The Apache Software Foundation. All Rights Reserved. Apache, Pulsar, Apache Pulsar, and the Apache feather logo are trademarks or registered trademarks of The Apache Software Foundation.

![Project Logo](https://pbs.twimg.com/profile_images/875130220474359809/wFcLUbwd_400x400.jpg)

Ask AI

hCaptcha

![Check mark](<Base64-Image-Removed>)

'I am human', Select in order to trigger the challenge, or to bypass it if you have an accessibility cookie

I am human

[hCaptcha logo, opens new window with more information](https://www.hcaptcha.com/what-is-hcaptcha-about?ref=pulsar.apache.org&utm_campaign=565487b2-a67c-4aac-bb92-3fb64732c7b8&utm_medium=checkbox&hl=en)

[Privacy](https://hcaptcha.com/privacy?ref=pulsar.apache.org&utm_campaign=565487b2-a67c-4aac-bb92-3fb64732c7b8&utm_medium=checkbox&hl=en) \- [Terms](https://hcaptcha.com/terms?ref=pulsar.apache.org&utm_campaign=565487b2-a67c-4aac-bb92-3fb64732c7b8&utm_medium=checkbox&hl=en)

![](<Base64-Image-Removed>)

hCaptcha

Please try again. ⚠️

Verify

Afrikaans

Albanian

Amharic

Arabic

Armenian

Azerbaijani

Basque

Belarusian

Bengali

Bulgarian

Bosnian

Burmese

Catalan

Cebuano

Chinese

Chinese Simplified

Chinese Traditional

Corsican

Croatian

Czech

Danish

Dutch

English

Esperanto

Estonian

Finnish

French

Frisian

Gaelic

Galacian

Georgian

German

Greek

Gujurati

Haitian

Hausa

Hawaiian

Hebrew

Hindi

Hmong

Hungarian

Icelandic

Igbo

Indonesian

Irish

Italian

Japanese

Javanese

Kannada

Kazakh

Khmer

Kinyarwanda

Kirghiz

Korean

Kurdish

Lao

Latin

Latvian

Lithuanian

Luxembourgish

Macedonian

Malagasy

Malay

Malayalam

Maltese

Maori

Marathi

Mongolian

Nepali

Norwegian

Nyanja

Oriya

Persian

Polish

Portuguese (Brazil)

Portuguese (Portugal)

Pashto

Punjabi

Romanian

Russian

Samoan

Shona

Sindhi

Sinhalese

Serbian

Slovak

Slovenian

Somali

Southern Sotho

Spanish

Sundanese

Swahili

Swedish

Tagalog

Tajik

Tamil

Tatar

Teluga

Thai

Turkish

Turkmen

Uyghur

Ukrainian

Urdu

Uzbek

Vietnamese

Welsh

Xhosa

Yiddish

Yoruba

Zulu

EN

[hCaptcha logo, opens new window with more information](https://www.hcaptcha.com/what-is-hcaptcha-about?ref=pulsar.apache.org&utm_campaign=565487b2-a67c-4aac-bb92-3fb64732c7b8&utm_medium=challenge&hl=en "hCaptcha logo, opens new window with more information")