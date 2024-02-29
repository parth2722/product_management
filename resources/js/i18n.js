// i18n.js

import { createI18n } from 'vue-i18n';

const messages = {
  en: {
    // other English translations
  },
  es: {
    // other Spanish translations
  },
};

const i18n = createI18n({
  locale: 'en',
  messages,
});

export default i18n;
