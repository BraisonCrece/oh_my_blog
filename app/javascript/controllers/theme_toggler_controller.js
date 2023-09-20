import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme-toggler"
export default class extends Controller {
    static targets = ["switcher", "sun", "moon"]
    connect() {
        console.log(this.sunTarget)
        this.switcherTarget.addEventListener("click", this.toggle.bind(this))
        if (document.documentElement.classList.contains("dark")) {
            const marker = document.querySelectorAll(".cdx-marker")
            marker.forEach(element => {
                element.classList.add("text-white")
            })
        }
    }

    toggle() {
        const marker = document.querySelectorAll(".cdx-marker")
        document.documentElement.classList.toggle("dark")
        const transition = document.startViewTransition(() => {
            if (document.documentElement.classList.contains("dark")) {
                localStorage.theme = "dark"
                this.moonTarget.classList.add("hidden")
                this.sunTarget.classList.remove("hidden")
                marker.forEach(element => {
                    element.classList.add("text-white")
                })
            } else {
                localStorage.theme = "light"
                this.sunTarget.classList.add("hidden")
                this.moonTarget.classList.remove("hidden")
                marker.forEach(element => {
                    element.classList.remove("text-white")
                })
            }
          });
    }
}
