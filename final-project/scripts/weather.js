
//Aba Nigeria Temple
var abaRequest = new XMLHttpRequest();
abaRequest.open('GET', '//api.openweathermap.org/data/2.5/weather?id=' + 2328925 + '&units=imperial&async=true' + '&APPID=e1c2fa071442126c23a59d8b22e2f565');
abaRequest.onload = function () {

    var data = JSON.parse(abaRequest.responseText);


        var temp = data.main.temp;
        var humid = data.main.humidity;
        function rain(precip){
            if (precip == undefined) {
                precip = 0;
            } else {
                precip = data.rain['3h'];
            }
            return precip;
        }
        var precip = rain();
        var wind = data.wind.speed;
        document.getElementById('curTempAba').innerHTML = temp + "&deg;F";
        document.getElementById('humidityAba').innerHTML = humid + "&#37;";
        document.getElementById('precipitationAba').innerHTML = precip + " inches";
        document.getElementById('windAba').innerHTML = wind + " mph";


        var f = 35.74 + 0.6215 * temp -35.75 * Math.pow(wind, 0.16) + 0.4275 * temp * Math.pow(wind, 0.16);

        var chill = parseFloat(f).toFixed(2);
        document.getElementById('windChillAba').innerHTML = chill;

        var wImg = document.getElementById('wImageAba');

        var myImage = document.createElement('img');


        myImage.src = 'http://openweathermap.org/img/w/' + data.weather[0].icon + '.png';
        wImg.appendChild(myImage);
        
        document.getElementById('imgDescriptionAba').innerHTML = "<p>" + data.weather[0].description + "</p>";

        document.getElementById('curDescAba').innerHTML = "<p>" + data.weather[0].description + "</p>";

};

abaRequest.send();


//Johannesburg South Africa Temple
var johannesburgRequest = new XMLHttpRequest();
johannesburgRequest.open('GET', '//api.openweathermap.org/data/2.5/weather?id=' + 953987 + '&units=imperial&async=true' + '&APPID=e1c2fa071442126c23a59d8b22e2f565');
johannesburgRequest.onload = function () {

    var data = JSON.parse(johannesburgRequest.responseText);


        var temp = data.main.temp;
        var humid = data.main.humidity;
        function rain(precip){
            if (precip == undefined) {
                precip = 0;
            } else {
                precip = data.rain['3h'];
            }
            return precip;
        }
        var precip = rain();
        var wind = data.wind.speed;
        document.getElementById('curTempJohannesburg').innerHTML = temp + "&deg;F";
        document.getElementById('humidityJohannesburg').innerHTML = humid + "&#37;";
        document.getElementById('precipitationJohannesburg').innerHTML = precip + " inches";
        document.getElementById('windJohannesburg').innerHTML = wind + " mph";


        var f = 35.74 + 0.6215 * temp -35.75 * Math.pow(wind, 0.16) + 0.4275 * temp * Math.pow(wind, 0.16);

        var chill = parseFloat(f).toFixed(2);
        document.getElementById('windChillJohannesburg').innerHTML = chill;

        var wImg = document.getElementById('wImageJohannesburg');

        var myImage = document.createElement('img');


        myImage.src = 'http://openweathermap.org/img/w/' + data.weather[0].icon + '.png';
        wImg.appendChild(myImage);
        
        document.getElementById('imgDescriptionJohannesburg').innerHTML = "<p>" + data.weather[0].description + "</p>";

        document.getElementById('curDescJohannesburg').innerHTML = "<p>" + data.weather[0].description + "</p>";

};

johannesburgRequest.send();


//Billings Montana Temple
var billingsRequest = new XMLHttpRequest();
billingsRequest.open('GET', '//api.openweathermap.org/data/2.5/weather?id=' + 5506956 + '&units=imperial&async=true' + '&APPID=e1c2fa071442126c23a59d8b22e2f565');
billingsRequest.onload = function () {

    var data = JSON.parse(billingsRequest.responseText);


        var temp = data.main.temp;
        var humid = data.main.humidity;
        function rain(precip){
            if (precip == undefined) {
                precip = 0;
            } else {
                precip = data.rain['3h'];
            }
            return precip;
        }
        var precip = rain();
        var wind = data.wind.speed;
        document.getElementById('curTempBillings').innerHTML = temp + "&deg;F";
        document.getElementById('humidityBillings').innerHTML = humid + "&#37;";
        document.getElementById('precipitationBillings').innerHTML = precip + " inches";
        document.getElementById('windBillings').innerHTML = wind + " mph";


        var f = 35.74 + 0.6215 * temp -35.75 * Math.pow(wind, 0.16) + 0.4275 * temp * Math.pow(wind, 0.16);

        var chill = parseFloat(f).toFixed(2);
        document.getElementById('windChillBillings').innerHTML = chill;

        var wImg = document.getElementById('wImageBillings');

        var myImage = document.createElement('img');


        myImage.src = 'http://openweathermap.org/img/w/' + data.weather[0].icon + '.png';
        wImg.appendChild(myImage);
        
        document.getElementById('imgDescriptionBillings').innerHTML = "<p>" + data.weather[0].description + "</p>";

        document.getElementById('curDescBillings').innerHTML = "<p>" + data.weather[0].description + "</p>";

};

billingsRequest.send();


// Brigham City Utah Temple
var brighamRequest = new XMLHttpRequest();
brighamRequest.open('GET', '//api.openweathermap.org/data/2.5/weather?id=' + 4979245 + '&units=imperial&async=true' + '&APPID=e1c2fa071442126c23a59d8b22e2f565');
brighamRequest.onload = function () {

    var data = JSON.parse(brighamRequest.responseText);


        var temp = data.main.temp;
        var humid = data.main.humidity;
        function rain(precip){
            if (precip == undefined) {
                precip = 0;
            } else {
                precip = data.rain['3h'];
            }
            return precip;
        }
        var precip = rain();
        var wind = data.wind.speed;
        document.getElementById('curTempBrigham').innerHTML = temp + "&deg;F";
        document.getElementById('humidityBrigham').innerHTML = humid + "&#37;";
        document.getElementById('precipitationBrigham').innerHTML = precip + " inches";
        document.getElementById('windBrigham').innerHTML = wind + " mph";


        var f = 35.74 + 0.6215 * temp -35.75 * Math.pow(wind, 0.16) + 0.4275 * temp * Math.pow(wind, 0.16);

        var chill = parseFloat(f).toFixed(2);
        document.getElementById('windChillBrigham').innerHTML = chill;

        var wImg = document.getElementById('wImageBrigham');

        var myImage = document.createElement('img');


        myImage.src = 'http://openweathermap.org/img/w/' + data.weather[0].icon + '.png';
        wImg.appendChild(myImage);
        
        document.getElementById('imgDescriptionBrigham').innerHTML = "<p>" + data.weather[0].description + "</p>";

        document.getElementById('curDescBrigham').innerHTML = "<p>" + data.weather[0].description + "</p>";

};

brighamRequest.send();