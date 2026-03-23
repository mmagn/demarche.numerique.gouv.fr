import { createLogger, defineConfig } from 'vite';
import ViteReact from '@vitejs/plugin-react';
import RubyPlugin from 'vite-plugin-ruby';
import FullReload from 'vite-plugin-full-reload';
import optimizeLocales from '@react-aria/optimize-locales-plugin';

const logger = createLogger();
const originalWarn = logger.warn.bind(logger);
logger.warn = (msg, options) => {
  if (msg.includes('Invalid media query')) return;
  originalWarn(msg, options);
};

const plugins = [
  RubyPlugin(),
  ViteReact(),
  FullReload(
    ['config/routes.rb', 'app/views/**/*', 'app/components/**/*.haml'],
    { delay: 200 }
  ),
  {
    ...optimizeLocales.vite({
      locales: ['en-US', 'fr-FR']
    }),
    enforce: 'pre' as const
  }
];

export default defineConfig({
  resolve: { alias: { '@utils': '/shared/utils.ts' } },
  build: { sourcemap: true, assetsInlineLimit: 0 },
  customLogger: logger,
  css: {
    transformer: 'lightningcss',
    lightningcss: { errorRecovery: true }
  },
  plugins
});
