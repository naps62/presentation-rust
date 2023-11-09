#import "@preview/polylux:0.3.1": *
#import themes.simple: *

#let dark = rgb("#212121")
#let darkbg = rgb("#6b1d09")
#let light = white

#let focus-slide(body) = {
  themes.simple.focus-slide(background: darkbg, foreground: light, body)
}

#let horizon-slide(body) = {
  logic.polylux-slide(align(horizon, body))
}

#let oneliner-slide(size: 3em, body) = {
  set text(size: size)
  logic.polylux-slide(align(center + horizon, body))
}
