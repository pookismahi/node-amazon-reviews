Page = require './Page'
S = require 'string'

module.exports = class ReviewMobilePage extends Page
  constructor: ({@productId, @reviewId}, callback) -> 
    super url: "http://www.amazon.com/gp/aw/review/#{@productId}/#{@reviewId}", callback

  parse: () =>
    descSelector = ".review-text"

    starString = @$('.review-rating').attr('class')?.replace /.*a-star\D*(\d*).*/g, '$1'
    dateText = @$('.review-date').text().match(/[a-zA-Z]+ \d+, \d{4}/)[0]

    # replace all br tags to new lines.
    descTag = @$(descSelector).find('br').replaceWith '\n'

    id: @reviewId
    productId: @productId
    title: S(@$('.review-title').text()).trim().s
    starCount: S(starString).toInt()
    createdAt: new Date dateText
    descText: S(@$(descSelector).text()).trim().s
    helpfulCount: S(@$('.cr-vote-text').text()).toInt() or 0
    # voteCount: S(@$('.votes-total').text()).toInt() or 0
        
