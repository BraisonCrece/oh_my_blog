import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-menu"
export default class extends Controller {
    static targets = ['button']
    connect() {
        this.buttonTarget.addEventListener("click", this.toggle)
    }

    toggle() {
        const list = document.querySelector("#menu-list")
        const nav = document.querySelector("nav")
        const navRect = nav.getBoundingClientRect();
        const distance = `translate-x-[${navRect.bottom}px]`

        list.classList.toggle("-translate-y-full")
    }
}
