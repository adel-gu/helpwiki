import { Controller } from '@hotwired/stimulus'
import debounce from 'lodash.debounce'

// Connects to data-controller="autosave-article"
export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    this.debouncedSend = debounce(() => this.sendRequest(), 2500)
  }

  async sendRequest() {
    const formData = new FormData(this.element)

    try {
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
        // AC [3]: Success
        console.log('Send success')
      } else {
        // AC [3]: Failure
        const errorData = await response.json()
        console.error('Save failed:', errorData)
      }
    } catch (error) {
      console.error('An unexpected error occurred:', error)
    }
  }

  save() {
    this.debouncedSend()
  }
}
