should = require 'should'

ReviewDesktopPage = require '../../lib/page/ReviewDesktopPage'

describe 'ReviewDesktopPage', ->
  describe 'parse()', ->
    it 'should be done', (done) ->
      page = new ReviewDesktopPage
        reviewId: 'RDQO5C2XEPVPC'
      , (err) ->
        should.not.exist err

        result = page.parse()
        should.exist result?.profile
        
        done()
