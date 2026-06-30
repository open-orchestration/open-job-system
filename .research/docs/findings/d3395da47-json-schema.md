---
id: d3395da47
topic: specs
title: "JSON Schema: validation keywords and schema structuring"
status: draft
shape: reference
---

# JSON Schema: validation keywords and schema structuring

## What a JSON Schema is, and the basic types

JSON stands for "JavaScript Object Notation", a simple data interchange format, and at its heart JSON is built on a set of data structures [ce4bbacfb]. Those structures are `object` (e.g. `{"key1": "value1", "key2": "value2"}`), `array` (e.g. `["first","second","third"]`), `number`, `string`, `boolean`, and `null` [ce4bbacfb]. With these simple data types, all kinds of structured data can be represented, but the same concept could be represented in myriad ways, so when an application asks for a JSON record it is important to know exactly how that record should be organized — what fields are expected and how the values are represented — and that is where JSON Schema comes in [ce4bbacfb].

A JSON Schema describes how data is structured, and the overview gives a worked schema fragment showing the core keywords: `"type": "object"` with a `properties` map whose entries each declare their own `"type"` such as `"string"`, including a nested `address` of `"type": "object"` with its own `properties` [ce4bbacfb]. The overview also shows a string `format`, using `{"type": "string", "format": "date"}` for a birthday field [ce4bbacfb]. Validating a non-conforming instance against this schema fails ("not compliant to schema"), while a conforming instance passes ("compliant to schema") [ce4bbacfb].

The JSON Schema itself is written in JSON — it is data itself, not a computer program, a declarative format for "describing the structure of other data" [ce4bbacfb]. Because a JSON Schema can't contain arbitrary code, there are certain constraints on relationships between data elements that can't be expressed, so a validation tool for a sufficiently complex format will likely have two phases: one at the schema (structural) level and one at the semantic level, the latter implemented in a more general-purpose programming language [ce4bbacfb].

## What the reference covers (high level)

The reference page is largely an index: it presents JSON Schema reference documentation as covering everything from basic data types to advanced techniques like conditional validation and schema composition, learned through JSON Schema keywords with explanations and examples [c569055f7]. Its top-level sections include type-specific keywords (the `type` keyword), dialect and vocabulary declaration, enumerated and constant values, annotations and comments, conditional schema validation, schema composition, and string-encoding non-JSON data [c569055f7]. (This page is mostly a navigational index, so it is cited sparingly here.)

## Structuring: modular and recursive schema combination

Structuring a schema into reusable components is highly beneficial for anything beyond the most trivial cases, and the structuring guide covers the keywords used to combine JSON schemas modularly [c0978fde7].

### Schema identification and base URI

To reference one schema from another you need a way to identify a schema, and schema documents are identified by non-relative URIs [c0978fde7]. Schema documents are not required to have an identifier — schemas with no identifier are called "anonymous schemas" — but you will need one if you want to reference one schema from another [c0978fde7]. These URI identifiers are not necessarily network-addressable; implementations generally don't make HTTP requests or read from the file system to fetch schemas, but instead load schemas into an internal schema database from which a schema is retrieved when referenced by its URI identifier [c0978fde7]. Any URIs used in JSON Schema can be URI-references that resolve against the schema's base URI to produce a non-relative URI, with base URI determination and relative reference resolution defined by RFC-3986 [c0978fde7]. The URI used to fetch a schema is the "retrieval URI", and the base URI for a retrieved schema is, by default, the same as the retrieval URI [c0978fde7].

### `$id`

You set the base URI using the `$id` keyword at the root of the schema; the value of `$id` is a URI-reference without a fragment that resolves against the retrieval URI, and the resulting URI is the base URI for the schema [c0978fde7]. Using a relative reference when setting a base URI can be problematic — for instance an anonymous schema has no retrieval URI to resolve against — so it is recommended that you always use an absolute URI when declaring a base URI with `$id` [c0978fde7].

### Identifying subschemas: JSON Pointer and `$anchor`

You can also identify subschemas; the most common way is a JSON Pointer in the URI fragment, a slash-separated path that traverses the keys in the document (so `/properties/street_address` finds the `properties` value and then its `street_address` value) [c0978fde7]. A less common way is to create a named anchor with the `$anchor` keyword and use that name in the URI fragment; anchors must start with a letter followed by any number of letters, digits, `-`, `_`, `:`, or `.` [c0978fde7].

### `$ref`

A schema can reference another schema using the `$ref` keyword, whose value is a URI-reference resolved against the schema's base URI; when evaluating a `$ref`, an implementation uses the resolved identifier to retrieve the referenced schema and applies that schema to the instance [c0978fde7]. This avoids duplicating a shared subschema (such as an address) everywhere it is used, which keeps the schema less verbose and makes future updates easier to do in a single place [c0978fde7]. When using `$ref` in an anonymous schema, relative references may not be resolvable, because there is no non-relative base URI to resolve them against [c0978fde7].

### `$defs`

For small subschemas intended only for use in the current schema, the `$defs` keyword gives a standardized place to keep subschemas intended for reuse in the current schema document [c0978fde7]. `$defs` is not just good for avoiding duplication; it also makes schemas easier to read and maintain by letting complex parts be defined with descriptive names and referenced where needed [c0978fde7]. Generally you want to limit a `$ref` to referencing either an external schema or an internal subschema defined in `$defs` [c0978fde7].

### Recursion

The `$ref` keyword may be used to create recursive schemas that refer to themselves — for example a `person` schema with an array of `children`, each also a `person`, expressed with `"items": {"$ref": "#"}` — which is both allowed and useful [c0978fde7]. However, a `$ref` referring to another `$ref` could cause an infinite loop in the resolver and is explicitly disallowed [c0978fde7].

### Bundling into a Compound Schema Document

Multiple schema documents can be bundled into a single document using `$id` in a subschema: when `$id` is used in a subschema it indicates an embedded schema, and a document that includes embedded schemas is called a Compound Schema Document, with each `$id`-bearing schema in it called a Schema Resource [c0978fde7]. All references in a Compound Schema Document need to be the same whether the Schema Resources are bundled or not, and each Schema Resource is evaluated independently and may use different JSON Schema dialects (if no `$schema` is declared in an embedded schema, it defaults to the dialect of the parent schema) [c0978fde7].
