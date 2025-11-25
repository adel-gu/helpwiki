import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="comment-form"
export default class extends Controller {
  reset(event) {
    // Optional: Only clear on success
    if (!event.detail.success) return

    this.element.reset()
  }
}
