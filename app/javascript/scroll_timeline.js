document.addEventListener("DOMContentLoaded", function() {
  var observerOptions = {
    root: null,
    rootMargin: "0px",
    threshold: 0.1 // Adjust as needed (0.1 means 10% of the element is visible)
  };

  var observer = new IntersectionObserver(function(entries, observer) {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.remove("scroll-disappear");
        entry.target.classList.add("scroll-appear");
      } else {
        entry.target.classList.remove("scroll-appear");
        entry.target.classList.add("scroll-disappear");
      }
    });
  }, observerOptions);

  // Select the elements to observe
  var elements = document.querySelectorAll('.scroll-appear-element');
  elements.forEach(element => {
    observer.observe(element);
    // Trigger a check for elements already in view
    if (element.getBoundingClientRect().top < window.innerHeight) {
      element.classList.remove("scroll-disappear");
      element.classList.add("scroll-appear");
    }
  });
});
