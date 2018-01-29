# Common monorepo tasks

Now that we've built out our first monorepo and gotten a feel for what it's like
to use, and develop in, a monorepo let's talk about some common next tasks that
might come up, namely:

- How does versioning work?
- How does publishing work?
- How do I create release notes?
  - Can I use things like `semantic-release` or generate changelogs?
- How does this whole thing work in a CI environment?

## Versioning

As mentioned in [`02-why-use-a-monorepo`](../02-why-use-a-monorepo), packages in
a monorepo typically have two types of versioning modes, namely:

- Independent, all packages are versioned independent of each other
- Fixed, all packages are fixed to the same version number

They both come with their own set of advantages and disadvantages. Typically,
fixed mode comes into play when the monorepo organizers want to have locked-in
versions for their suite of packages to make interop easier. Babel is a great
example of this strategy.

However, one glaring drawback of this approach is that packages may get their
versions bumped without having any kind of semver-related change associated with
the bump.

As a result, some groups prefer to have packages operate in the "independent"
versioning mode so that they can have granular control over package versions,
and can publish packages individually, if needed.

## Publishing

When it comes to publishing, the two strategies heavily tie into what kind of
versioning scheme your monorepo is using. If the project is using an independent
versioning mode, it totally can make sense to go into each project and run your
favorite `publish` command and do this process manually.

The drawbacks for this would be that you as the project owner would have to
manually update other packages that rely on the package you just published.

To solve this, alongside the fixed version mode, often times teams will lean on
custom bash scripts or a tool called [Lerna](https://lernajs.io).

Lerna makes it easy to automate a variety of things for monorepos, the most
notable of which is its `publish` command. The options for which include:

```bash
Command Options:
  --canary, -c            Publish packages after every successful merge using the sha as part of the tag.                                 [default: alpha]
  --cd-version            Skip the version selection prompt and increment semver: 'major', 'minor', 'patch', 'premajor', 'preminor', 'prepatch', or
                          'prerelease'.                                                                                                           [string]
  --conventional-commits  Use angular conventional-commit format to determine version bump and generate CHANGELOG.                               [boolean]
  --changelog-preset      Use another conventional-changelog preset rather than angular.                                                          [string]
  --exact                 Specify cross-dependency version numbers exactly rather than with a caret (^).                                         [boolean]
  --git-remote            Push git changes to the specified remote instead of 'origin'.                                         [string] [default: origin]
  --yes                   Skip all confirmation prompts.                                                                                         [boolean]
  --message, -m           Use a custom commit message when creating the publish commit.                                                           [string]
  --npm-tag               Publish packages with the specified npm dist-tag                                                                        [string]
  --npm-client            Executable used to publish dependencies (npm, yarn, pnpm, ...)                                                          [string]
  --preid                 Specify the prerelease identifier (major.minor.patch-pre).                                                              [string]
  --repo-version          Specify repo version to publish.                                                                                        [string]
  --skip-git              Skip commiting, tagging, and pushing git changes.                                                                      [boolean]
  --skip-npm              Stop before actually publishing change to npm.                                                                         [boolean]
  --temp-tag              Create a temporary tag while publishing.                                                                               [boolean]
  --allow-branch          Specify which branches to allow publishing from
```

The surface area for this command is enormous, but the notable bits are the
following:

- You can manually specify the new version for each changed package with an
  interactive CLI prompt
- You can bump the versions of all changed packages with the same type using
  `--cd-version`
- You can force publish all packages with the same version using
  `--force-publish=*`
- `publish` creates the relevant `npm` versions and git tags for every published
  package
- You can generate changelogs from `--conventional-commits` and choose your
  preset with `--changelog-preset`

It is common to guard `publish` commands with certain checks, like making sure
all your `git` changes are checked-in, in a `bash` script, as well. For example,
a common command for publishing a fixed versioned monorepo might look like:

```bash
./tasks/publish.sh -m "chore(package): version %v" \
  --exact --conventional-commits --cd-version patch --force-publish=*
```

Which will go through and do the following:

- publish all the packages with the given `patch` semver bump
- create the necessary `CHANGELOG.md` files in each project
- create the corresponding `git` tags for the release
- create the corresponding `npm` versions for each package
- rewire each package to use the newly published version

## How do I create release notes?

Thankfully, tools like Lerna publish git tags for each change, and there is an
optional `--conventional-commits` flag that you can pass into publish commands
that generates changelogs for you that you can copy and paste into the relevant
release tag.

## How does this work in a CI environment?

Now that all these packages are being actively developed, the question of CI
builds might come up. In other words, how do we make sure that each project has
a passing "CI build"?

There are typically two strategies for addressing this, namely:

- having the root project handle things like linting, testing, etc
- using a tool like `lerna` to run relevant commands in each package using
  `lerna run <task>`
