// Generated by CoffeeScript 2.1.0
(function() {
  var Page, _, chance, cheerio, fs, request;

  request = require('request');

  cheerio = require('cheerio');

  fs = require('fs');

  _ = require('underscore');

  chance = require('chance')();

  // random_useragent = require 'random-useragent'
  module.exports = Page = (function() {
    class Page {
      //### load and parse the page.
      // `options` must have `url`.
      constructor(options) {
        this.makeRequest = this.makeRequest.bind(this);
        this.options = options;
        this.requestCount = 0;
        this.defaultOptions.headers['User-Agent'] = this.userAgent();
      }

      load(callback) {
        if (this.options.url == null) {
          callback(new Error('no url.'));
        } else {
          this.makeRequest(this.options, callback);
        }
        return this;
      }

      userAgent() {
        var safariBuild, webkitBuild;
        safariBuild = chance.floating({
          min: 3214,
          max: 9985,
          fixed: 2
        });
        webkitBuild = chance.floating({
          min: 256,
          max: 831,
          fixed: 2
        });
        return `Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/${webkitBuild} (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/${safariBuild}.3`;
      }

      makeRequest(options, callback) {
        this.options = options;
        // console.log "loading url #{@options.url}"
        this.requestCount++;
        if (this.requestCount >= 6) {
          return callback('exceeded captcha retry count');
        }
        if (this.requestCount > 1) {
          console.log(`got a captcha on request ${this.requestCount}`);
        }
        _.defaults(this.options, this.defaultOptions);
        // @options.headers['User-Agent'] = random_useragent.getRandom()
        return request(this.options, (err, response, body) => {
          var wait;
          if (err != null) {
            return callback(err);
          }
          if ((response != null ? response.statusCode : void 0) !== 200) {
            return callback(new Error(`${response.statusCode} - ${body}`));
          }
          // filename = "#{Date.now()}.html"
          // console.log "writing file #{filename}"
          // fs.writeFileSync filename, body
          wait = chance.integer({
            min: 5000,
            max: 30000
          });
          if (body.match(/Captcha/)) {
            return _.delay(this.makeRequest, wait * this.requestCount, this.options, callback);
          }
          // uri = response.request.uri
          // @basePath = uri.href.replace uri.path, ""
          // console.log "base path #{@basePath}"
          this.$ = cheerio.load(body);
          return callback(null);
        });
      }

    };

    //### default options for load a web-page.
    Page.prototype.defaultOptions = {
      headers: {
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        'Accept-Language': 'en-US,en;q=0.8',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3'
      }
    };

    return Page;

  })();

}).call(this);
