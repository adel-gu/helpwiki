import { Controller } from '@hotwired/stimulus'
import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'
import Subscript from '@tiptap/extension-subscript'
import Superscript from '@tiptap/extension-superscript'

// Connects to data-controller="editor"
export default class extends Controller {
  static targets = ['content', 'linkInput']
  initialize() {
    this.editor = new Editor({
      element: this.contentTarget,
      editorProps: {
        attributes: {
          class:
            'prose prose-sm sm:prose-base lg:prose-lg xl:prose-2xl m-5 focus:outline-none'
        }
      },
      // content: this.data.get('initialContent') || '',
      content: `
    <h2>
      Hi there,
    </h2>
    <p>
      this is a basic <em>basic</em> example of <strong>Tiptap</strong>. Sure, there are all kind of basic text styles you’d probably expect from a text editor. But wait until you see the lists:
    </p>
    <ul>
      <li>
        That’s a bullet list with one …
      </li>
      <li>
        … or two list items.
      </li>
    </ul>
    <p>
      Isn’t that great? And all of that is editable. But wait, there’s more. Let’s try a code block:
    </p>
<pre><code class="language-css">body {
  display: none;
}</code></pre>
    <p>
      I know, I know, this is impressive. It’s only the tip of the iceberg though. Give it a try and click a little bit around. Don’t forget to check the other examples too.
    </p>
    <blockquote>
      Wow, that’s amazing. Good work, boy! 👏
      <br />
      — Mom
    </blockquote>
  `,
      extensions: [StarterKit, Subscript, Superscript],
      editable: true,
      injectCSS: false
    })
  }

  // Undo/Redo
  undo() {
    this.editor.chain().focus().undo().run()
  }

  redo() {
    this.editor.chain().focus().redo().run()
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
}
