should = require('chai').should()

AmazonReviews = require '../index'

describe 'Top level review methods', ->
  it 'should be able to fetch a single review - getReview', (done) ->
    AmazonReviews.getReview
      productId: 'B00DFFT76U'
      reviewId: 'R9XOD5IMNSASR'
    , (err, review) ->
      should.not.exist err
      should.exist review
      
      review.title.should.equal 'Work great fpr us...'
      review.starCount.should.equal 5
      review.createdAt.should.eql new Date('10/9/2016')
      review.helpfulCount.should.be.at.least 132
      review.descText.should.have.string 'bad quality knock-off'

      should.exist review.profile
      review.profile.name.should.equal 'Maker Mac'
      review.profile.id.should.equal 'A3175VKD9K8Z38'

      done()

  it 'should be able to fetch all of the review ids for a product - getReviewIds', (done) ->
    AmazonReviews.getReviewIds
      productId: 'B004EXWGJW'
    , (err, reviewIds) ->
      should.not.exist err
      should.exist reviewIds

      reviewIds.should.be.an 'array'
      reviewIds.should.have.length.at.least 300


      done()

  it 'should be able to fetch both review ids and reviews for a product - getReviews', (done) ->
    AmazonReviews.getReviews
      productId: 'B00GMPGW3Q'
    , (err, reviews) ->
      should.not.exist err
      should.exist reviews

      reviews.should.be.an 'array'
      reviews.should.have.length.at.least 5
      reviews[0].should.have.property 'title'

      done()
