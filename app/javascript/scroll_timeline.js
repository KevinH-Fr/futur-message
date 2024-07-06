document.addEventListener("DOMContentLoaded", function() {
  const appears = document.querySelectorAll('.appear');
  const options = {
     root: null,
     rootMargin: '0px',
     threshold: 0.1
  };

  const observer = new IntersectionObserver((entries, observer) => {
     entries.forEach(entry => {
        if (entry.isIntersecting) {
           entry.target.classList.add('visible');
        } else {
           entry.target.classList.remove('visible');
        }
     });
  }, options);

  appears.forEach(appear => {
     observer.observe(appear);
  });
});
