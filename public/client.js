function funktio(){

$.get('/tietojanayta', function(data){
	var tieto = data
	var x;
	var out = "";
	for ([x] in tieto) {
		out += "<br>" + data[x].Ytunnus + " " + data[x].yritysnimi + " " + data[x].katuosoite + "";
		
		document.getElementById("tietojanayta").innerHTML = out;
		document.getElementById("tietojanayta").style.display = 'block';
	
	}

});
}