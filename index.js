// Utility to run a TiddlyWiki under Puppeteer and retrieve the performance log

const puppeteer = require('puppeteer'),
	path = require('path');

(async () => {
	const filepath = process.argv[2];
	if(!filepath) {
		console.error("Missing filepath to TiddlyWiki file");
		process.exit(1);
	}
	const url = `file://${path.resolve(filepath)}`;
	console.log(url);
	const browser = await puppeteer.launch();
	const page = await browser.newPage();
	const navigationPromise = page.waitForNavigation();
	await page.goto(url);
	await page.setViewport({ width: 1440, height: 714 });
	await navigationPromise;
	await page.waitForSelector('.tc-sidebar-lists .tc-tab-buttons > button:nth-child(1)');
	console.log(JSON.parse(await page.evaluate(() => JSON.stringify($tw.perf.logger.buffer))));
	await browser.close();
})();
