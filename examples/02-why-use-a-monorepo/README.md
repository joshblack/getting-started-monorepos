# Why use a monorepo?

For those looking at these examples, the most likely reason for wanting to
leverage a monorepo would be to help consolidate a variety of configuration for
products for your offering or portfolio.

Keeping these types of packages in the same place allows for the following:

- Configuration-based packages all exist in the same place versus spread across
  a GitHub organization, or multiple GitHub organizations
- Working across packages that depend on each other becomes simpler
- Orchestrating releases with packages that have updating versions

## It's better when we're together

The maintenance overhead that presents itself for `n` packages spread across a
GitHub organization, or multiple organizations, is very intimidating. With UI
development, it's become very common to have various versions of configurations
for tools like:

- Testing
- Linting
- Formatting
- Browser support list (`browserslist`)
- Polyfills
- Tools/utilities

The problem compounds itself as your project might have different targets. For
example, if you require different linting configuration for software written
with the Browser in mind, versus a platform like Node.js or Electron.

As a result, your GitHub organization could become filled with ad-hoc, or
one-off, projects that require some semblance of consistency for the following
project-related items:

- Repository documentation
  - `README.md`
  - `CONTRIBUTING.md`
  - `CODE_OF_CONDUCT.md`
  - `SUPPORT.md`
- Repository `.git` settings
  - `.gitignore`
- Editor settings
  - `.editorconfig`
  - `.vscode`
- CI Settings
  - Jenkins/Ghenkins
  - TravisCI
- `package.json` scripts
- GitHub-specific requirements
  - Labels
  - Milestones
  - Contributor permissions
  - Branch protection status
  - CI hooks

As a result, you end up with all this setup that needs to be shared across all
of your projects in order to stay in sync.

This problem is definitely solvable, and we're trying to handle this with
projects like [Carbon `sync`](https://github.com/carbon-design-system/sync), but
it's definitely annoying to focus on issues that aren't related to the domain of
the software we're trying to create.

With a monorepo design, all the projects get to inherit all the setup specified
above. This eliminates the problem of keeping the project setup of each of these
packages up-to-date, and ultimately allows the team to focus on domain-specific
problems for the work that they're doing.

## Dependency link nightmare

The other side of a monorepo setup that might attract product teams is how it
can simplify the management of packages that depend on each other.

A tangible example of this that frequently comes up are `eslint` configurations.
Airbnb popularized the notion of a `base` config, and then a standard
configuration. However, one could imagine a similar setup if you just want to
have an `eslint` config for Node.js and the browser.

With this problem in mind, one would most likely create the `base` config and
then have `eslint-web` and `eslint-node` extent upon that `base`.

When projects are spread out across a GitHub organization, the common way to do
active development on the `eslint-web` package would be to use `npm link`, or
`yarn link`.

These `link` commands allow you to register the local package on your machine,
so that if you do `yarn link eslint-base` then that local package is installed
into the current projects `node_modules` directory.

While this workflow can support simple links, it definitely grows in complexity
as the number of packages, and links between them, grow.

When using a monorepo setup, this problem disappears. For typical monorepo tools
in the JS-ecosystem, all it takes is an `install` command and all the relevant
package dependencies are installed, or linked, and references to local packages
are always kept up-to-date.

On your machine, this would look like the following:

```bash
.
├── README.md
├── node_modules
│   ├── package-a -> ../packages/package-a
│   ├── package-b -> ../packages/package-b
│   └── package-c -> ../packages/package-c
├── package.json
├── packages
│   ├── package-a
│   │   ├── index.js
│   │   └── package.json
│   ├── package-b
│   │   ├── index.js
│   │   └── package.json
│   └── package-c
│       ├── index.js
│       └── package.json
└── yarn.lock
```

So now, one doesn't have to worry about `link` commands or working with remote
versus local projects as this would be handled by the monorepo setup.

## Versions, versions, versions, oh my!

The last bit of this already long section is how monorepos can help with
versioning dependencies. While certain tools don't provide these kinds
of capabilities out-of-the-box, there are tools that help with this topic
specifically that anyone can leverage.

When it comes to versioning, most likely there is an assumption that groups try
to follow semver as closely as possible. However, this can quickly become a
maintenance nightmare as the ecosystem of packages one maintains grows.

Imagine you are publishing packages `A`, `B`, `C`, and `D` with the following
relationships:

- `A` is a standalone package and has the versions:
  - `v1.0.0`
  - `v2.0.0`
  - `v3.0.0`
- `B` is a package that depends on:
  - `A@v2.0.0`
- `C` is a package that depends on:
  - `A@v1.0.0`
- `D` is a package that depends on:
  - `A@v3.0.0`
  - `B`
  - `C`

Very quickly, this starts becoming a massive headache to try and understand what
packages depend on what versions of other local packages. And this problem grows
as the number of packages in your ecosystem increases 😞.

In a monorepo setup, there are typically two ideas of versioning modes:

- Independent, which lets each package follow it's own versioning scheme
- Group, all packages have the same version numbers

Both of these can help solve the maintenance nightmare of the above example.
