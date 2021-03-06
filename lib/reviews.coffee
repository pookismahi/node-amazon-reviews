_ = require 'underscore'
async = require 'async'

AllCustomerReviewsPage = require './page/AllCustomerReviewsPage'
ReviewMobilePage = require './page/ReviewMobilePage'
ReviewDesktopPage = require './page/ReviewDesktopPage'

#### retrieve review IDs by a productId.
getReviewIds = (options, callback) =>
  reviewIds = []
  lastReviewIds = []
  options.pageNumber = 1

  test = () -> lastReviewIds?.length
  results = () -> callback null, reviewIds

  async.doWhilst (cb) =>
    allCustomerReviewsPage = new AllCustomerReviewsPage(options).load (err) ->
      return cb err if err

      lastReviewIds = allCustomerReviewsPage.getReviewIds()
      reviewIds = reviewIds.concat lastReviewIds

      options.pageNumber++
      cb null
  , test, results

#### retrieve a review by productId and reviewId.
getReview = (options, callback) =>
  reviewMobilePage = new ReviewMobilePage(options).load (err) ->
    return callback err if err?
    review = reviewMobilePage.parse()

    reviewDesktopPage = new ReviewDesktopPage(options).load (err) ->
      # return callback err if err?

      _.defaults review, reviewDesktopPage.parse() if not err
      callback null, review

#### retrieve reviews by a productId.
getReviews = ({productId}, callback) =>
  getReviewIds { productId }, (err, reviewIds) ->
    async.concatSeries reviewIds, (reviewId, callback) ->
      getReview { productId, reviewId }, callback
    , (err, reviews) =>
      callback err, reviews

module.exports = 
  getReviewIds: getReviewIds
  getReview: getReview
  getReviews: getReviews
