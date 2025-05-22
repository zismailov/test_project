import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["item", "name", "editForm", "barsList"]

  connect() {
    this.element.classList.add("foo-item")
  }

  hover() {
    this.itemTarget.classList.add("hover")
  }

  unhover() {
    this.itemTarget.classList.remove("hover")
  }

  confirmDelete(event) {
    if (!confirm("Вы уверены, что хотите удалить этот элемент?")) {
      event.preventDefault()
    }
  }

  handleSubmit(event) {
    if (event.detail.success) {
      this.editFormTarget.classList.add("hidden")
      this.nameTarget.textContent = event.detail.formData.get("foo[name]")
    }
  }

  handleBarCreated(event) {
    if (this.hasBarsListTarget) {
      this.barsListTarget.insertAdjacentHTML("beforeend", event.detail.html)
    }
  }
} 