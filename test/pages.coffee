should = require('chai').should()

pageDir = '../lib/page'
Page = require "#{pageDir}/Page"
AllCustomerReviewsPage = require "#{pageDir}/AllCustomerReviewsPage"
ReviewDesktopPage = require "#{pageDir}/ReviewDesktopPage"
ReviewMobilePage = require "#{pageDir}/ReviewMobilePage"

PRODUCT_ID = 'B00DFFT76U'
REVIEW_ID = 'R9XOD5IMNSASR'

PRODUCT_ID2 = 'B004EXWGJW'
REVIEW_ID2 = 'R31A3TLCC0QNFZ'

describe 'Pages', ->

  describe 'Page', ->
    it 'should be able to fetch google.com', (done) ->
      page = new Page
        url: 'http://www.google.com'
      , (err) ->
        should.not.exist err
        should.exist page.$
        done()

    it 'should have a `no url.` error', (done) ->
      page = new Page {}, (err) ->
        should.exist err
        done()

  describe 'AllCustomerReviewsPage', ->
    it 'should be able to load review ids for a product', (done) ->
      page = new AllCustomerReviewsPage
        productId: PRODUCT_ID
      , (err) ->
        should.not.exist err
        page.productId.should.equal PRODUCT_ID
        page.pageNumber.should.equal 1
        reviewIds = page.getReviewIds()
        reviewIds.should.have.length 10
        reviewIds[0].should.have.length.at.least 13

        done()

    it 'should be able to load multiple pages for a product', (done) ->
      page1 = new AllCustomerReviewsPage
        productId: PRODUCT_ID
      , (err) ->
        should.not.exist err

        page2 = new AllCustomerReviewsPage
          productId: PRODUCT_ID
          pageNumber: 2
        , (err) ->
          should.not.exist err

          page2.pageNumber.should.equal 2
          page2.getReviewIds().should.have.length 10
          page1.getReviewIds().should.not.deep.equal page2.getReviewIds()

          done()

  describe 'ReviewDesktopPage', ->
    it 'should be able to load a review', (done) ->
      page = new ReviewDesktopPage
        reviewId: REVIEW_ID
      , (err) ->
        should.not.exist err

        result = page.parse()
        should.exist result?.profile
        result.profile.should.have.property 'name', 'Maker Mac'
        result.profile.should.have.property 'id', 'amzn1.account.AFTPHZSATSBK4CWUPSWK53VGJ63Q'
        
        done()

    it 'should be able to load a review without an author profile', (done) ->
      page = new ReviewDesktopPage
        reviewId: REVIEW_ID2
      , (err) ->
        should.not.exist err

        result = page.parse()
        result.should.have.property.profile
        result.profile.should.have.property 'name', ''
        result.profile.should.have.property 'url', ''
        result.profile.should.have.property 'id', ''
        
        done()      

  describe 'ReviewMobilePage', ->
    it 'should be able to load a review', (done) ->
      page = new ReviewMobilePage
        productId: PRODUCT_ID
        reviewId: REVIEW_ID
      , (err) ->
        should.not.exist err

        result = page.parse()
        should.exist result
        result.id.should.equal REVIEW_ID
        result.productId.should.equal PRODUCT_ID
        result.title.should.equal 'Work great fpr us...'
        result.starCount.should.equal 5
        result.createdAt.should.eql new Date('10/9/2016')
        result.helpfulCount.should.be.at.least 132
        result.descText.should.have.string 'bad quality knock-off'

        done()