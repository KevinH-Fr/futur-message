import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["timer"];
 // static values = { target: String };

  connect() {
    this.updateTimer();
    this.interval = setInterval(() => this.updateTimer(), 1000);
    console.log(this.data.get("eventDate"));
  }

  disconnect() {
    clearInterval(this.interval);
  }

  updateTimer() {

    const dateStr = this.data.get("eventDate")
    const targetDate = new Date(dateStr);
    
    const currentDate = new Date();
   // console.log(currentDate);

        
    const timeRemaining = new Date(targetDate - currentDate);

    const days = Math.floor(timeRemaining / (1000 * 60 * 60 * 24));
    const hours = String(timeRemaining.getUTCHours()).padStart(2, "0");
    const minutes = String(timeRemaining.getUTCMinutes()).padStart(2, "0");
    const seconds = String(timeRemaining.getUTCSeconds()).padStart(2, "0");

    this.timerTarget.innerText = `Openable in ${days} days ${hours} : ${minutes} : ${seconds}`;

    
    
    if (timeRemaining <= 0) {
      this.timerTarget.innerText = "Finished";
      clearInterval(this.interval);
    }
  }



}