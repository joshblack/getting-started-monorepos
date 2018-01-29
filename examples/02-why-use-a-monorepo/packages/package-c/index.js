'use strict';

const packageA = require('package-a');
const packageB = require('package-b');

console.log(
  [
    packageA,
    packageB,
    packageA + packageB + 'C',
  ].join(' ')
);
