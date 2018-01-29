# Common monorepo tasks

Now that we've built out our first monorepo and gotten a feel for what it's like
to use, and develop in, a monorepo let's talk about some common next tasks that
might come up, namely:

- How does publishing work?
- How do I create release notes?
- How does this whole thing work in a CI environment?
- How do I onboard contributors to this new monorepo design?

## Publishing

```bash
./tasks/publish.sh -m "chore(package): version %v" \
  --exact --conventional-commits --cd-version patch --force-publish=*
```
