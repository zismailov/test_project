// Контроллер для управления элементом Bar
// Наследуется от базового контроллера списка
// Добавляет специфичную функциональность для Bar
import ListItemController from "./list_item_controller"

export default class extends ListItemController {
  static targets = ["name", "description", "actions", "editForm"]

  connect() {
    super.connect()
    this.element.classList.add('bar-item')
  }

  handleTurboStream(event) {
    if (!event.detail.success) return

    const response = event.detail.fetchResponse.response
    
    if (response.status === 204) {
      this.element.remove()
    } else {
      this.toggleVisibility(this.editFormTarget, false)
      this.toggleVisibility(this.actionsTarget, true)
    }
  }

  // Показывает форму редактирования
  showEditForm(event) {
    event.preventDefault()
    this.toggleVisibility(this.actionsTarget, false)
    this.toggleVisibility(this.editFormTarget, true)
  }

  // Скрывает форму редактирования
  hideEditForm() {
    this.toggleVisibility(this.editFormTarget, false)
    this.toggleVisibility(this.actionsTarget, true)
  }

  // Обрабатывает удаление элемента
  delete(event) {
    event.preventDefault()
    const form = event.target.closest("form")
    if (form) {
      form.requestSubmit()
    }
  }

  private

  // Настраивает обработчики событий
  setupEventListeners() {
    this.element.addEventListener("edit:complete", this.hideEditForm.bind(this))
    this.element.addEventListener("edit:cancel", this.hideEditForm.bind(this))
  }

  // Переключает видимость элемента
  toggleVisibility(element, show) {
    element.classList.toggle("hidden", !show)
  }
} 