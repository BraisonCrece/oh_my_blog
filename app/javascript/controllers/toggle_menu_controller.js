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
        const distance = `translate-y-[${navRect.bottom}px]`

        if (list.classList.contains("-translate-y-full")) {
            list.classList.remove("-translate-y-full")
            list.classList.add(distance)
        }else{
            list.classList.remove(distance)
            list.classList.add("-translate-y-full")
        }
    }
}
