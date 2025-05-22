import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list"]

  connect() {
    console.log("Bars controller connected")
  }

  addBar(event) {
    if (event.detail.success) {
      this.element.insertAdjacentHTML("beforeend", event.detail.html)
    }
  }

  removeBar(event) {
    if (event.detail.success) {
      const barElement = event.target.closest("[data-bar-id]")
      if (barElement) {
        barElement.remove()
      }
    }
  }

  handleSubmit(event) {
    if (event.detail.success) {
      const form = event.target
      form.reset()
    }
  }
} 