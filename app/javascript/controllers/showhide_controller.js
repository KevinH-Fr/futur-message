import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showhide"
export default class extends Controller {
  static targets = ["input", "output"]
  static values = { showIf: Boolean }

  connect() {
    this.toggle()
  }

  toggle() {
    this.outputTargets.forEach(output => {
      if (this.inputTarget.checked !== this.showIfValue) {
        output.hidden = true
      } else {
        output.hidden = false
      }
    })
  }
}
