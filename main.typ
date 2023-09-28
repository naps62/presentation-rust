#import "@preview/polylux:0.3.1": *

#import themes.metropolis: *
#set text(font: "Tahoma")
#set page(paper: "presentation-16-9")
#set text(size: 25pt)

#show: metropolis-theme.with(
  footer: [Simple slides],
)

// #title-slide[
//   = Rust
//   == the case for strong type systems
//   #v(2em)
//
//   Miguel Palhas / \@naps62
// ]
//
// #centered-slide[
//   == Types are a polarizing topic
// ]

// #centered-slide[
//   #figure(
//     image("assets/dhh.png", width: 80%)
//   )
// ]

#slide[
  TypeScript -> structural typing (what matters is which fields are present in an object), à la OCaml.

  Rust -> nominal typing (you need to use the exact same type), as other ML languages
]


#slide[
  == First slide

  #lorem(20)
]

#focus-slide[
  _Focus!_

  This is very important.
]

// #centered-slide[
//   = Let's start a new section!
// ]

#slide[
  == Dynamic slide
  Did you know that...

  #pause
  ... you can see the current section at the top?
]
