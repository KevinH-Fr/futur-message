// app/javascript/controllers/time_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "counter" ]

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
    this.counterTarget.innerText = currentTime.toLocaleTimeString()
  }
}
