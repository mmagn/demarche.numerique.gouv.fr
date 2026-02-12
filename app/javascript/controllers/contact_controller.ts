import { ApplicationController } from './application_controller';
import { hide, show } from '@utils';

declare global {
  interface Window {
    $crisp?: Array<[string, ...unknown[]]>;
  }
}

export class ContactController extends ApplicationController {
  static targets = ['inputRadio', 'content'];

  declare readonly inputRadioTargets: HTMLInputElement[];
  declare readonly contentTargets: HTMLElement[];

  connect() {
    this.inputRadioTargets.forEach((inputRadio) => {
      this.on(inputRadio, 'change', this.onChange.bind(this));
      this.on(inputRadio, 'keydown', this.onChange.bind(this));
    });

    this.openCrispOnDesktop();
  }

  private onChange(event: Event) {
    const target = event.target as HTMLInputElement;
    const content = this.getContentForTarget(target);

    this.contentTargets.forEach((content) => {
      hide(content);
      content.setAttribute('aria-hidden', 'true');
    });

    if (target.checked && content) {
      show(content);
      content.setAttribute('aria-hidden', 'false');
    }
  }

  private getLabelForTarget(target: HTMLInputElement) {
    const labelSelector = `label[for="${target.id}"]`;
    return document.querySelector(labelSelector);
  }

  private getContentForTarget(target: HTMLInputElement) {
    const label = this.getLabelForTarget(target);
    if (!label) {
      return null;
    }
    const contentSelector = label.getAttribute('aria-controls');

    if (contentSelector) {
      return document.getElementById(contentSelector);
    }
  }

  private openCrispOnDesktop() {
    if (!window.matchMedia('(min-width: 768px)').matches) return;

    requestAnimationFrame(() => {
      window.$crisp?.push(['do', 'chat:open']);
    });
  }
}
