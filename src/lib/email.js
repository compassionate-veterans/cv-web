// Runtime email obfuscation.
// The address is never written as plaintext in index.html — it is assembled
// here from fragments only when the visitor clicks, defeating naive scrapers.
export function initEmail() {
  const parts = ['contact', 'compassionateveterans', 'org'];
  const addr = () => parts[0] + '@' + parts[1] + '.' + parts[2];

  document.querySelectorAll('[data-email]').forEach((el) => {
    el.addEventListener('click', (e) => {
      e.preventDefault();
      const a = addr();
      // Reveal the address in place, then hand off to the mail client.
      el.textContent = a;
      el.setAttribute('aria-label', 'Email ' + a);
      window.location.href = 'mailto:' + a;
    });
  });
}
