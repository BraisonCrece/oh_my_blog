import { Controller } from "@hotwired/stimulus"
import EditorJS from "../editorjs.mjs"
import { Tools } from '../config/config'

// Connects to data-controller="editor"
export default class extends Controller {
    static targets = ["articleContent", "hiddenContent"]
    connect() {
        console.log("connected")
        const initialContent = this.getInitialContent()
        this.contentEditor = new EditorJS({
            holder: this.articleContentTarget,
            data: initialContent,
            placeholder: 'Let`s write an awesome blog! 🗒',
            tools: Tools
        })
        this.element.addEventListener("submit", this.saveEditorData.bind(this))
    }

    async saveEditorData(event) {
        event.preventDefault()
        const outputData = await this.contentEditor.save()
        const articleForm = this.element
        const hiddenInput = this.hiddenContentTarget
        hiddenInput.value = JSON.stringify(outputData)
        articleForm.submit()
    }

    getInitialContent() {
        const hiddenContentField = this.hiddenContentTarget
        if (hiddenContentField?.value) {
            return JSON.parse(hiddenContentField.value)
        }
    }
}
