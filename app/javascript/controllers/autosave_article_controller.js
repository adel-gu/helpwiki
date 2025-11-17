import { Controller } from '@hotwired/stimulus'
import debounce from 'lodash.debounce'

// Connects to data-controller="autosave-article"
export default class extends Controller {
  static targets = ['status']
  static values = {
    url: String
  }

  connect() {
    this.debouncedSend = debounce(() => this.sendRequest(), 2500)
  }

  async sendRequest() {
    const formData = new FormData(this.element)

    try {
      this.statusTarget.textContent = 'Saving...'

      const response = await fetch(this.urlValue, {
        method: 'PATCH',
        headers: {
          'X-CSRF-Token': document.querySelector("meta[name='csrf-token']")
            .content,
          Accept: 'application/json'
        },
        body: formData
      })

      if (response.ok) {
        this.statusTarget.textContent = '✓ Saved'
        this.statusTarget.classList.add('text-green-600')
      } else {
        // AC [3]: Failure
        const errorData = await response.json()
        console.error('Save failed:', errorData)
        this.statusTarget.textContent = 'Error saving.'
        this.statusTarget.classList.add('text-red-600')
      }
    } catch (error) {
      console.error('An unexpected error occurred:', error)
      this.statusTarget.textContent = 'Network error.'
      this.statusTarget.classList.add('text-red-600')
    }
  }

  save() {
    this.debouncedSend()
  }
}
