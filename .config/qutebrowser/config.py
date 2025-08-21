import json
import os

# Ścieżka do pliku pywal16
colors_file = os.path.expanduser("~/.cache/wal/colors.json")

with open(colors_file) as f:
    wal = json.load(f)


config.load_autoconfig(False)

# === completion ===
c.colors.completion.category.bg = wal["special"]["background"]
c.colors.completion.category.border.bottom = wal["colors"]["color0"]
c.colors.completion.category.border.top = wal["colors"]["color4"]
c.colors.completion.category.fg = wal["colors"]["color2"]

c.colors.completion.even.bg = wal["colors"]["color0"]
c.colors.completion.odd.bg = wal["colors"]["color0"]

c.colors.completion.fg = wal["colors"]["color7"]
c.colors.completion.item.selected.bg = wal["colors"]["color10"]
c.colors.completion.item.selected.border.bottom = wal["colors"]["color8"]
c.colors.completion.item.selected.border.top = wal["colors"]["color4"]
c.colors.completion.item.selected.fg = wal["special"]["foreground"]
c.colors.completion.match.fg = wal["special"]["foreground"]
c.colors.completion.item.selected.match.fg = wal["colors"]["color14"]
c.colors.completion.scrollbar.bg = wal["colors"]["color0"]
c.colors.completion.scrollbar.fg = wal["colors"]["color8"]

# === downloads ===
c.colors.downloads.bar.bg = wal["special"]["background"]
c.colors.downloads.error.bg = wal["special"]["background"]
c.colors.downloads.start.bg = wal["special"]["background"]
c.colors.downloads.stop.bg = wal["special"]["background"]

c.colors.downloads.error.fg = wal["colors"]["color1"]
c.colors.downloads.start.fg = wal["colors"]["color4"]
c.colors.downloads.stop.fg = wal["colors"]["color2"]
c.colors.downloads.system.fg = "none"
c.colors.downloads.system.bg = "none"

# === hints ===
c.colors.hints.bg = wal["colors"]["color3"]
c.colors.hints.fg = wal["colors"]["color0"]
c.hints.border = f"1px solid {wal['colors']['color0']}"
c.colors.hints.match.fg = wal["colors"]["color7"]

# === keyhints ===
c.colors.keyhint.bg = wal["colors"]["color0"]
c.colors.keyhint.fg = wal["special"]["foreground"]
c.colors.keyhint.suffix.fg = wal["colors"]["color7"]

# === messages ===
c.colors.messages.error.bg = wal["colors"]["color8"]
c.colors.messages.info.bg = wal["colors"]["color8"]
c.colors.messages.warning.bg = wal["colors"]["color8"]

c.colors.messages.error.border = wal["colors"]["color0"]
c.colors.messages.info.border = wal["colors"]["color0"]
c.colors.messages.warning.border = wal["colors"]["color0"]

c.colors.messages.error.fg = wal["colors"]["color1"]
c.colors.messages.info.fg = wal["special"]["foreground"]
c.colors.messages.warning.fg = wal["colors"]["color3"]

# === prompts ===
c.colors.prompts.bg = wal["colors"]["color0"]
c.colors.prompts.border = f"1px solid {wal['colors']['color8']}"
c.colors.prompts.fg = wal["special"]["foreground"]
c.colors.prompts.selected.bg = wal["colors"]["color8"]
c.colors.prompts.selected.fg = wal["colors"]["color1"]

# === statusbar ===
c.colors.statusbar.normal.bg = wal["special"]["background"]
c.colors.statusbar.insert.bg = wal["colors"]["color0"]
c.colors.statusbar.command.bg = wal["special"]["background"]
c.colors.statusbar.caret.bg = wal["special"]["background"]
c.colors.statusbar.caret.selection.bg = wal["special"]["background"]

c.colors.statusbar.progress.bg = wal["special"]["background"]
c.colors.statusbar.passthrough.bg = wal["special"]["background"]

c.colors.statusbar.normal.fg = wal["special"]["foreground"]
c.colors.statusbar.insert.fg = wal["colors"]["color1"]
c.colors.statusbar.command.fg = wal["special"]["foreground"]
c.colors.statusbar.passthrough.fg = wal["colors"]["color3"]
c.colors.statusbar.caret.fg = wal["colors"]["color3"]
c.colors.statusbar.caret.selection.fg = wal["colors"]["color3"]

c.colors.statusbar.url.error.fg = wal["colors"]["color1"]
c.colors.statusbar.url.fg = wal["special"]["foreground"]
c.colors.statusbar.url.hover.fg = wal["colors"]["color14"]
c.colors.statusbar.url.success.http.fg = wal["colors"]["color6"]
c.colors.statusbar.url.success.https.fg = wal["colors"]["color2"]
c.colors.statusbar.url.warn.fg = wal["colors"]["color11"]

c.colors.statusbar.private.bg = wal["colors"]["color0"]
c.colors.statusbar.private.fg = wal["colors"]["color7"]
c.colors.statusbar.command.private.bg = wal["special"]["background"]
c.colors.statusbar.command.private.fg = wal["colors"]["color7"]

# === tabs ===
c.colors.tabs.bar.bg = wal["colors"]["color0"]
c.colors.tabs.even.bg = wal["colors"]["color0"]
c.colors.tabs.odd.bg = wal["colors"]["color0"]

