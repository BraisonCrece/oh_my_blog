import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-menu"
export default class extends Controller {
    static targets = ['button', 'list', 'nav']
    connect() {
        // If the Scroll is on TOP, the nav wont have shadow
        window.addEventListener('scroll', () => {
            const scrollY = window.scrollY;
            scrollY > 0 ? this.navTarget.classList.add('shadow-md') : this.navTarget.classList.remove('shadow-md')

        })
        this.buttonTarget.addEventListener("click", this.toggle.bind(this))
    }

    toggle() {
        this.listTarget.classList.toggle("-translate-y-full")
        this.listTarget.classList.toggle("shadow-md")
    }
}
