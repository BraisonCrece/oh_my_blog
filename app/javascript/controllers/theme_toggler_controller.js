import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme-toggler"
export default class extends Controller {
    static targets = ["switcher"]
    connect() {
        const theme = localStorage.theme || "light"
        document.documentElement.classList.add(theme)
        this.switcherTarget.addEventListener("click", this.toggle)
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

        if (document.documentElement.classList.contains("dark")) {
            localStorage.theme = "dark"
            marker.forEach(element => {
                element.classList.add("text-white")
            })
        } else {
            marker.forEach(element => {
                element.classList.remove("text-white")
            })
            localStorage.theme = "light"
        }
    }
}