c.colors.tabs.even.fg = wal["colors"]["color7"]
c.colors.tabs.odd.fg = wal["colors"]["color7"]

c.colors.tabs.indicator.error = wal["colors"]["color1"]
c.colors.tabs.indicator.system = "none"

c.colors.tabs.selected.even.bg = wal["colors"]["color10"]
c.colors.tabs.selected.odd.bg = wal["colors"]["color10"]
c.colors.tabs.selected.even.fg = wal["special"]["foreground"]
c.colors.tabs.selected.odd.fg = wal["special"]["foreground"]

c.colors.tabs.pinned.even.bg = wal["colors"]["color0"]
c.colors.tabs.pinned.odd.bg = wal["colors"]["color0"]

c.colors.tabs.pinned.selected.even.bg = wal["colors"]["color10"]
c.colors.tabs.pinned.selected.odd.bg = wal["colors"]["color10"]

c.colors.tabs.pinned.even.fg = wal["colors"]["color15"]
c.colors.tabs.pinned.odd.fg = wal["colors"]["color15"]
c.colors.tabs.pinned.selected.even.fg = wal["colors"]["color15"]
c.colors.tabs.pinned.selected.odd.fg = wal["colors"]["color15"]
# === context menus ===
c.colors.contextmenu.menu.bg = wal["special"]["background"]
c.colors.contextmenu.menu.fg = wal["special"]["foreground"]

c.colors.contextmenu.disabled.bg = wal["colors"]["color0"]
c.colors.contextmenu.disabled.fg = wal["colors"]["color8"]

c.colors.contextmenu.selected.bg = wal["colors"]["color8"]
c.colors.contextmenu.selected.fg = wal["colors"]["color7"]

c.tabs.position = 'left'
c.tabs.padding = dict(bottom=8, top=8, left=8, right=5)
c.tabs.select_on_remove = 'last-used'
c.tabs.title.format = '  {audio}{current_title}'
c.tabs.title.format_pinned = '  ⚪ {audio}{current_title}'
c.tabs.mode_on_change = 'restore'
c.tabs.indicator.width = 2  # in pixels
c.tabs.indicator.padding = dict(bottom=2, top=2, left=0, right=2)
c.tabs.width = 250
c.tabs.close_mouse_button = 'middle'
c.tabs.close_mouse_button_on_bar = 'new-tab'
c.window.transparent = False
c.fonts.default_size = "11pt"
c.fonts.default_family = "sans-serif"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "never"
c.tabs.indicator.width = 0
c.zoom.default = "120%"
c.statusbar.padding = dict(bottom=6, top=5, left=7, right=7)
c.auto_save.session = True
c.session.lazy_restore = True
c.content.autoplay = False
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'y': 'https://www.youtube.com/results?search_query={}',
    'a': 'https://allegro.pl/listing?string={}'
}
c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://malware-filter.gitlab.io/malware-filter/urlhaus-filter-ag-online.txt',
    'https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&showintro=0&mimetype=plaintext'
]


# Binds
config.bind('<j>', 'scroll-px 0 150')
config.bind('<k>', 'scroll-px 0 -150')
config.bind('<Ctrl-Shift-Y>', 'spawn --userscript qute-bitwarden')
config.bind('<Ctrl-e>', 'config-cycle tabs.show switching always')
config.bind('<Ctrl-=>', 'config-cycle zoom.default 200 120')
config.bind('<Ctrl-m>', 'spawn mpv --force-window=immediate --cache --cache-secs=20 --demuxer-max-bytes=500000KiB {url}')
config.bind('Y', 'hint links spawn mpv --force-window=immediate --cache --cache-secs=20 --demuxer-max-bytes=500000KiB {hint-url}')
config.bind('<Ctrl-l>', 'set-cmd-text -s :open {url}')
config.bind('<Ctrl-Shift-D>', 'config-cycle -u {url:domain} colors.webpage.darkmode.enabled false true;; reload')

c.aliases['mpv'] = 'spawn mpv --force-window=immediate --cache --cache-secs=20 --demuxer-max-bytes=500000KiB {url}'

config.bind('<Shift-x>', 'spawn --userscript ~/.config/qutebrowser/userscripts/open-in-nitter')


from qutebrowser.api import interceptor
from PyQt6.QtCore import QUrl

def add_autoplay_param(request):
    url = request.request_url

    # youtube.com/watch?v=...
    if url.host().endswith("youtube.com") and url.path() == "/watch":
        if "autoplay=" not in url.query():
            new_query = url.query() + ("&" if url.query() else "") + "autoplay=0"
            url.setQuery(new_query)
            request.redirect(url)
            print(f"[YT Interceptor] Dodano autoplay=0 → {url.toString()}")
        return

    # skrócone youtu.be/VIDEO_ID
    if url.host() == "youtu.be":
        video_id = url.path().lstrip("/")
        if video_id:
            new_url = QUrl(f"https://www.youtube.com/watch?v={video_id}&autoplay=0")
            request.redirect(new_url)
            print(f"[YT Interceptor] Przekierowano skrócony link → {new_url.toString()}")
        return

interceptor.register(add_autoplay_param)
