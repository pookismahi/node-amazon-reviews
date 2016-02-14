should = require('chai').should()

pageDir = '../lib/page'
Page = require "#{pageDir}/Page"
AllCustomerReviewsPage = require "#{pageDir}/AllCustomerReviewsPage"
ReviewDesktopPage = require "#{pageDir}/ReviewDesktopPage"
ReviewMobilePage = require "#{pageDir}/ReviewMobilePage"

PRODUCT_ID = 'B00DFFT76U'
REVIEW_ID = 'RDQO5C2XEPVPC'

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
        page.getReviewIds().should.length 10

        done()

  describe 'ReviewDesktopPage', ->
    it 'should be able to load a review', (done) ->
      page = new ReviewDesktopPage
        reviewId: REVIEW_ID
      , (err) ->
        should.not.exist err

        result = page.parse()
        should.exist result?.profile
        result.profile.id.should.equal 'A276OI0NHBYORX'
        
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
        result.title.should.equal 'Swaddlers vs Cruisers Size 4'

        done()