
document.addEventListener('DOMContentLoaded', () => {
  // Create a Scroll Timeline
  const scrollTimeline = new ScrollTimeline({
    source: document.scrollingElement,
    orientation: 'block',
    scrollOffsets: [CSS.percent(0), CSS.percent(100)],
  });

  // Apply animation to elements with the class 'scroll-animate'
  document.querySelectorAll('.scroll-animate').forEach((element) => {
    element.animate(
      {
        transform: ['translateY(100px)', 'translateY(0)'],
        opacity: [0, 1], // Appear and disappear
    },
      {
        duration: 2,
        fill: 'both',
        timeline: scrollTimeline,
      }
    );
  });
  

  // Select all elements with the class 'scroll-appear'
  const elements = document.querySelectorAll('.scroll-appear');

  // Create an IntersectionObserver instance
  const observer = new IntersectionObserver((entries, observer) => {
      entries.forEach(entry => {
          if (entry.isIntersecting) {
              // Add the 'in-view' class and remove 'out-of-view' class when the element is in view
              entry.target.classList.add('in-view');
              entry.target.classList.remove('out-of-view');
          } else {
              // Add the 'out-of-view' class and remove 'in-view' class when the element is out of view
              entry.target.classList.add('out-of-view');
              entry.target.classList.remove('in-view');
          }
      });
  }, { threshold: 0.1 }); // Adjust the threshold as needed

  // Observe each element
  elements.forEach(element => {
      observer.observe(element);
  });


    // Apply animation to elements with the class 'scroll-slide'
    document.querySelectorAll('.scroll-slide-right').forEach((element) => {
        element.animate(
            {
            transform: ['translateX(-100%)', 'translateX(0%)'], // Slide from left to right
            },
            {
            duration: 1, // The duration will be determined by the scroll
            fill: 'both',
            timeline: scrollTimeline,
            }
        );
    });



});
