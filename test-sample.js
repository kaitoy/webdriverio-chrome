describe('Sample', function() {
    it("takes s screenshot of www.google.co.jp", function() {
        browser.url('https://www.google.co.jp/');
        browser.saveScreenshot('./screenshots/google.png');
    });
});