
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, eventDate: String }

  connect() {
    this.checkDelay()
    this.interval = setInterval(() => this.checkDelay(), 1000)
   }
 
   disconnect() {
     clearInterval(this.interval)
   }

  checkDelay() {
   // console.log("call check delay");

    const dateStr = this.eventDateValue
    const targetDate = new Date(dateStr)
    const currentDate = new Date()
    const timeRemaining = new Date(targetDate - currentDate)

  //  console.log("timeRemaining: " + timeRemaining);

    if (timeRemaining <= 0) {
      clearInterval(this.interval)
      this.callTurboStreamAction()
    }
  }

  callTurboStreamAction() {
    console.log("call turbo stream action");

    fetch(this.urlValue, {
      method: 'POST',
      headers: {
        'Accept': 'text/vnd.turbo-stream.html',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      }
    })
    .then(response => response.text())
    .then(html => {
      const template = document.createElement('template')
      template.innerHTML = html.trim()
      document.body.appendChild(template.content.firstChild)
    })
  }
}
