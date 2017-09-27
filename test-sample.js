describe('Sample', function() {
    it("takes a screenshot of www.google.com", function() {
        browser.url('https://www.google.com/');
        browser.waitForExist('#lst-ib');
        browser.setValue('#lst-ib', 'yahoooooooo');
        browser.saveScreenshot('./screenshots/google.png');
    });
});