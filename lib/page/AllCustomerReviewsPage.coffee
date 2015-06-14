Page = require './Page'

module.exports = class AllCustomerReviewsPage extends Page

  #### get review id array.
  getReviewIds: =>
    reviewIds = []
    @$('.review').each (index, element) => 
      id = @$(element).attr('id')?.substring 7
      reviewIds.push id if id

    reviewIds
