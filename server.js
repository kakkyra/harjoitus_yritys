

/*Määritellään muuttujia ja hakemistopolku html ja javascript-tiedostoille*/
var express = require('express');
var app = express();
var path = require("path");
app.use(express.static(__dirname + '/public'));

/*MySQL-yhteyttä varten tarvittavat muuttujat*/
var mysql = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'hiiri321',
  database : 'yritys2'
});

/*Avataan yhteys kantaan*/
connection.connect(); {
  console.log('Yhteys luotu');
};

/*Määritellään, palvelimen asetuksia*/
var server = app.listen(3000, '127.0.0.1',function () {
        var host = server.address().address
        var port = server.address().port
        console.log('Example app listening at http://%s:%s', host, port)
}); 

app.get('/tietojanayta', function(req, res) {
	var strQuery = 'SELECT Ytunnus, yritysnimi, katuosoite from YRITYS';
	var sendThis;

	connection.query( strQuery, function(err, rows, resp) {
  		sendThis = rows; //(JSON.stringify(rows));
      res.send(sendThis);
      console.log(rows);
      });
})

