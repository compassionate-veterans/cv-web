import { initFade }  from './fade.js';
import { initEmail } from './email.js';

const prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

initFade(prefersReduced);
initEmail();

// Footer year.
const yearEl = document.getElementById('year');
if (yearEl) yearEl.textContent = new Date().getFullYear();
