import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["counter"];

  connect() {
    console.log("timecounter connected");
    this.updateTime();
    this.interval = setInterval(() => this.updateTime(), 1000);
  }

  disconnect() {
    clearInterval(this.interval);
  }

  updateTime() {
    const currentTime = new Date();
    console.log("current time :" + currentTime);
    
    const hours = String(currentTime.getUTCHours()).padStart(2, "0");
    const minutes = String(currentTime.getUTCMinutes()).padStart(2, "0");
    const seconds = String(currentTime.getUTCSeconds()).padStart(2, "0");

    this.counterTarget.innerText = "test value";
  }
}
