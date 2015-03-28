// casperjs --web-security=no --ignore-ssl-errors=true --ssl-protocol=tlsv1 casper.js
//npm-underscore-test.js
var fs = require('fs');
console.log(require.paths);
require.paths.push(fs.workingDirectory + '/node_modules/');
// require.paths.push(fs.workingDirectory + '/node_modules/');
var _ = require('underscore');
var casper = require('casper').create();
var urls = _.uniq([
  'http://localhost:4567/',
  'https://localhost:4568/',
  'http://www.craigslist.org/robots.txt'
]);

// console.log(require('underscore'));

casper.start().eachThen(urls, function(response) {
  this.thenOpen(response.data, function(response) {
    this.echo(this.getTitle());
  });
});

casper.run();
