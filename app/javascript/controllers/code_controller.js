import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="code"
export default class extends Controller {
    static targets = ['textarea']
  connect() {
    this.textareaTarget.addEventListener('keydown', (event)=> {
      if (event.key === 'Tab') {
        event.preventDefault();
        var start = this.textareaTarget.selectionStart;
        var end = this.textareaTarget.selectionEnd;

        // Insertar 4 espacios en la posición del cursor
        this.textareaTarget.value = this.textareaTarget.value.substring(0, start) +
          "    " + this.textareaTarget.value.substring(end);

        // Mover el cursor al final de los 4 espacios
        this.textareaTarget.selectionStart = this.textareaTarget.selectionEnd = start + 4;
      }
    });
  }
}
