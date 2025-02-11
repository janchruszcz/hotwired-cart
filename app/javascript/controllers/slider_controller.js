// app/javascript/controllers/slider_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value", "input", "form"]
  static values = {
    delay: { type: Number, default: 300 }  // 300ms debounce delay
  }

  connect() {
    this.updateValue(this.inputTarget.value)
    this.timeout = null
  }

  update(event) {
    this.updateValue(event.target.value)
    
    // Clear existing timeout
    if (this.timeout) {
      clearTimeout(this.timeout)
    }

    // Set new timeout for form submission
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, this.delayValue)
  }

  updateValue(value) {
    this.valueTarget.textContent = `$${value}`
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }
}