import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="picture-preview"
export default class extends Controller {
    static targets = ["input", "preview"]

    connect() {
        this.inputTarget.addEventListener("change", this.showPreview.bind(this))
    }

    showPreview() {
        const file = this.inputTarget.files[0]
        const reader = new FileReader()

        reader.onload = (event) => {
            this.previewTarget.setAttribute("src", event.target.result)
        }

        reader.readAsDataURL(file)
        this.submitForm()
    }

    submitForm() {
        this.inputTarget.closest("form").submit()
    }
}
