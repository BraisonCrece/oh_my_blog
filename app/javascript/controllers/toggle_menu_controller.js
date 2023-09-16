import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-menu"
export default class extends Controller {
    static targets = ['button', 'list', 'nav']
    connect() {
        // If the Scroll is on TOP, the nav wont have shadow
        window.addEventListener('scroll', () => {
            const scrollY = window.scrollY;
            if (scrollY > 0) {
                this.navTarget.classList.add('shadow-lg')
            } else {
                this.navTarget.classList.remove('shadow-lg')
            }
        })
        this.buttonTarget.addEventListener("click", this.toggle.bind(this))
    }

    toggle() {
        this.listTarget.classList.toggle("-translate-y-full")
        this.listTarget.classList.toggle("shadow-md")
    }
}
