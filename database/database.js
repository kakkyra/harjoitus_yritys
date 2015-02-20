function Database() {

  if(typeof this.mysql == "undefined") {
    this.init();
  }
}
Database.prototype.init = function() {

  var mysql = require('mysql');