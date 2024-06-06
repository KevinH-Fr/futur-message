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
    const options = {
      hour12: false, // Use 24-hour format
      timeZone: "UTC" // Set time zone explicitly
    };
    this.counterTarget.innerText = currentTime.toLocaleTimeString("en-US", options);
  }
}
