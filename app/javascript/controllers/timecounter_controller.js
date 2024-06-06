// app/javascript/controllers/time_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return [ "counter" ]
  }

  connect() {
    console.log("timecounter connected");
    this.updateTime()
    this.interval = setInterval(() => this.updateTime(), 1000)
  }

  disconnect() {
    clearInterval(this.interval)
  }

  updateTime() {
    const currentTime = new Date()
    console.log("current time :" + currentTime);
    this.counterTarget.innerText = currentTime.toLocaleTimeString()
  }
}
