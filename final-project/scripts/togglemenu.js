function toggleMenu() {
    document.getElementById("primaryNav").classList.toggle('hide');
}

/* Get Current Date */
const currentDateSpan = document.querySelector("#currentDate");

const now = new Date();
currentDateSpan.textContent = new Intl.DateTimeFormat("en-GB", {
  dateStyle: "full",
}).format(now);




