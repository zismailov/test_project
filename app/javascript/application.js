// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

// Entry point for the build script in your package.json

// Настройка Turbo
document.addEventListener("turbo:load", () => {
  console.log("Turbo loaded")
})

document.addEventListener("turbo:before-stream-render", (event) => {
  console.log("Before stream render", event)
})

document.addEventListener("turbo:before-fetch-request", (event) => {
  console.log("Before fetch request", event)
})

document.addEventListener("turbo:before-fetch-response", (event) => {
  console.log("Before fetch response", event)
})
