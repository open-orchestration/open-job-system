---
id: d2810d898
topic: specs
title: "API and process description standards: OpenAPI and BPMN"
status: draft
shape: survey
---

# API and process description standards: OpenAPI and BPMN

A survey of two standards for describing, respectively, HTTP APIs and business
processes, drawn only from each standard's own documentation. AsyncAPI is
omitted — see the note at the end.

## OpenAPI — describing HTTP-based APIs

The OpenAPI learn guide is "directed at **HTTP-based API** designers and writers
wishing to benefit from having their API formalized in an **OpenAPI Description**
(**OAD**)" [cba12dca9]. It describes OpenAPI as a way of having an API
"formalized" in a machine-readable artifact called an OpenAPI Description
[cba12dca9]. The guide states that "Machine-readable API descriptions are
ubiquitous nowadays and **OpenAPI** is ... a standard for describing ... APIs"
and positions itself as "a companion to the OpenAPI Specification (OAS)"
[cba12dca9]. The defining property of the format is that "Having your API
formally described in a machine-readable format allows automated tools to process
it," enabling description validation, data validation, documentation generation,
and code generation of "both server and client code" [cba12dca9]. The OAD is
characterized as "a non-proprietary format" and "A format readable by both
machines and humans" whose artifacts "are plain text files" [cba12dca9].

## BPMN — a notation for business process diagrams

The BPMN 2.0 specification page defines the standard by name as "Business Process
Model And Notation" [c27d9d4d3]. It states that "Business Process Model and
Notation has become the de-facto standard for business processes diagrams"
[c27d9d4d3]. On its intended use, the specification says BPMN "is intended to be
used directly by the stakeholders who design, manage and realize business
processes, but at the same time be precise enough to allow BPMN diagrams to be
translated into software process components" [c27d9d4d3]. On the form of the
notation itself, it states that "BPMN has an easy-to-use flowchart-like notation
that is independent of any particular implementation environment" [c27d9d4d3].
The specification is version 2.0, with a publication date of December 2010, and
is categorized under "Business Modeling" and "Domain" [c27d9d4d3].

## Note on AsyncAPI

The AsyncAPI overview source (ccaae1bf9) contains no definitional body prose
about what AsyncAPI *is* — its body is limited to a concepts-section pointer
("This section defines AsyncAPI features and capabilities") plus a
contributor/Docs-contribution guide and site chrome. Its overview page does not
define what AsyncAPI is, so it is omitted here rather than described from
non-definitional text.
