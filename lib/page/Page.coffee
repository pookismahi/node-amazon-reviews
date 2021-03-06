request = require 'request'
cheerio = require 'cheerio'
fs = require 'fs'
_ = require 'underscore'
chance = require('chance')()
# random_useragent = require 'random-useragent'

module.exports = class Page

  #### default options for load a web-page.
  defaultOptions:
    headers:
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
      'Accept-Language': 'en-US,en;q=0.8'
      'Cache-Control': 'no-cache'
      'Connection': 'keep-alive'
      'User-Agent': 'Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3'

  #### load and parse the page.
  # `options` must have `url`.
  constructor: (@options) ->
    @requestCount = 0
    @defaultOptions.headers['User-Agent'] = @userAgent()

  load: (callback) ->
    if not @options.url?
      callback new Error 'no url.'
    else
      @makeRequest @options, callback

    return this

  userAgent: () ->
    safariBuild = chance.floating {min: 3214, max: 9985, fixed: 2}
    webkitBuild = chance.floating {min: 256, max: 831, fixed: 2}

    "Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/#{webkitBuild} (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/#{safariBuild}.3"

  makeRequest: (@options, callback) =>
    # console.log "loading url #{@options.url}"
    @requestCount++
    return callback 'exceeded captcha retry count' if @requestCount >= 6
    console.log "got a captcha on request #{@requestCount}" if @requestCount > 1

    _.defaults @options, @defaultOptions
    # @options.headers['User-Agent'] = random_useragent.getRandom()

    request @options, (err, response, body) =>
      return callback err  if err?

      if response?.statusCode isnt 200
        return callback new Error "#{response.statusCode} - #{body}"

      # filename = "#{Date.now()}.html"
      # console.log "writing file #{filename}"
      # fs.writeFileSync filename, body

      wait = chance.integer {min: 5000, max: 30000}
      return _.delay @makeRequest, wait * @requestCount, @options, callback if body.match(/Captcha/)

      # uri = response.request.uri
      # @basePath = uri.href.replace uri.path, ""
      # console.log "base path #{@basePath}"

      @$ = cheerio.load body
      callback null

