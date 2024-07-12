document.addEventListener("DOMContentLoaded", function() {
    const phoneNumberInput = document.querySelector(".phone-number-input");
  
    if (phoneNumberInput) {
      phoneNumberInput.addEventListener("input", function(e) {
        let value = e.target.value.replace(/\D/g, ''); // Remove all non-numeric characters
        let formattedValue = '';
  
        if (value.length > 0) {
          formattedValue = value.slice(0, 1) + ' ';
        }
        if (value.length > 1) {
          formattedValue += value.slice(1, 3) + ' ';
        }
        if (value.length > 3) {
          formattedValue += value.slice(3, 5) + ' ';
        }
        if (value.length > 5) {
          formattedValue += value.slice(5, 7) + ' ';
        }
        if (value.length > 7) {
          formattedValue += value.slice(7, 9) + ' ';
        }
        if (value.length > 9) {
          formattedValue += value.slice(9, 11);
        }
  
        e.target.value = formattedValue.trim();
      });
    }
  });
  
  