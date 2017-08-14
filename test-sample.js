describe('Sample', function() {
    it("takes a screenshot of www.google.co.jp", function() {
        browser.url('https://www.google.co.jp/');
        browser.saveScreenshot('./screenshots/google.png');
    });
});