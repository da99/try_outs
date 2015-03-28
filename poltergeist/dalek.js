module.exports = {
'Page title is correct': function (test) {
  test
    .open('https://localhost:4568/')
    // .open('http://www.mises.org/')
    .assert.title().is('Almost there...', 'It has title')
    .done();
}
};
