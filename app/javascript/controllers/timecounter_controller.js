import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  //static targets = ["timer"];

  static get targets() {
    return [ "timer" ]
  }

  connect() {
    console.log("Timer controller connected");
    this.updateTimer();
    this.interval = setInterval(() => this.updateTimer(), 1000);
  }

  disconnect() {
    console.log("Timer controller disconnected");
    clearInterval(this.interval);
  }

  updateTimer() {
    try {
      const currentDate = new Date();
      
      const hours = String(currentDate.getHours()).padStart(2, "0");
      const minutes = String(currentDate.getMinutes()).padStart(2, "0");
      const seconds = String(currentDate.getSeconds()).padStart(2, "0");

      this.timerTarget.textContent = `${hours} : ${minutes} : ${seconds}`;
    } catch (error) {
      console.error("Error updating timer:", error);
    }
  }
}
