var d = new Date();


document.getElementById("date").value = d.toDateString();


var hours = d.getHours();
var mins = d.getMinutes();
var seconds = d.getSeconds();
document.getElementById("time").value = hours + ":" + mins + ":" + seconds;