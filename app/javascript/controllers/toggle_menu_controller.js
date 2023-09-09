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
        console.log(navRect.bottom)
        const distance = `translate-x-[${navRect.bottom}px]`

        list.classList.toggle("-translate-y-full")
        // if (list.classList.contains("-translate-y-full")) {
        //     list.classList.remove("-translate-y-full")
        //     list.classList.add(distance)
        // }else{
        //     list.classList.remove(distance)
        //     list.classList.add("-translate-y-full")
        // }
    }
}
