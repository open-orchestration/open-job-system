The JSON Schema Office Hours Now Runs Weekly! [Join Us!](https://github.com/orgs/json-schema-org/discussions/34)✕

[![Dynamic image](https://json-schema.org/img/logos/logo-blue.svg)](https://json-schema.org/)

[Specification](https://json-schema.org/specification) [Docs](https://json-schema.org/docs) [Tools](https://json-schema.org/tools?query=&sortBy=name&sortOrder=ascending&groupBy=toolingTypes&licenses=&languages=&drafts=&toolingTypes=&environments=) [Blog](https://json-schema.org/blog) [Community](https://json-schema.org/community)

Search`` `K`

![Dark Mode](https://json-schema.org/icons/theme-switch.svg)

![System theme](https://json-schema.org/icons/theme-switch.svg)System

![Light theme](https://json-schema.org/icons/sun.svg)Light

![Dark theme](https://json-schema.org/icons/moon.svg)Dark

[Star on GitHub](https://github.com/json-schema-org/json-schema-spec)

### Reference

![eye icon](https://json-schema.org/icons/eye.svg)

Introduction

![compass icon](https://json-schema.org/icons/compass.svg)

Get Started

![grad cap icon](https://json-schema.org/icons/grad-cap.svg)

Guides

![book icon](https://json-schema.org/icons/book.svg)

Reference

[Overview](https://json-schema.org/understanding-json-schema/reference) [JSON Schema keywords](https://json-schema.org/understanding-json-schema/keywords) [JSON data types](https://json-schema.org/understanding-json-schema/reference/type)

[array](https://json-schema.org/understanding-json-schema/reference/array) [boolean](https://json-schema.org/understanding-json-schema/reference/boolean) [null](https://json-schema.org/understanding-json-schema/reference/null) [numeric types](https://json-schema.org/understanding-json-schema/reference/numeric) [object](https://json-schema.org/understanding-json-schema/reference/object) [regular expressions](https://json-schema.org/understanding-json-schema/reference/regular_expressions) [string](https://json-schema.org/understanding-json-schema/reference/string)

[Dialect and vocabulary declaration](https://json-schema.org/understanding-json-schema/reference/schema) [Enumerated and constant values](https://json-schema.org/understanding-json-schema/reference/generic)

[Enumerated values](https://json-schema.org/understanding-json-schema/reference/enum) [Constant values](https://json-schema.org/understanding-json-schema/reference/const)

[Schema annotations and comments](https://json-schema.org/understanding-json-schema/reference/metadata)

[Annotations](https://json-schema.org/understanding-json-schema/reference/annotations) [Comments](https://json-schema.org/understanding-json-schema/reference/comments)

[Conditional schema validation](https://json-schema.org/understanding-json-schema/reference/conditionals) [Schema composition](https://json-schema.org/understanding-json-schema/reference/composition)

[Boolean JSON Schema combination](https://json-schema.org/understanding-json-schema/reference/combining) [Modular JSON Schema combination](https://json-schema.org/understanding-json-schema/structuring)

[Media: string-encoding non-JSON data](https://json-schema.org/understanding-json-schema/reference/non_json_data) [Learn JSON Schema](https://www.learnjsonschema.com/)

![clipboard icon](https://json-schema.org/icons/clipboard.svg)

Specification

![eye icon](https://json-schema.org/icons/eye.svg)

Introduction

![compass icon](https://json-schema.org/icons/compass.svg)

Get Started

![grad cap icon](https://json-schema.org/icons/grad-cap.svg)

Guides

![book icon](https://json-schema.org/icons/book.svg)

Reference

[Overview](https://json-schema.org/understanding-json-schema/reference) [JSON Schema keywords](https://json-schema.org/understanding-json-schema/keywords) [JSON data types](https://json-schema.org/understanding-json-schema/reference/type)

[array](https://json-schema.org/understanding-json-schema/reference/array) [boolean](https://json-schema.org/understanding-json-schema/reference/boolean) [null](https://json-schema.org/understanding-json-schema/reference/null) [numeric types](https://json-schema.org/understanding-json-schema/reference/numeric) [object](https://json-schema.org/understanding-json-schema/reference/object) [regular expressions](https://json-schema.org/understanding-json-schema/reference/regular_expressions) [string](https://json-schema.org/understanding-json-schema/reference/string)

[Dialect and vocabulary declaration](https://json-schema.org/understanding-json-schema/reference/schema) [Enumerated and constant values](https://json-schema.org/understanding-json-schema/reference/generic)

[Enumerated values](https://json-schema.org/understanding-json-schema/reference/enum) [Constant values](https://json-schema.org/understanding-json-schema/reference/const)

[Schema annotations and comments](https://json-schema.org/understanding-json-schema/reference/metadata)

[Annotations](https://json-schema.org/understanding-json-schema/reference/annotations) [Comments](https://json-schema.org/understanding-json-schema/reference/comments)

[Conditional schema validation](https://json-schema.org/understanding-json-schema/reference/conditionals) [Schema composition](https://json-schema.org/understanding-json-schema/reference/composition)

[Boolean JSON Schema combination](https://json-schema.org/understanding-json-schema/reference/combining) [Modular JSON Schema combination](https://json-schema.org/understanding-json-schema/structuring)

[Media: string-encoding non-JSON data](https://json-schema.org/understanding-json-schema/reference/non_json_data) [Learn JSON Schema](https://www.learnjsonschema.com/)

![clipboard icon](https://json-schema.org/icons/clipboard.svg)

Specification

# Modular JSON Schema combination

## Introduction

When writing computer programs of even moderate complexity, it's
commonly accepted that "structuring" the program into reusable
functions is better than duplicating code. Similarly, in JSON Schema, structuring your schema into reusable components is highly beneficial for anything beyond the most trivial cases.

Here, you will learn about the keywords used to combine JSON schemas modularly and see examples of their application.

## Schema Identification

Like any other code, schemas are easier to maintain if they can be
broken down into logical units that reference each other as necessary.
In order to reference a schema, we need a way to identify a schema.
Schema documents are identified by non-relative URIs.

Schema documents are not required to have an identifier, but you will
need one if you want to reference one schema from another. In this
documentation, we will refer to schemas with no identifier as
"anonymous schemas".

In the following sections we will see how the "identifier" for a
schema is determined.

URI terminology can sometimes be unintuitive. In this document, the
following definitions are used.

- **URI** [\[1\]](https://datatracker.ietf.org/doc/html/rfc3986#section-3) or
**non-relative URI**: A full URI containing a scheme (`https`). It
may contain a URI fragment (`#foo`). Sometimes this document will
use "non-relative URI" to make it extra clear that relative URIs
are not allowed.
- **relative reference** [\[2\]](https://datatracker.ietf.org/doc/html/rfc3986#section-4.2):
A partial URI that does not contain a scheme (`https`). It may
contain a fragment (`#foo`).
- **URI-reference** [\[3\]](https://datatracker.ietf.org/doc/html/rfc3986#section-4.1):
A relative reference or non-relative URI. It may contain a URI
fragment (`#foo`).
- **absolute URI** [\[4\]](https://datatracker.ietf.org/doc/html/rfc3986#section-4.3) A
full URI containing a scheme (`https`) but not a URI fragment
(`#foo`).


Even though schemas are identified by URIs, those identifiers are not
necessarily network-addressable. They are just identifiers. Generally,
[implementations](https://json-schema.org/learn/glossary#implementation) don't make HTTP requests (`https://`) or read from the
file system (`file://`) to fetch schemas. Instead, they provide a way to
load schemas into an internal schema database. When a schema is
referenced by it's URI identifier, the schema is retrieved from the
internal schema database.

## Base URI

Using non-relative URIs can be cumbersome, so any URIs used in JSON
Schema can be URI-references that resolve against the schema's base URI
resulting in a non-relative URI. This section describes how a schema's
base URI is determined.

Base URI determination and relative reference resolution is defined by
[RFC-3986](https://datatracker.ietf.org/doc/html/rfc3986#section-5). If
you are familiar with how this works in HTML, this section should feel
very familiar.

### Retrieval URI

The URI used to fetch a schema is known as the "retrieval URI". It's
often possible to pass an anonymous schema to an implementation in which
case that schema would have no retrieval URI.

Let's assume a schema is referenced using the URI
`https://example.com/schemas/address` and the following schema is
retrieved.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"type": "object","properties": {"street\_address": {"type": "string"},"city": {"type": "string"},"state": {"type": "string"}},"required": \["street\_address","city","state"\]}﻿

The base URI for this schema is the same as the retrieval URI, `https://example.com/schemas/address`.

## $id

You can set the base URI by using the `$id` [keyword](https://json-schema.org/learn/glossary#keyword) at the root of the
schema. The value of `$id` is a URI-reference without a fragment that
resolves against the [retrieval-uri](https://json-schema.org/understanding-json-schema/structuring#retrieval-uri). The resulting URI is
the base URI for the schema.

Draft-specific info:

Draft 4

Draft 4-7

In Draft 4, `$id` is just `id` (without the dollar sign).

This is analogous to the `<base>` [tag in HTML](https://html.spec.whatwg.org/multipage/semantics.html#the-base-element).

When the `$id` keyword appears in a [subschema](https://json-schema.org/learn/glossary#subschema), it means something slightly different. See the [bundling](https://json-schema.org/understanding-json-schema/structuring#bundling) section for more.

Let's assume the URIs `https://example.com/schema/address` and
`https://example.com/schema/billing-address` both identify the following
schema.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$id": "/schemas/address",﻿

"type": "object","properties": {"street\_address": {"type": "string"},"city": {"type": "string"},"state": {"type": "string"}},"required": \["street\_address","city","state"\]}﻿

No matter which of the two URIs is used to retrieve this schema, the
base URI will be `https://example.com/schemas/address`, which is the
result of the `$id` URI-reference resolving against the
[Retrieval URI](https://json-schema.org/understanding-json-schema/structuring#retrieval-uri).

However, using a relative reference when setting a base URI can be
problematic. For example, we couldn't use this schema as an anonymous
schema because there would be no [Retrieval URI](https://json-schema.org/understanding-json-schema/structuring#retrieval-uri) and you
can't resolve a relative reference against nothing. For this and other
reasons, it's recommended that you always use an absolute URI when
declaring a base URI with `$id`.

The base URI of the following schema will always be
`https://example.com/schemas/address` no matter what the
[Retrieval URI](https://json-schema.org/understanding-json-schema/structuring#retrieval-uri) was or if it's used as an anonymous schema.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$id": "https://example.com/schemas/address",﻿

"type": "object","properties": {"street\_address": {"type": "string"},"city": {"type": "string"},"state": {"type": "string"}},"required": \["street\_address","city","state"\]}﻿

### JSON Pointer

In addition to identifying a schema document, you can also identify
subschemas. The most common way to do that is to use a [JSON\\
Pointer](https://tools.ietf.org/html/rfc6901) in the URI fragment that
points to the subschema.

A JSON Pointer describes a slash-separated path to traverse the keys in
the objects in the document. Therefore, `/properties/street_address`
means:

- 1) find the value of the key `properties`
- 2) within that object, find the value of the key `street_address`

The URI `https://example.com/schemas/address#/properties/street_address`
identifies the highlighted subschema in the following schema.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$id": "https://example.com/schemas/address","type": "object","properties": {"street\_address": {"type": "string"},"city": {"type": "string"},"state": {"type": "string"}},"required": \["street\_address","city","state"\]}﻿

### $anchor

A less common way to identify a subschema is to create a named anchor in
the schema using the `$anchor` keyword and using that name in the URI
fragment. Anchors must start with a letter followed by any number of
letters, digits, `-`, `_`, `:`, or `.`.

Draft-specific info:

Draft 4

Draft 6-7

In Draft 4, you declare an anchor the same way you do in Draft 6-7
except that `$id` is just `id` (without the dollar sign).

If a named anchor is defined that doesn't follow these naming rules,
then behavior is undefined. Your anchors might work in some
implementation, but not others.

The URI `https://example.com/schemas/address#street_address` identifies
the subschema on the highlighted part of the following schema.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$id": "https://example.com/schemas/address","type": "object","properties": {"street\_address": {"$anchor": "street\_address", "type": "string"},"city": {"type": "string"},"state": {"type": "string"}}, "required": \["street\_address","city","state"\]}﻿

## $ref

A schema can reference another schema using the `$ref` keyword. The
value of `$ref` is a URI-reference that is resolved against the
schema's [Base URI](https://json-schema.org/understanding-json-schema/structuring#base-uri). When evaluating a `$ref`, an
implementation uses the resolved identifier to retrieve the referenced
schema and applies that schema to the [instance](https://json-schema.org/learn/glossary#instance).

Draft-specific info

![info blue](https://json-schema.org/icons/info-blue.svg)

In Draft 4-7, `$ref` behaves a little differently. When an
object contains a `$ref` property, the object is considered a
reference, not a schema. Therefore, any other properties you put
in that object will not be treated as JSON Schema keywords and will
be ignored by the validator. `$ref` can only be used where a
schema is expected.

For this example, let's say we want to define a customer record, where
each customer may have both a shipping and a billing address. Addresses
are always the same — they have a street address, city and
state — so we don't want to duplicate that part of the schema
everywhere we want to store an address. Not only would that make the
schema more verbose, but it makes updating it in the future more
difficult. If our imaginary company were to start doing international
business in the future and we wanted to add a country field to all the
addresses, it would be better to do this in a single place rather than
everywhere that addresses are used.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$id": "https://example.com/schemas/customer",﻿

"type": "object","properties": {"first\_name": {"type": "string"},"last\_name": {"type": "string"},"shipping\_address": {"$ref": "/schemas/address"},"billing\_address": {"$ref": "/schemas/address"}},"required": \["first\_name","last\_name","shipping\_address","billing\_address"\]}﻿

The URI-references in `$ref` resolve against the schema's
[Base URI](https://json-schema.org/understanding-json-schema/structuring#base-uri) (`https://example.com/schemas/customer`) which
results in `https://example.com/schemas/address`. The implementation
retrieves that schema and uses it to evaluate the "shipping\_address"
and "billing\_address" properties.

When using `$ref` in an anonymous schema, relative references may not be
resolvable. Let's assume this example is used as an anonymous schema

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"type": "object","properties": {"first\_name": {"type": "string"},"last\_name": {"type": "string"},"shipping\_address": {"$ref": "https://example.com/schemas/address"},"billing\_address": {"$ref": "/schemas/address"}},"required": \["first\_name","last\_name","shipping\_address","billing\_address"\]}﻿

The `$ref` at `/properties/shipping_address` can resolve just fine
without a non-relative base URI to resolve against, but the `$ref` at
`/properties/billing_address` can't resolve to a non-relative URI and
therefore can't be used to retrieve the address schema.

## $defs

Sometimes we have small subschemas that are only intended for use in the
current schema and it doesn't make sense to define them as separate
schemas. Although we can identify any subschema using JSON Pointers or
named anchors, the `$defs` keyword gives us a standardized place to keep
subschemas intended for reuse in the current schema document.

Let's extend the previous customer schema example to use a common
schema for the name properties. It doesn't make sense to define a new
schema for this and it will only be used in this schema, so it's a good
candidate for using `$defs`.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$id": "https://example.com/schemas/customer",﻿

"type": "object","properties": {"first\_name": {"$ref": "#/$defs/name"},"last\_name": {"$ref": "#/$defs/name"},"shipping\_address": {"$ref": "/schemas/address"},"billing\_address": {"$ref": "/schemas/address"}},"required": \["first\_name","last\_name","shipping\_address","billing\_address"\],﻿

"$defs": {"name": {"type": "string"}}}﻿

`$defs` isn't just good for avoiding duplication. It can also be useful
for writing schemas that are easier to read and maintain. Complex parts
of the schema can be defined in `$defs` with descriptive names and
referenced where it's needed. This allows readers of the schema to more
quickly and easily understand the schema at a high level before diving
into the more complex parts.

It's possible to reference an external subschema, but generally you
want to limit a `$ref` to referencing either an external schema or an
internal subschema defined in `$defs`.

## Recursion

The `$ref` keyword may be used to create recursive schemas that refer to
themselves. For example, you might have a `person` schema that has an
array of `children`, each of which are also `person` instances.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"type": "object","properties": {"name": {"type": "string"},"children": {"type": "array","items": {"$ref": "#"}}}}﻿

A snippet of the British royal family tree

![Copy icon](https://json-schema.org/icons/copy.svg)data

{"name": "Elizabeth","children": \[{"name": "Charles","children": \[{"name": "William","children": \[{"name": "George"},{"name": "Charlotte"}\]},{"name": "Harry"}\]}\]}﻿

![Checkmark icon](https://json-schema.org/icons/checkmark.svg)compliant to schema

Above, we created a schema that refers to itself, effectively creating a
"loop" in the validator, which is both allowed and useful. Note,
however, that a `$ref` referring to another `$ref` could cause an
infinite loop in the resolver, and is explicitly disallowed.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$defs": {"alice": {"$ref": "#/$defs/bob"},"bob": {"$ref": "#/$defs/alice"}}}﻿

## Extending Recursive Schemas

![star](https://json-schema.org/icons/star.svg)New in draft 2019-09

Documentation Coming Soon

## Bundling

Working with multiple schema documents is convenient for development,
but it's often more convenient for distribution to bundle all of your
schemas into a single schema document. This can be done using the `$id`
keyword in a subschema. When `$id` is used in a subschema, it indicates
an embedded schema. The identifier for the embedded schema is the value
of `$id` resolved against the [Base URI](https://json-schema.org/understanding-json-schema/structuring#base-uri) of the schema it
appears in. A schema document that includes embedded schemas is called a
Compound Schema Document. Each schema with an `$id` in a Compound Schema
Document is called a Schema Resource.

Draft-specific info:

Draft 4

Draft 4-7

In Draft 4, `$id` is just `id` (without the dollar sign).

This is analogous to the `<iframe>` [tag in HTML](https://html.spec.whatwg.org/multipage/iframe-embed-object.html#the-iframe-element).

It is unusual to use embedded schemas when developing schemas. It's
generally best not to use this feature explicitly and use schema
bundling tools to construct bundled schemas if such a thing is needed.
:::

This example shows the customer schema example and the address schema
example bundled into a Compound Schema Document.

![Copy icon](https://json-schema.org/icons/copy.svg)![ logo-white](https://json-schema.org/logo-white.svg)schema

{"$id": "https://example.com/schemas/customer","$schema": "https://json-schema.org/draft/2020-12/schema",﻿

"type": "object","properties": {"first\_name": {"type": "string"},"last\_name": {"type": "string"},"shipping\_address": {"$ref": "/schemas/address"},"billing\_address": {"$ref": "/schemas/address"}},"required": \["first\_name","last\_name","shipping\_address","billing\_address"\],﻿

"$defs": {"address": {"$id": "https://example.com/schemas/address","$schema": "http://json-schema.org/draft-07/schema#",﻿

"type": "object","properties": {"street\_address": {"type": "string"},"city": {"type": "string"},"state": {"$ref": "#/definitions/state"}},"required": \["street\_address","city","state"\],﻿

"definitions": {"state": {"enum": \["CA","NY","... etc ..."\]}}}}}﻿

All references in a Compound Schema Document need to be the same whether
the Schema Resources are bundled or not. Notice that the `$ref` keywords
from the customer schema have not changed. The only difference is that
the address schema is now defined at `/$defs/address` instead of a
separate schema document. You couldn't use `#/$defs/address` to
reference the address schema because if you unbundled the schema, that
reference would no longer point to the address schema.

Draft-specific info

![info blue](https://json-schema.org/icons/info-blue.svg)

In Draft 4-7, both of these URIs are valid because a subschema
`$id` only represented a base URI change, not an embedded schema.
However, even though it's allowed, it's still highly recommended
that JSON Pointers don't cross a schema with a base URI change.

You should also see that `"$ref": "#/definitions/state"` resolves to the
`definitions` keyword in the address schema rather than the one at the
top level schema like it would if the embedded schema wasn't used.

Each Schema Resource is evaluated independently and may use different
JSON Schema [dialects](https://json-schema.org/learn/glossary#dialect). The example above has the address Schema Resource
using Draft 7 while the customer Schema Resource uses Draft 2020-12. If
no `$schema` is declared in an embedded schema, it defaults to using the
dialect of the parent schema.

Draft-specific info

![info blue](https://json-schema.org/icons/info-blue.svg)

In Draft 4-7, a subschema `$id` is just a base URI change and not
considered an independent Schema Resource. Because `$schema` is
only allowed at the root of a Schema Resource, all schemas bundled
using subschema `$id` must use the same dialect.

Draft-specific info

![info blue](https://json-schema.org/icons/info-blue.svg)

In Draft 2020-12, support for changing dialects in an embedded schema
(using `$schema` with a different value than the parent schema) was added.

[Go Back\\
\\
Boolean JSON Schema combination](https://json-schema.org/understanding-json-schema/reference/combining)

[Up Next\\
\\
Media: string-encoding non-JSON data](https://json-schema.org/understanding-json-schema/reference/non_json_data)

## Need Help?

### Did you find these docs helpful?

### Help us make our docs great!

At JSON Schema, we value docs contributions as much as every other type of contribution!

[Edit this page on Github](https://github.com/json-schema-org/website/blob/main/pages/understanding-json-schema/structuring.md)

[Learn how to contribute](https://github.com/json-schema-org/website/blob/main/CONTRIBUTING.md)

### Still Need Help?

Learning JSON Schema is often confusing, but don't worry, we are here to help!.

[Ask the community on GitHub](https://github.com/orgs/json-schema-org/discussions/new?category=q-a)

[Ask the community on Slack](https://json-schema.org/slack)

![logo-white](https://json-schema.org/img/logos/logo-white.svg)

[Open Collective](https://opencollective.com/json-schema)

[Code of Conduct](https://json-schema.org/overview/code-of-conduct)

[![Slack logo](https://json-schema.org/img/logos/slack_logo_small-white.svg)Slack](https://json-schema.org/slack)

[![X logo](https://json-schema.org/img/logos/x-twitter.svg)X](https://x.com/jsonschema)

[![LinkedIn logo](https://json-schema.org/img/logos/icons8-linkedin-2.svg)LinkedIn](https://linkedin.com/company/jsonschema/)

[![YouTube logo](https://json-schema.org/img/logos/icons8-youtube.svg)Youtube](https://www.youtube.com/@JSONSchemaOrgOfficial)

[![GitHub logo](https://json-schema.org/img/logos/github_logo-white.svg)GitHub](https://github.com/json-schema-org)

Copyright © 2026 JSON Schema. All rights reserved.