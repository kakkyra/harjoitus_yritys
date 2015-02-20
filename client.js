function funktio(){

$.get('/HAE')
	.done(function(data) {
	document.getElementById("tietoja_nayta").innerHTML=JSON.parse(data);
});
}
