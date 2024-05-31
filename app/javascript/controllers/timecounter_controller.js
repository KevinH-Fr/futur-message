import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["timer"];

  connect() {
    this.updateTimer();
    this.interval = setInterval(() => this.updateTimer(), 1000);
  }

  disconnect() {
    clearInterval(this.interval);
  }

  updateTimer() {
    const currentDate = new Date();
    
    const hours = String(currentDate.getHours()).padStart(2, "0");
    const minutes = String(currentDate.getMinutes()).padStart(2, "0");
    const seconds = String(currentDate.getSeconds()).padStart(2, "0");

    this.timerTarget.textContent = `${hours} : ${minutes} : ${seconds}`;
  }
}
