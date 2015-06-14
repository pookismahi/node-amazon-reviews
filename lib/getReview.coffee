ReviewMobilePage = require './page/ReviewMobilePage'
ReviewDesktopPage = require './page/ReviewDesktopPage'
_ = require 'underscore'

#### retrieve a review by productId and reviewId.
module.exports = ({productId, reviewId}, callback) ->
  return callback new Error 'no productId' if not productId
  return callback new Error 'no reviewId' if not reviewId

  mobileUrl = "http://www.amazon.com/gp/aw/review/#{productId}/#{reviewId}"
  desktopUrl = "http://www.amazon.com/review/#{reviewId}"

  reviewMobilePage = new ReviewMobilePage url: mobileUrl, (err) ->
    return callback err if err?
    review = reviewMobilePage.parse()

    reviewDesktopPage = new ReviewDesktopPage url: desktopUrl, (err) ->
      return callback err if err?

      _.defaults review, reviewDesktopPage.parse()
      callback null, review
