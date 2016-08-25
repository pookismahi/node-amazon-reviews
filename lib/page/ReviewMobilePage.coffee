Page = require './Page'
S = require 'string'

RATING_SELECTOR = '.a-icon-star'

module.exports = class ReviewMobilePage extends Page
  constructor: ({@productId, @reviewId}, callback) -> 
    super url: "http://www.amazon.com/gp/aw/review/#{@productId}/#{@reviewId}", callback

  parse: () =>
    descSelector = "p#review-#{@reviewId}"

    starString = @$(RATING_SELECTOR).attr('class')?.replace /.*a-star-(\d*).*/g, '$1'
    dateText = @$('span.a-color-secondary').first().text().split('-')[1].replace /\n/g, ''

    # replace all br tags to new lines.
    descTag = @$(descSelector).find('br').replaceWith '\n'
    # replace the rating content so that it doesn't obscure the title
    @$(RATING_SELECTOR).replaceWith ''

    id: @reviewId
    productId: @productId
    title: S(@$('.review h4').text()).trim().s
    starCount: S(starString).toInt()
    createdAt: new Date dateText
    descText: S(@$(descSelector).text()).trim().s
    helpfulCount: S(@$('.votes-helpful').text()).toInt()
    voteCount: S(@$('.votes-total').text()).toInt()
        
