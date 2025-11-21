import { Controller } from '@hotwired/stimulus'
import debounce from 'lodash.debounce'

import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'
import Subscript from '@tiptap/extension-subscript'
import Superscript from '@tiptap/extension-superscript'
import { TaskList, TaskItem } from '@tiptap/extension-list'
import TextAlign from '@tiptap/extension-text-align'

// Connects to data-controller="editor"
export default class extends Controller {
  static values = { url: String }
  static targets = ['content', 'linkInput']

  initialize() {
    this.debouncedAutoSave = debounce(this.autoSave.bind(this), 2500)

    this.editor = new Editor({
      element: this.contentTarget,
      editorProps: {
        attributes: {
          class:
            'prose prose-sm sm:prose-base lg:prose-lg xl:prose-2xl m-5 focus:outline-none'
        }
      },
      content: this.data.get('articleContent') || '',
      extensions: [
        StarterKit,
        TaskList,
        TaskItem.configure({
          nested: true
        }),
        Subscript,
        Superscript,
        TextAlign.configure({
          types: ['heading', 'paragraph']
        })
      ],
      editable: true,
      injectCSS: false,
      onUpdate: ({ editor }) => this.debouncedAutoSave(editor.getHTML())
    })
  }

  // Auto save
  async autoSave(htmlContent) {
    try {
      const response = await fetch(this.urlValue, {
        method: 'PATCH',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({ article: { content: htmlContent } })
      })

      if (response.ok) {
        console.log('Saved...')
      } else {
        const errorData = await response.json()
        console.log('Save failed: ', errorData)
      }
    } catch (error) {
      console.log('Error: ', error)
    }
  }

  // Undo/Redo
  undo() {
    this.editor.chain().focus().undo().run()
  }

  redo() {
    this.editor.chain().focus().redo().run()
  }

  // Headings
  toggleHeading_1() {
    this.editor.chain().focus().toggleHeading({ level: 1 }).run()
  }

  toggleHeading_2() {
    this.editor.chain().focus().toggleHeading({ level: 2 }).run()
  }

  toggleHeading_3() {
    this.editor.chain().focus().toggleHeading({ level: 3 }).run()
  }

  // Lists
  toggleBulletList() {
    this.editor.chain().focus().toggleBulletList().run()
  }

  toggleOrderedList() {
    this.editor.chain().focus().toggleOrderedList().run()
  }

  toggleTaskList() {
    this.editor.chain().focus().toggleTaskList().run()
  }

  toggleBlockquote() {
    this.editor.chain().focus().toggleBlockquote().run()
  }

  // Formatting
  toggleBold() {
    this.editor.chain().focus().toggleBold().run()
  }

  toggleItalic() {
    this.editor.chain().focus().toggleItalic().run()
  }

  toggleStrike() {
    this.editor.chain().focus().toggleStrike().run()
  }

  toggleCode() {
    this.editor.chain().focus().toggleCode().run()
  }

  toggleUnderline() {
    this.editor.chain().focus().toggleUnderline().run()
  }

  toggleLink() {
    this.editor
      .chain()
      .focus()
      .toggleLink({ href: this.linkInputTarget.value, target: '_blank' })
      .run()
  }

  toggleSuperscript() {
    console.log('SuperScript')
    this.editor.chain().focus().toggleSuperscript().run()
  }

  toggleSubscript() {
    this.editor.chain().focus().toggleSubscript().run()
  }

  toggleTextAlign({ params: { direction } }) {
    console.log('Direction: ', direction)
    this.editor.chain().focus().toggleTextAlign(direction).run()
  }
}
