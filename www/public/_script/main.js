"use strict";

require("core-js/modules/es.object.to-string");

require("core-js/modules/es.regexp.to-string");

Handlers.watch_reload();

function incr() {
  var node = id("the_count");
  var new_total = parseInt(node.innerText) + 1;
  update_text(node, new_total.toString());
  console.log("Updated.");
  body(para(a_href("http://www.lewrockwell.com", "New: ", new Date().getSeconds().toString())));
  Handlers.run("incr", {
    amount: 1
  });
  return null;
} // func


Handlers.add("on page load", function () {
  body(para({
    id: "init_p"
  }, span("Page has loaded.")));
});
Handlers.add("on page load", function set_button_incr() {
  id("incr_btn").onclick = incr;
});
Handlers.add("incr", function (data) {
  body(div({
    'class': 'skyblue'
  }, "Number increased by: " + data.amount));
});
Handlers.run("on page load");