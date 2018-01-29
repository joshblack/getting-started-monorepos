# What is a Monorepo?

> A monorepo is the structural approach to organizing software such that source
> code exists in the same conceptual project

In other words, instead of having multiple `git` projects a group just chooses
to maintain one `git` project and place all projects inside of that `git`
project.

This could be something as simple as the following layout:

```
.
├── README.md
└── packages
    ├── package-a
    ├── package-b
    └── package-c
```

In the above tree view, we can see that our project has a simple `README.md`
file, in addition to a `packages` directory. In this setup, all of the
`packages` of a project live in that directory.

## But what about Google, Facebook, etc?

The above example was a very high-level overview of a monorepo. In reality,
these kinds of setup exist and evolve to match the needs of the group that is
managing/using it. You can see in the repo's `README.md` some examples of
how these types of systems are used at a large scale.

For these companies, a monorepo means the following:

- Centralized access control of source files
- The ability for an engineer to make changes to _any part_ of the company's
  codebase (😱)
- The ability to coordinate updates to key dependencies across the company
- The ability to easily reuse hard-learned lessons across the companies through
  developed software

## Why would I care about this for my own offering/team?

The most prevalent examples of monorepos for individuals is, most likely, some
amalgamation of the above examples given for Google, Facebook, Microsoft, etc.
However, there is another approach to thinking about monorepos that can heavily
benefit product teams.

Ultimately, if your team cares about product or portfolio-level consistency, a
monorepo might be a great candidate to solving some of the tough problems that
arise as a result.
