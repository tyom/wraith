var system = require('system');
var casper = require('casper').create({
	verbose: true,
	logLevel: 'debug'
});

var url = casper.cli.args[0];
var viewportWidth = casper.cli.args[1];
var imageName = casper.cli.args[2];


casper.start();
casper.viewport(viewportWidth, 1500)
	.thenOpen(url)
	.then(function() {
		this.capture(imageName);
	});

casper.run();
