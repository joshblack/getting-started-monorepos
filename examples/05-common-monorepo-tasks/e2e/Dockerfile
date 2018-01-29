
FROM node:9.4
MAINTAINER joshblack@us.ibm.com

RUN mkdir -p /monorepo
WORKDIR /monorepo

COPY .dockerignore \
  .yarnrc \
  lerna.json \
  package.json \
  README.md \
  yarn.lock \
  ./
COPY packages ./packages
RUN yarn

COPY e2e ./e2e
COPY tasks ./tasks

# Demo-related `git` commands
RUN git init
RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"
RUN git add -A
RUN git commit -m "initial commit"
