Page = require './Page'

module.exports = class ReviewDesktopPage extends Page
  parse: ->
    profileTag = @$('.crAuthorInfo').find('a').first()
    profileUrl = profileTag.attr('href')

    profile: 
      name: profileTag.text()
      url: profileUrl
      id: profileUrl.split('/')[4]

