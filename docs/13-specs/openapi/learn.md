[Fork me on GitHub](https://github.com/OAI/learn.openapis.org "Fork me on GitHub") [Skip to main content](https://learn.openapis.org/#main-content)LinkMenuExpand(external link)DocumentSearchCopyCopied

- Getting Started
- [Introduction](https://learn.openapis.org/introduction.html)
- [Glossary](https://learn.openapis.org/glossary.html)
- [The OpenAPI Specification Explained](https://learn.openapis.org/specification/)
  - [Structure of an OpenAPI Description](https://learn.openapis.org/specification/structure.html)
  - [API Endpoints](https://learn.openapis.org/specification/paths.html)
  - [HTTP Methods](https://learn.openapis.org/specification/http-methods.html)
  - [Content of Message Bodies](https://learn.openapis.org/specification/content.html)
  - [Parameters and Payload of an Operation](https://learn.openapis.org/specification/parameters.html)
  - [Reusing Description](https://learn.openapis.org/specification/components.html)
  - [Providing Documentation and Examples](https://learn.openapis.org/specification/docs.html)
  - [API Servers](https://learn.openapis.org/specification/servers.html)
  - [Describing API Security](https://learn.openapis.org/specification/security.html)
  - [Enhanced Tags](https://learn.openapis.org/specification/tags.html)
  - [Providing Callbacks](https://learn.openapis.org/specification/callbacks.html)
  - [Providing Webhooks](https://learn.openapis.org/specification/webhooks.html)
  - [Implementing Links](https://learn.openapis.org/specification/links.html)
  - [Sequential Media Types](https://learn.openapis.org/specification/media-types.html)
- [Best Practices](https://learn.openapis.org/best-practices.html)
- [Upgrading Between Versions](https://learn.openapis.org/upgrading/)
  - [Overlay - Upgrading Between Versions 1.0 and 1.1](https://learn.openapis.org/upgrading/overlay-v1.0-to-v1.1.html)
  - [Upgrading from OpenAPI 3.0 to 3.1](https://learn.openapis.org/upgrading/v3.0-to-v3.1.html)
  - [Upgrading from OpenAPI 3.1 to 3.2](https://learn.openapis.org/upgrading/v3.1-to-v3.2.html)
- [Using References](https://learn.openapis.org/referencing/)
  - [References Overview](https://learn.openapis.org/referencing/overview.html)
  - [Resolve References](https://learn.openapis.org/referencing/resolve.html)
  - [Remove References](https://learn.openapis.org/referencing/remove.html)
  - [Dynamic References](https://learn.openapis.org/referencing/dynamic.html)
- [Example API Descriptions](https://learn.openapis.org/examples/)
  - [3.2-query-example](https://learn.openapis.org/examples/v3.2/3.2-query-example.html)
  - [3.2-tags-example](https://learn.openapis.org/examples/v3.2/3.2-tags-example.html)
  - [api-with-examples](https://learn.openapis.org/examples/v3.0/api-with-examples.html)
  - [callback-example](https://learn.openapis.org/examples/v3.0/callback-example.html)
  - [link-example](https://learn.openapis.org/examples/v3.0/link-example.html)
  - [non-oauth-scopes](https://learn.openapis.org/examples/v3.1/non-oauth-scopes.html)
  - [petstore](https://learn.openapis.org/examples/v3.0/petstore.html)
  - [petstore-expanded](https://learn.openapis.org/examples/v3.0/petstore-expanded.html)
  - [tictactoe](https://learn.openapis.org/examples/v3.1/tictactoe.html)
  - [uspto](https://learn.openapis.org/examples/v3.0/uspto.html)
  - [webhook-example](https://learn.openapis.org/examples/v3.1/webhook-example.html)
- [Overlays](https://learn.openapis.org/overlay/)
  - [Example: add a license](https://learn.openapis.org/overlay/example-add-license.html)
  - [Example: tag DELETE operations](https://learn.openapis.org/overlay/example-tag-delete-endpoints.html)
  - [Example: add params selectively](https://learn.openapis.org/overlay/example-add-filter-parameters.html)
  - [Example: copy a schema](https://learn.openapis.org/overlay/example-copy-schema.html)
- [Community](https://learn.openapis.org/community.html)

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.

Search OpenAPI Documentation

# Getting started

## Intended Audience

This guide is directed at **HTTP-based API** designers and writers wishing to benefit from having their API formalized in an **OpenAPI Description** ( **OAD**).

Machine-readable API descriptions are ubiquitous nowadays and **OpenAPI** is **the most broadly adopted industry standard for describing new APIs**. It is therefore worth learning it and getting it right from the start.

These pages are a companion to the [OpenAPI Specification](https://spec.openapis.org/oas/latest) (OAS), helping the reader learn it and answering questions like “What is the best way to accomplish… ?” or “What is the purpose of… ?” that are naturally out of the scope of the specification.

- If you are unsure if this guide is for you, read the next section below.
- If you do not know what “API”, “machine-readable description” or “OpenAPI” mean start by reading the [Introduction](https://learn.openapis.org/introduction) chapter.
- If this is your first time writing an **OpenAPI Description** read [The OpenAPI Specification explained](https://learn.openapis.org/specification) chapter for step-by-step tutorials.
- If you already have **OpenAPI** experience but need help with a specific topic, take a look at the index of [The OpenAPI Specification explained](https://learn.openapis.org/specification) chapter; it also includes advanced topics.
- Finally, make sure you are aware of the recommended [Best Practices](https://learn.openapis.org/best-practices) to take full advantage of **OpenAPI**!
- And of course, you can always refer to the actual [OpenAPI Specification](https://spec.openapis.org/oas/latest) for reference.

## Advantages of Using OpenAPI

Having your API formally described in a machine-readable format allows automated tools to process it, instantly opening the door to:

- **Description Validation and Linting**: Check that your description file is syntactically correct and adheres to a specific version of the Specification and the rest of your team’s formatting guidelines.
- **Data Validation**: Check that the data flowing through your API (in both directions) is correct, during development and once deployed.
- **Documentation Generation**: Create traditional human-readable documentation based on the machine-readable description, which always stays up-to-date.
- **Code Generation**: Create both server and client code in any programming language, freeing developers from having to perform data validation or write SDK glue code, for example.
- **Graphical Editors**: Allow easy creation of description files using a GUI instead of typing them by hand.
- **Mock Servers**: Create fake servers providing example responses that you and your customers can start testing with before you write a single line of code.
- **Security Analysis**: Discover possible vulnerabilities at the API design stage instead of much, much later.

On top of this, the **OpenAPI Specification** also provides you with:

- **A non-proprietary format**: You have a say in the future direction of the Specification!
- **The most developed tooling ecosystem**: As a direct result of the previous statement, OpenAPI offers a vast number of tools to work with it. Just take a quick look at [OpenAPI Tooling](https://tools.openapis.org/).
- **A format readable by both machines and humans**: Even though writing OADs by hand is not the most convenient way of doing it (See [Best Practices](https://learn.openapis.org/best-practices)), they are plain text files which can be easily browsed in case something needs to be debugged.

So, choose your desired entry point from the list at the top of this page and start your journey!

* * *

© 2025 OpenAPI Initiative. [![Creative Commons License](https://i.creativecommons.org/l/by/4.0/80x15.png)](http://creativecommons.org/licenses/by/4.0/)

This work is licensed under a [Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/). The documentation is maintained in [https://github.com/OAI/learn.openapis.org/](https://github.com/OAI/learn.openapis.org/).

This site uses [Just the Docs](https://github.com/just-the-docs/just-the-docs), a documentation theme for Jekyll.