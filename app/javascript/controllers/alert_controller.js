import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alert"
export default class extends Controller {
    static targets = ['container']
    connect() {
        document.addEventListener("DOMContentLoaded", () => {
            const alert = document.querySelector(".alert")
            if (alert) {
                this.showAlert(this.containerTarget)
            }
        })
    }

    showAlert(alert) {
        alert.classList.remove("-translate-y-[300px]")
        setTimeout(() => {
            alert.classList.add("-translate-y-[300px]");
            // document.querySelector(".alert").remove
        }, 2250);
    }
}
