# My first monorepo

This example illustrates how to set up a simple monorepo with the newly
introduced feature for Yarn called
[Workspaces](https://yarnpkg.com/blog/2017/08/02/introducing-workspaces/).

The steps required for setting this up isn't too bad, and includes the
following:

#### Create a folder where your monorepo is going to live in

```bash
mkdir my-monorepo
```

#### Initialize the monorepo with `yarn init`

```bash
cd my-monorepo
# Initialize the `package.json` with defaults
yarn init -y
```

#### Add a `.yarnrc` file so people using yarn have workspaces enabled

```bash
# Sets the `workspaces-experimental` flag to true
echo 'workspaces-experimental true' >> .yarnrc
```

#### Add the `workspaces` key to your `package.json` file with the path to your packages

```bash
# Inside of your `package.json`, just add the following:
{
  "private": true,
  "workspaces": [
    "packages/*"
  ]
}
```

This tells yarn to look in the `packages` directory for, well, packages.

#### Create your first packages and initialize them

```bash
export ROOT=$(pwd)
mkdir -p packages/package-a && \
  cd packages/package-a && \
  yarn init -y && \
  cd $ROOT
mkdir packages/package-b && \
  cd packages/package-b && \
  yarn init -y && \
  cd $ROOT
```

These commands will create your first package folders under `packages`, and
initializes them with that same `yarn init` command we used at the beginning.

#### Wire up your first internal dependency

Now that we have our workspace created, in addition to the packages we're
developing, let's go and add some behavior to `package-a` and then have
`package-b` depend on it.

Inside of `package-a` let's do the following:

##### Add a `main` field to its `package.json` file

```
{
  "main": "index.js"
}
```

##### Add an `index.js` file

```js
'use strict';

module.exports = 'a';
```

Now, inside of `package-b` let's update the `package.json` file to depend on
`package-a` by doing:

```json
{
  "dependencies": {
    "package-a": "1.0.0"
  }
}
```

And create an `index.js` file that looks like the following:

```js
'use strict';

const packageA = require('package-a');

console.log(`Hello, package-${packageA} from package-b!`);
```

If we run the `yarn` command inside of our workspace, that is the `my-monorepo`
folder that has the `packages` directory inside of it, then Yarn will know to
wire up `package-a` to `package-b` from the `dependencies` field in
`package-b/package.json`.

Now that everything is wired up, we can run:

```bash
node packages/package-b/index.js
```

And it should print out:

```bash
'Hello, package-a from package-b!'
```

## Wrapping up

And that's it! The monorepo is setup, the packages are wired together, and so
development of the packages should be good to go 👍.
