Page = require './Page'

module.exports = class AllCustomerReviewsPage extends Page
  constructor: ({productId, pageNumber = 1}) ->
    super url: "https://www.amazon.com/gp/aw/cr/#{productId}/?pageNumber=#{pageNumber}"
    @productId = productId
    @pageNumber = pageNumber

  #### get review id array.
  getReviewIds: =>
    reviewIds = []
    @$('.review').each (index, element) => 
      id = @$(element).attr('id')
      reviewIds.push id if id

    reviewIds
