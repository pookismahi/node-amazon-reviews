Page = require './Page'

module.exports = class ReviewDesktopPage extends Page
  constructor: ({reviewId}, callback) -> 
    super url: "http://www.amazon.com/review/#{reviewId}", callback

  parse: ->
    profileTag = @$('.crAuthorInfo').find('a').first()
    profileUrl = profileTag.attr('href')

    profile: 
      name: profileTag.text()
      url: profileUrl
      id: profileUrl.split('/')[4]

