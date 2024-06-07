
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
  

    // Apply animation to elements with the class 'scroll-animate'
    document.querySelectorAll('.scroll-appear').forEach((element) => {
        element.animate(
          {
            opacity: [0, 1], // Appear and disappear
        },
          {
            duration: 2,
            fill: 'both',
            timeline: scrollTimeline,
          }
        );
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
