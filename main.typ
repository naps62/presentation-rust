#import "./theme.typ": *

#set page(paper: "presentation-16-9")
#set text(size: 25pt)

#show: simple-theme.with(
  foreground: dark,
  background: light
)

#title-slide[
  = Rust
  === A brief intro

  #figure(
    image("assets/ferris.png", width: 10%)
  )

  Miguel Palhas (\@naps62) / Subvisual
]

#slide[
  #set align(center)
  #side-by-side[
    == Tauri
    #figure(
      image("assets/tauri.png", width: 100%)
    )
  ][
    == Typst
    #figure(
      image("assets/typst.png", width: 100%)
    )
  ]
]

#slide[
  #set align(center)
  #side-by-side[
    == Delta
    #figure(
      image("assets/delta.png", width: 100%)
    )
  ][
    == Just
    #figure(
      image("assets/just.png", width: 100%)
    )
  ]
]

#centered-slide[
  #figure(
    image("assets/dhh.png", width: 80%)
  )
]

#slide[
  == We went from this

  ```
  unresolved external symbol "void __cdecl importStoredClients(class
  std::basic_fstream<char,struct std::char_traits<char> > const &,class 
  std::vector<class Client,class std::allocator<class Client> > &)" (?
  importStoredClients@@YAXABV?$basic_fstream@DU?$char_traits@D@std@@@std@@AAV?
  $vector@VClient@@V?$allocator@VClient@@@std@@@2@@Z)
  ```
]

#slide[
  == ... to this
  == ```js 1 + "2" == "12" ```
  == `Undefined is not a function`
]

#focus-slide[
  = Types of Types
]

#slide[
  == Structural Typing (Typescript, OCaml, ...)

  #set text(size: 22pt)

  #image("assets/ts.png", width: 20pt)
  ```typescript
  type Foo = { x: number, y: string };
  type Bar = { x: number };

  let x: Foo = { x: 1, y: "hello" };
  ```
]

#slide[
  == Nominal Typing (Rust, C/C++, ...)
  #set text(size: 22pt)

  #image("assets/ferris.png", width: 30pt)
  ```rust
  struct Foo { x: i32, y: String };
  struct Bar { x: i32 };

  fn main() {
    let x: Foo = Foo { x: 1, y: "hello".to_string() };

    // this would not compile
    // let y: Bar = x;
  }
  ```
]

#focus-slide[
  = What makes Rust good?
]

#focus-slide[
  = 1. Type inference
]

#slide[
  == This is the same code

  #set align(horizon)
  ```rust
  let list: Vec<u32> =
    vec![1u32, 2u32, 3u32].iter().map(|v: &u32| v + 1).collect::<Vec<u32>>()
  ```

  #v(2em)

  ```rust
  let list =
    vec![1, 2, 3].iter().map(|v| v + 1).collect()
  ```
]

#slide[
  #set align(horizon)

  Type inference eliminates most noise.

  Exceptions: function headers; ambiguity.

  ```rust
  fn increment_and_dedup(v: Vec<u32>) -> HashSet<u32> {
    v.iter().map(|v| v + 1).collect()
  }
  ```
]

#focus-slide[
  = 2. Memory Safety
  === even in multi-threaded code
]

#slide[
  = This fails to compile

  #set align(horizon)
  ```rust
  fn main() {
    let x = 1;

    let r1 = &x;
    let r2 = &mut x;

    println!("{} {}", r1, r2);
  }
  ```
]

#slide[
  = Multi-threading type-safety

  #set align(horizon)
  #table(
    columns: (1fr, 3fr),
    stroke: none,
    [```rust trait Send```],  [safe to *send* to another thread],
    [```rust trait Sync```],  [safe to *share* between threads],
  )
]

#focus-slide[
  = 3. Compiler
]

#slide[
  == Zero-cost abstractions

  #set align(horizon)
  The ability to use high-level features without runtime cost.

  Trade-off: compile-time complexity
]

#slide[
  == "If it compiles, it works"

  #v(2em)
  not to be taken literally

  it's how strongly typed programming *feels*
]

#slide[
  == Making illegal states unrepresentable

  #only(1)[
    #v(2em)
    Aim for compile-time safety, not runtime validations

    - Type-drive development;
    - Abuse ```rust Option```, ```rust Result```, and ```rust enum```;
    - Typestate pattern. (https://cliffle.com/blog/rust-typestate/)
  ]

  #only(2)[
    ```rust
    enum AccountState {
      Active { email: Email, active_at: DateTime },
      Inactive { email: Email },
      Banned { reason: String },
    }

    /// Newtype pattern
    /// email regex can be enforced on constructor
    /// runtime size is the same as String
    type Email(String)
    ```
  ]
]


#focus-slide[
  = 4. Tooling
]

#centered-slide[
  ```sh
    cargo build
    cargo run --package serve
    cargo +nightly clippy
    cargo fmt
    cargo test
    cargo build --target wasm32-unknown-unknown
    cargo audit
    bacon
  ```
]

#focus-slide[
  = Tips to get started
]

#slide[
  == Don't get too Rust'y right away

  - if you're writing ```rust Foo<'a>```, you're gonna have a bad time;
  - Abuse ```rust clone()``` instead of fighting the borrow checker;
  - get v1 working, only then optimize.
  - tooling will teach you along the way
]

#focus-slide[
  = Why NOT Rust?
  #v(1em)

  #set text(size: 24pt)
  bonus slides if I got here before the 20m mark
]

#slide[
  == Compilation times?

  - Incremental compilation is great(ish)
  - Not quite instant-reload, but rather close
  - Release builds are more painful
  - You should `cargo check` instead of `cargo build`
]

#slide[
  == Refactoring is a slog?
  #figure(image("assets/rust-refactoring.png", height: 75%))
]


#title-slide[
  = Rust
  === A brief intro

  #figure(
    image("assets/ferris.png", width: 10%)
  )

  Miguel Palhas (\@naps62) / Subvisual
]
