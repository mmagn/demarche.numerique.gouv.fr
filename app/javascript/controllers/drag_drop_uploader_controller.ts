import { ApplicationController } from './application_controller';

export class DragDropUploaderController extends ApplicationController {
  get input(): HTMLInputElement | null {
    return this.element.querySelector<HTMLInputElement>('input[type="file"]');
  }

  openFilePicker(event: Event) {
    event.preventDefault();
    this.input?.click();
  }

  onDragOver(event: DragEvent) {
    event.preventDefault();
    this.element.classList.add('attachment-drop-zone--active');
  }

  onDragLeave(event: DragEvent) {
    // Only remove if leaving the drop zone entirely (not entering a child)
    if (!this.element.contains(event.relatedTarget as Node)) {
      this.element.classList.remove('attachment-drop-zone--active');
    }
  }

  onDrop(event: DragEvent) {
    event.preventDefault();
    this.element.classList.remove('attachment-drop-zone--active');

    const input = this.input;
    if (!input || !event.dataTransfer?.files.length) return;

    // Transfer all dropped files to the input
    const dt = new DataTransfer();
    for (const file of event.dataTransfer.files) {
      dt.items.add(file);
    }
    input.files = dt.files;

    // Dispatch a single change event (autosave will handle limit logic)
    input.dispatchEvent(new Event('change', { bubbles: true }));
  }
}
