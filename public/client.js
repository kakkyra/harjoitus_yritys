function funktio(){

$.get('/tietojanayta', function(data){
	var tieto = data
	var x;
	var out = "";
	for ([x] in tieto) {
		out += "<br>" + data[x].Ytunnus + " " + data[x].katuosoite + "";
		
		document.getElementById("tietojanayta").innerHTML = out;
		document.getElementById("tietojanayta").style.display = 'block';
	
	}

});
};

function funktio_tp(){

$.get('/tietojanayta_tp', function(data){
	var tieto = data
	var x;
	var out = "";
	for ([x] in tieto) {
		out += "<br>" + data[x].toimipisteID + " "+ data[x].yritystunnus + " " + data[x].nimi + "";
		
		document.getElementById("tietojanayta_tp").innerHTML = out;
		document.getElementById("tietojanayta_tp").style.display = 'block';
	
	}

});
}