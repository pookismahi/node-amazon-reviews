should = require 'should'

AllCustomerReviewsPage = require '../../lib/page/AllCustomerReviewsPage'

PRODUCT_ID = 'B00DFFT76U'

describe 'AllCustomerReviewsPage', ->
  it 'should be done', (done) ->
    page = new AllCustomerReviewsPage
      productId: PRODUCT_ID
    , (err) ->
      should.not.exist err
      page.productId.should.equal PRODUCT_ID
      page.pageNumber.should.equal 1
      page.getReviewIds().should.length 10

      done()
