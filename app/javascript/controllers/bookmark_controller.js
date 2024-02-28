import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bookmark"
export default class extends Controller {
  static targets = ["form"];

  toggle () {
    this.formTarget.classList.remove("d-none")
  }
}
