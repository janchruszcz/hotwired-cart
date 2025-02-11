import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["value"]

  update(event) {
    console.log("update")
    this.valueTarget.textContent = `$${event.target.value}`
    this.element.requestSubmit()
  }
}