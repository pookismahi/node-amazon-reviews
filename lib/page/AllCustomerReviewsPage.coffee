Page = require './Page'

module.exports = class AllCustomerReviewsPage extends Page
  constructor: ({@productId, @pageNumber}, callback) -> 
    @pageNumber ?= 1
    super url: "http://www.amazon.com/gp/aw/cr/#{@productId}/p=#{@pageNumber}", callback

  #### get review id array.
  getReviewIds: =>
    reviewIds = []
    @$('.review').each (index, element) => 
      id = @$(element).attr('id')?.substring 7
      reviewIds.push id if id

    reviewIds
