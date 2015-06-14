ReviewMobilePage = require './page/ReviewMobilePage'
ReviewDesktopPage = require './page/ReviewDesktopPage'
_ = require 'underscore'

#### retrieve a review by productId and reviewId.
module.exports = (options, callback) ->
  reviewMobilePage = new ReviewMobilePage options, (err) ->
    return callback err if err?
    review = reviewMobilePage.parse()

    reviewDesktopPage = new ReviewDesktopPage options, (err) ->
      return callback err if err?

      _.defaults review, reviewDesktopPage.parse()
      callback null, review
