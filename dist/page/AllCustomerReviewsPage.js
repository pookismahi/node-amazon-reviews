// Generated by CoffeeScript 2.1.0
(function() {
  var AllCustomerReviewsPage, Page,
    boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

  Page = require('./Page');

  module.exports = AllCustomerReviewsPage = class AllCustomerReviewsPage extends Page {
    constructor({productId, pageNumber = 1}) {
      super({
        url: `https://www.amazon.com/gp/aw/cr/${productId}/?pageNumber=${pageNumber}`
      });
      //### get review id array.
      this.getReviewIds = this.getReviewIds.bind(this);
      this.productId = productId;
      this.pageNumber = pageNumber;
    }

    getReviewIds() {
      var reviewIds;
      boundMethodCheck(this, AllCustomerReviewsPage);
      reviewIds = [];
      this.$('.review').each((index, element) => {
        var id;
        id = this.$(element).attr('id');
        if (id) {
          return reviewIds.push(id);
        }
      });
      return reviewIds;
    }

  };

}).call(this);
