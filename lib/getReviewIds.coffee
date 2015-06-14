async = require 'async'

AllCustomerReviewsPage = require './page/AllCustomerReviewsPage'

#### retrieve review IDs by a productId.
module.exports = ({productId}, callback) ->
  return callback new Error 'no productId' if not productId?

  reviewIds = []
  lastReviewIds = []
  pageNumber = 1

  test = () -> lastReviewIds?.length
  results = () -> callback null, reviewIds

  async.doWhilst (cb) =>
    currentUrl = "http://www.amazon.com/gp/aw/cr/#{productId}/p=#{pageNumber}"
    pageNumber++
    allCustomerReviewsPage = new AllCustomerReviewsPage url:currentUrl, (err) =>
      return cb err if err

      lastReviewIds = allCustomerReviewsPage.getReviewIds()
      reviewIds = reviewIds.concat lastReviewIds
      cb null
  , test, results