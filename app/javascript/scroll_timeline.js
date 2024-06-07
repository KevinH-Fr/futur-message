
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
  
});
