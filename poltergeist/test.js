// casperjs --web-security=no --ignore-ssl-errors=true --ssl-protocol=tlsv1 casper.js 
//
//

phantom.onError = function(msg, trace) {
  var msgStack = ['PHANTOM ERROR: ' + msg];
  if (trace && trace.length) {
    msgStack.push('TRACE:');
    trace.forEach(function(t) {
      msgStack.push(' -> ' + (t.file || t.sourceURL) + ': ' + t.line + (t.function ? ' (in function ' + t.function +')' : ''));
    });
  }
  console.error(msgStack.join('\n'));
  phantom.exit(1);
};

var page = require('webpage').create();
// var _ = require('underscore');
// var a = require('assert');

var v = null;

var sites = ['https://localhost:4568'];
var line  = [];
while (v = sites.shift()) {
  line.push(v);
  // console.log(a.fail);
  page.open('https://localhost:4568/', function (status) {
    line.pop();
    console.log('Status: ' + status);
    // console.log(assert.equal);


    if (line.length === 0) {
    // It is very important to call
    // phantom.exit at some point in
    // the script, otherwise PhantomJS
    // will not be terminated at all.
    phantom.exit();
    }
  });

}

