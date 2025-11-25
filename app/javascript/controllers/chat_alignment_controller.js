import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="chat-alignment"
export default class extends Controller {
  static values = { currentUserId: Number }
  static targets = ['taskComment']

  initialize() {
    // optional: align everything already on the page
    this.alignExisting()
  }

  alignExisting() {
    this.taskCommentTargets.forEach((element) => {
      this.applyAlignment(element)
    })
  }

  taskCommentTargetConnected(element) {
    this.applyAlignment(element)
  }

  applyAlignment(element) {
    const authorId = element.dataset.authorId
    const current = this.currentUserIdValue

    element.classList.toggle('chat-end', authorId == current)
    element.classList.toggle('chat-start', authorId != current)
  }
}
