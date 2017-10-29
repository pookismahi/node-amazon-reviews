Page = require './Page'

module.exports = class ReviewDesktopPage extends Page
  constructor: ({@reviewId}, callback) -> 
    super url: "http://www.amazon.com/review/#{@reviewId}", callback

  parse: ->
    profileTag = @$('a.author')
    profileUrl = profileTag.attr('href') or ''
    profileUrlComponents = profileUrl?.split('/') or []

    profile: 
      name: profileTag.text()
      url: profileUrl
      id: (profileUrlComponents.length >= 4 and profileUrlComponents[3]) or ''

