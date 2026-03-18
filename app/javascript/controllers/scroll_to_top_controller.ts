import { ApplicationController } from './application_controller';

export class ScrollToTopController extends ApplicationController {
  static targets = ['scrollToTop'];
  static values = { threshold: Number };

  declare readonly scrollToTopTarget: HTMLDivElement;
  declare readonly hasScrollToTopTarget: boolean;
  declare readonly thresholdValue: number;
  declare readonly hasThresholdValue: boolean;

  connect(): void {
    this.toggleScrollToTopVisibility();
    this.on(window, 'scroll', () => this.toggleScrollToTopVisibility());
  }

  scrollToTop(): void {
    window.scrollTo({ top: 0, behavior: 'smooth' });
  }

  private toggleScrollToTopVisibility(): void {
    if (!this.hasScrollToTopTarget) {
      return;
    }

    const threshold = this.hasThresholdValue ? this.thresholdValue : 120;
    this.scrollToTopTarget.classList.toggle(
      'hidden',
      window.scrollY <= threshold
    );
  }
}
