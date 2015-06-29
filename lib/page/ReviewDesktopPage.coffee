Page = require './Page'

module.exports = class ReviewDesktopPage extends Page
  constructor: ({@reviewId}, callback) -> 
    super url: "http://www.amazon.com/review/#{@reviewId}", callback

  parse: ->
    profileTag = @$('.crAuthorInfo').find('a').first()
    profileUrl = profileTag.attr('href')
    profileUrlComponents = profileUrl.split('/')

    profile: 
      name: profileTag.text()
      url: profileUrl
      id: (profileUrlComponents.length >= 5 and profileUrlComponents[4]) or ''

