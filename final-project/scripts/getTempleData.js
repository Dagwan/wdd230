
//creating file to store Json data of temples:
//  1.  Aba Nigeria Temple
//  2.  Billings Montana Temple
//  3.  Johannesburg South Africa Temple
//  4.  Brigham City Utah Temple

//.......................................*..................
var myRequest = new XMLHttpRequest();
myRequest.open('GET', '\directory/temples.json');

myRequest.onload = function () {
    var data = JSON.parse(myRequest.responseText);

    showAbaClosures(data);
    showBillingsClosures(data);
    showJohannesburgClosures(data);
    showBrighamClosures(data);

 //  1.  Aba Nigeria Temple
    function showAbaClosures(jsonObj) {
        var closureDate = jsonObj.temple[0].closures;

        $.each( closureDate, function( index ) {
            var dateData = closureDate[index].date;

            var myP = document.createElement('p');
            myP.textContent = dateData;
            document.getElementById('showAbaClosures').appendChild(myP);
            console.log( index + ": " + dateData );
          });
    }

//  2.  Billings Montana Temple
    function showBillingsClosures(jsonObj) {
        var closureDate = jsonObj.temple[1].closures;

        $.each( closureDate, function( index ) {
            var dateData = closureDate[index].date;

            var myP = document.createElement('p');
            myP.textContent = dateData;
            document.getElementById('showBillingsClosures').appendChild(myP);
            console.log( index + ": " + dateData );
          });
    }

//  3.  Johannesburg South Africa Temple
    function showJohannesburgClosures(jsonObj) {
        var closureDate = jsonObj.temple[3].closures;

        $.each( closureDate, function( index ) {
            var dateData = closureDate[index].date;

            var myP = document.createElement('p');
            myP.textContent = dateData;
            document.getElementById('showJohannesburgClosures').appendChild(myP);
            console.log( index + ": " + dateData );
          });
    }


//  4.  Brigham City Utah Temple
    function showBrighamClosures(jsonObj) {
        var closureDate = jsonObj.temple[3].closures;

        $.each( closureDate, function( index ) {
            var dateData = closureDate[index].date;

            var myP = document.createElement('p');
            myP.textContent = dateData;
            document.getElementById('showBrighamClosures').appendChild(myP);
            console.log( index + ": " + dateData );
          });
    }
}

myRequest.send();