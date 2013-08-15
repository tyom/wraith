var system = require('system');
var casper = require('casper').create({
  verbose: true,
  logLevel: 'debug'
});

var url = casper.cli.args[0];
var viewportWidth = casper.cli.args[1];
var imageName = casper.cli.args[2];
var screenAspectRatio = 4/3;
var domain = url.match(/https?:\/\/([\w]+:[\w]+@)?([\w]+\.)?(?:[\w]+\.)(?:\.?[\w]{2,})+(:[\d]+)?/)[0];

casper.start();
	.thenOpen(url)
	.then(function() {
		this.capture(imageName);
	});
casper.viewport(viewportWidth, viewportWidth/screenAspectRatio)

casper.run();
