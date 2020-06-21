"use strict";

require("core-js/modules/es.symbol");

require("core-js/modules/es.symbol.description");

require("core-js/modules/es.symbol.iterator");

require("core-js/modules/es.array.iterator");

require("core-js/modules/es.object.to-string");

require("core-js/modules/es.regexp.to-string");

require("core-js/modules/es.string.iterator");

require("core-js/modules/web.dom-collections.iterator");

function _typeof(obj) { "@babel/helpers - typeof"; if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

function update_text(node, x) {
  switch (x.constructor) {
    case String:
      node.innerText = x;
      break;

    default:
      console.log("Invalid value for DOM update.");
  }

  return node;
} // func


function body() {
  var node = document.getElementsByTagName("body")[0];

  for (var i = 0, j = arguments.length; i < j; i++) {
    switch (_typeof(arguments[i])) {
      case 'object':
        node.appendChild(arguments[i]);
        break;

      default:
        console.log("Invalid argument for id(): " + _typeof(arguments[i]) + " " + arguments[i].toString());
    }
  }

  return node;
} // func


function id() {
  var str_id = arguments[0];
  var node = document.getElementById(str_id);

  for (var i = 1, j = arguments.length; i < j; i++) {
    switch (_typeof(arguments[i])) {
      case 'object':
        node.appendChild(arguments[i]);
        break;

      default:
        console.log("Invalid argument for id(): " + _typeof(arguments[i]) + " " + arguments[i].toString());
    }
  }

  return node;
}

function para() {
  return new_element("p", arguments);
} // func
// Example: a_href("http://www.lewrockwell.com", "My Text");


function a_href() {
  var new_args = [];

  for (var i = 0, j = arguments.length; i < j; ++i) {
    if (i == 0) {
      new_args.push({
        href: arguments[i]
      });
    } else {
      new_args.push(arguments[i]);
    }
  }

  return new_element("a", new_args);
} // func


function new_element(name, args) {
  var node = document.createElement(name);

  for (var i = 0, j = args.length; i < j; i++) {
    switch (_typeof(args[i])) {
      case 'string':
        node.appendChild(document.createTextNode(args[i]));
        break;

      case 'object':
        if (args[i].constructor == Object) {
          for (var property in args[i]) {
            node.setAttribute(property, args[i][property]);
          }
        } else {
          node.appendChild(args[i]);
        }

        break;

      default:
        console.log("Invalid argument for id(): " + _typeof(args[i]) + " " + args[i].toString());
    }
  } // for


  return node;
} // func


function span() {
  switch (arguments.length) {
    case 1:
      return new_element("span", [document.createTextNode(arguments[0])]);
      break;

    default:
      return new_element("span", arguments);
  }
} // func


function div() {
  return new_element("div", arguments);
} // func