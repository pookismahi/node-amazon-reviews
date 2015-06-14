Page = require './Page'
S = require 'string'

module.exports = class ReviewMobilePage extends Page
  constructor: ({productId, reviewId}, callback) -> 
    super url: "http://www.amazon.com/gp/aw/review/#{productId}/#{reviewId}", callback

  parse: () ->
    # replace all br tags to new lines.
    descTag = @$('.a-spacing-micro').find('br').replaceWith '\n'
    starString = @$('.a-icon-star').attr('class')?.replace /.*a-star-(\d*).*/g, '$1'
    dateText = @$('span.a-color-secondary').first().text().split('-')[1].replace /\n/g, ''

    title: S(@$('.review h4').text()).trim().s
    starCount: S(starString).toInt()
    createdAt: new Date dateText
    descText: S(@$('.a-spacing-micro').text()).trim().s
    helpfulCount: S(@$('.votes-helpful').text()).toInt()
    voteCount: S(@$('.votes-total').text()).toInt()
        
