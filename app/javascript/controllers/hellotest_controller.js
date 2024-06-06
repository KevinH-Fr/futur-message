import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hellotest"
export default class extends Controller {
  connect() {
    this.element.innerHTML += "<p>Hello, Stimulus!</p>";
  }
}
