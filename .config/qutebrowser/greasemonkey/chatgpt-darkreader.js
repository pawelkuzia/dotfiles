// ==UserScript==
// @name     YouTube Dark Reader Background
// @include  *youtube.com*
// @grant    GM_addStyle
// @run-at   document-end
// ==/UserScript==

document.head.append(Object.assign(document.createElement("style"), {
  type: "text/css",
  textContent: `html[dark], [dark] {
  --yt-spec-base-background: #170b1a !important;
  --yt-frosted-glass-desktop: #170b1a !important;
    }
    .ytSearchboxComponentInputBoxDark {
    background-color: #170b1a !important;
    }
  ytd-app[fullscreen] #masthead-container {
    display: none !important;
}`
}))
