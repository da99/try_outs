
var koa = require('koa');
var app = koa();

function logger(format) {
  format = format || ':method ":url"';

  return function *logger(next){
    var str = format
      .replace(':method', this.method)
      .replace(':url', this.url);

    console.log(str);

    yield next;
  }
}

app.use(logger(":method -> :url"));

app.use(function *body(next) {
  yield next;
  if (this.path === '/')
    this.body = 'hello world';
  else
    this.body = "unknown response";
});

app.listen(4567, function () {
  console.log('Ready.');
});

