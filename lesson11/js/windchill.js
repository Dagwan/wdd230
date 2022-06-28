const currentTemp = document.querySelector("#currtemp");
const weatherIcon = document.querySelector("#weathericon");
const captionDesc = document.querySelector("figcaption");
const windspeed = document.querySelector("#windspeed");
const windchill = document.querySelector("#windchill");

const url =
  "//api.openweathermap.org/data/2.5/weather?q=Lehi&units=imperial&appid=fa6b055b74f3706d26458f658758da4b";
fetch(url)
  .then((response) => response.json())
  .then((data) => {

  
    currentTemp.innerHTML = `${data.main.temp.toFixed(0)}`;
    windspeed.innerHTML = `${data.wind.speed}`;

    
    if ((data.main.temp <= 50) && (data.wind.speed > 3)) {
    const chill = 35.74 + (0.6215 * currentTemp) - (35.75 * Math.pow(windspeed, .16)) + (0.4275 * currentTemp * Math.pow(windspeed, .16));
    windchill.innerHTML = chill.toFixed(1);
    } else {
    windchill.innerHTML = "N/A";
    }

    const iconsrc = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`;
    const desc = data.weather[0].description;

    weatherIcon.setAttribute("src", iconsrc);
    weatherIcon.setAttribute("alt", desc);
    captionDesc.innerHTML = desc;


  });





