async = require 'async'

AllCustomerReviewsPage = require './page/AllCustomerReviewsPage'

#### retrieve review IDs by a productId.
module.exports = (options, callback) ->
  reviewIds = []
  lastReviewIds = []
  options.pageNumber = 1

  test = () -> lastReviewIds?.length
  results = () -> callback null, reviewIds

  async.doWhilst (cb) =>
    allCustomerReviewsPage = new AllCustomerReviewsPage options, (err) =>
      return cb err if err

      lastReviewIds = allCustomerReviewsPage.getReviewIds()
      reviewIds = reviewIds.concat lastReviewIds

      options.pageNumber++
      cb null
  , test, results