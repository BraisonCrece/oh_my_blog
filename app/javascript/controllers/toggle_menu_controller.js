import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-menu"
export default class extends Controller {
    static targets = ['button', 'list']
    connect() {
        this.buttonTarget.addEventListener("click", this.toggle)
    }

    toggle() {
        this.listTarget.classList.toggle("-translate-y-full")
    }
}
