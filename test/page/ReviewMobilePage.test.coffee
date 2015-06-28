should = require 'should'

ReviewMobilePage = require '../../lib/page/ReviewMobilePage'

PRODUCT_ID = 'B00DFFT76U'
REVIEW_ID = 'RDQO5C2XEPVPC'

describe 'ReviewMobilePage', ->
  describe 'parse()', ->
    it 'should be done', (done) ->
      page = new ReviewMobilePage
        productId: PRODUCT_ID
        reviewId: REVIEW_ID
      , (err) ->
        should.not.exist err

        result = page.parse()
        should.exist result
        result.id.should.equal REVIEW_ID
        result.productId.should.equal PRODUCT_ID
        result.title.should.equal 'Swaddlers vs Cruisers Size 4'

        done()
