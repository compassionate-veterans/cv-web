# Compassionate Veterans

Static single-page site for **Compassionate Veterans**, a 501(c)(3) nonprofit
promoting peace from within for military veterans.

No framework, no build step — plain HTML, CSS, and a little vanilla JavaScript.
Deploys to Cloudflare Pages (or any static host).

## File map

```
.
├── index.html                # the whole page
├── favicon.ico
├── src/
│   ├── lib/                  # ES modules
│   │   ├── main.js           # entry — inits fade + email, sets footer year
│   │   ├── fade.js           # IntersectionObserver reveal (respects reduced-motion)
│   │   └── email.js          # runtime email obfuscation
│   └── styles/               # CSS, @imported by main.css
│       ├── main.css tokens.css base.css layout.css
│       └── typography.css components.css animations.css
├── img/
│   ├── web/                  # optimized WebPs served to the browser
│   ├── originals/            # source images (committed brand assets)
│   ├── social/og-cover.jpg   # OpenGraph share image
│   └── logo-mark.svg         # peace-helmet mark (also the SVG favicon)
├── icons/                    # PNG favicons + site.webmanifest
└── scripts/optimize-images.sh
```

## Run locally

```bash
python3 -m http.server 8000   # then open http://localhost:8000
```

A real HTTP server is required — opening `index.html` via `file://` will not load
the ES modules or the root-relative (`/src/...`) paths.

## Deploy (Cloudflare Pages)

Fully static, no build step. Connect the repo in Cloudflare Pages with **Build
command: (none)** and **Output directory: `/`**, or upload directly with
`npx wrangler pages deploy .`. It also runs unchanged on Netlify, GitHub Pages,
S3, etc.

## Update images

Drop a new original into `img/originals/` (keep the same base name), then:

```bash
./scripts/optimize-images.sh            # rebuild all
./scripts/optimize-images.sh community  # rebuild one
```

Requires `cwebp` (`brew install webp`). The logo lockup and OG image are built
separately via ImageMagick from `img/originals/logo-lockup-trans.png`.

## Notes

- The palette is derived from the logo and lives in `src/styles/tokens.css`.
- The Donate buttons link to Givebutter (`givebutter.com/compassionateveterans`).
- The contact email is assembled at runtime in `src/lib/email.js` — the address
  is intentionally **not** present as plaintext in `index.html`.
