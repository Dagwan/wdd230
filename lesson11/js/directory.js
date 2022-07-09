const requestURL = 'https://dagwan.github.io/wdd230/chamber/json/data.json';


fetch(requestURL)
  .then(function (response) {
    return response.json();
  })
  .then(function (jsonObject) {
    console.table(jsonObject);  // temporary checking for valid response and data parsing

    const directory = jsonObject['directory'];
    const groups = document.querySelector('.groups');

    directory.forEach(company => {
            // Create elements to add to the document  
            let  picture = document.createElement('img');        
            let  group = document.createElement('div');
            let  companyName = document.createElement('h2');
            let  address = document.createElement('p');
            let  phoneNumber = document.createElement('p');
            let  website = document.createElement('p');
            let  membership = document.createElement('p');
           

            // Build the image attributes by using the setAttribute method for the src, alt, and loading attribute values. (Fill in the blank with the appropriate variable).
            picture.setAttribute('src', "images/" + company.logo);
            picture.setAttribute('alt', `${company.companyName}`);
            picture.setAttribute('loading', 'lazy');

          
            // Change the textContent property of the h3 element to contain the companies full name
            companyName.textContent = `${company.companyName}`;
            address.textContent = `${company.address}`;
            phoneNumber.textContent = `${company.phoneNumber}`;
            website.textContent = `${company.website}`;
            membership.textContent = `${company.membership}`;
          
          
            // Add/append the section(card) with the h2 element
            group.appendChild(picture);
            group.appendChild(companyName);
            group.appendChild(address);
            group.appendChild(phoneNumber);
            group.appendChild(website);
            group.appendChild(membership);
            
          
            // Add/append the existing HTML div with the cards class with the section(card)
            //document.querySelector('div.cards').appendChild(card);
            groups.append(group);
          
    });
  });

  /* --------- buttons ---------- */

const gridbutton = document.querySelector("#grid");
const listbutton = document.querySelector("#list");
const display = document.querySelector(".groups");

// The following code could be written cleaner. How? We may have to simplfiy our HTMl and think about a default view.

gridbutton.addEventListener("click", () => {
	// example using arrow function
	display.classList.add("grid");
	display.classList.remove("list");
});

listbutton.addEventListener("click", showList); // example using defined function

function showList() {
	display.classList.add("list");
	display.classList.remove("grid");
}