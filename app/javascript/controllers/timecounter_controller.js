// app/javascript/controllers/time_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["currentTime"]

  connect() {
    this.updateTime()
    this.timer = setInterval(() => {
      this.updateTime()
    }, 1000)
  }

  disconnect() {
    clearInterval(this.timer)
  }

  updateTime() {
    const currentTime = new Date()
    this.currentTimeTarget.innerText = currentTime.toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      second: '2-digit',
      hour12: true
    })
  }
}
