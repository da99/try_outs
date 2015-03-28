var webpage = require('webpage').create();
webpage
// .open('https://localhost:4568') // loads a page
.open('http://localhost:4567') // loads a page
.then(function(){ // executed after loading
  webpage.viewportSize = { width:1200, height:900 };
  console.log(webpage.title);
  webpage.render('page.png', {onlyViewport:true});
  slimer.exit();
});
