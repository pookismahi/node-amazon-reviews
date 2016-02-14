should = require('chai').should()

AmazonReviews = require '../index'

describe 'getReview()', ->
  it 'should be done', (done) ->
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
      review.profile.name.should.equal 'Rebecca N'
      review.profile.id.should.equal 'A276OI0NHBYORX'

      done()

describe 'getReviewIds()', ->
  it 'should be done', (done) ->
    AmazonReviews.getReviewIds
      productId: 'B004EXWGJW'
    , (err, reviewIds) ->
      should.not.exist err
      should.exist reviewIds
      reviewIds.should.be.an.Array()

      done()

describe 'getReviews()', ->
  it 'should be done', (done) ->
    AmazonReviews.getReviewIds
      productId: 'B004EXWGJW'
    , (err, reviews) ->
      should.not.exist err
      should.exist reviews
      reviews.should.be.an.Array()

      done()
