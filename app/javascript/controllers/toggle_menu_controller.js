import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-menu"
export default class extends Controller {
    static targets = ['button', 'list', 'nav']
    connect() {
        // If the Scroll is on TOP, the nav wont have shadow
        window.addEventListener('scroll', () => {
            const scrollY = window.scrollY;
            const nav = document.querySelector("nav")
            const lis = document.querySelectorAll(".nav-link")
            const mobileMenu = document.querySelector(".mobile-menu")
            const hamburger = document.querySelector(".hamburguer")
            const svgPaths = hamburger.querySelectorAll("path");

            if (scrollY > 0) {
                svgPaths.forEach((path) => {
                    path.setAttribute("stroke", "#FFFFFF")
                });
                this.navTarget.classList.add('shadow-lg')
                nav.classList.remove('bg-white')
                nav.classList.add('bg-slate-500')
                mobileMenu.classList.remove("bg-white")
                mobileMenu.classList.add("bg-slate-500")
                lis.forEach(li => {
                    li.classList.remove("text-slate-900")
                    li.classList.add("text-white")
                })
            } else {
                svgPaths.forEach((path) => {
                    path.setAttribute("stroke", "#03220B")
                });
                this.navTarget.classList.remove('shadow-lg')
                mobileMenu.classList.remove("bg-slate-500")
                mobileMenu.classList.add("bg-white")
                nav.classList.add('bg-white')
                nav.classList.remove('bg-slate-500')
                lis.forEach(li => {
                    li.classList.remove("text-white")
                    li.classList.add("text-slate-900")
                })
            }
        })
        this.buttonTarget.addEventListener("click", this.toggle.bind(this))
    }

    toggle() {
        this.listTarget.classList.toggle("-translate-y-full")
        this.listTarget.classList.toggle("shadow-md")
    }
}
