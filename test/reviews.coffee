should = require('chai').should()

AmazonReviews = require '../index'

describe 'Top level review methods', ->
  it 'should be able to fetch a single review - getReview', (done) ->
    AmazonReviews.getReview
      productId: 'B00DFFT76U'
      reviewId: 'RDQO5C2XEPVPC'
    , (err, review) ->
      should.not.exist err
      should.exist review
      
      review.title.should.equal 'Swaddlers vs Cruisers Size 4'
      review.starCount.should.equal 5
      should.exist review.descText
      should.exist review.profile
      review.profile.name.should.equal 'Emily'
      review.profile.id.should.equal 'A276OI0NHBYORX'

      done()

  it 'should be able to fetch all of the review ids for a product - getReviewIds', (done) ->
    AmazonReviews.getReviewIds
      productId: 'B004EXWGJW'
    , (err, reviewIds) ->
      should.not.exist err
      should.exist reviewIds

      reviewIds.should.be.an 'array'
      reviewIds.should.have.length.at.least 360


      done()

  it 'should be able to fetch both review ids and reviews for a product - getReviews', (done) ->
    AmazonReviews.getReviews
      productId: 'B014XC8IQI'
    , (err, reviews) ->
      should.not.exist err
      should.exist reviews

      reviews.should.be.an 'array'
      reviews.should.have.length.at.least 5
      reviews[0].should.have.property 'title'

      done()
