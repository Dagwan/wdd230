// all with data-src attribute
const imagesToLoad = document.querySelectorAll("img[data-src]");

// Optional paramters set intersectional Observer
const imgOptions = {
    threshold: 1,
    rootMargin: "0px 0px -200px 0px"
};

// Moves the path from data-src to src and removes data-src since it isn't needed
const loadImages = (image) => {
    image.setAttribute("src", image.getAttribute("data-src"));
    image.onload = () => {image.removeAttribute("data-src");};
};

// check to see if Intersection Observer is supported or not
if("IntersectionObserver" in window) {
    // Creates an images Observer
    const imgObserver = new IntersectionObserver((items, imgObserver) => {
        items.forEach((item) => {
            // If the item is intersecting, images then load 
            if(item.isIntersecting) {
                loadImages(item.target);

                // Once the image is loaded, observer stop.
                imgObserver.unobserve(item.target)
            }
        })
    }, imgOptions);

    // Loop through each img to check the status then load if necessary
    imagesToLoad.forEach((img) => {
        imgObserver.observe(img);
    });
}

else { // Load all the images if it is not supported.
    imagesToLoad.forEach((img) => {
        loadImages(img);
    });
}