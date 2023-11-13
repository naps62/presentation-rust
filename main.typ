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

// intro
#centered-slide[
  #figure(
    image("assets/dhh.png", width: 80%)
  )
]

// types in the past
#focus-slide[
  == Types in the past
]

#centered-slide[
  #side-by-side[
    ```c
    int main() {
      int x = 0;
      long int y = (long) x;

      println("%d", y);
    }
    ```
  ][
    #set align(left)

    1. slow to compile
    2. type inference wasn't a thing
    3. tooling
  ]
]

#centered-slide[

  ```
  unresolved external symbol "void __cdecl importStoredClients(class
  std::basic_fstream<char,struct std::char_traits<char> > const &,class 
  std::vector<class Client,class std::allocator<class Client> > &)" (?
  importStoredClients@@YAXABV?$basic_fstream@DU?$char_traits@D@std@@@std@@AAV?
  $vector@VClient@@V?$allocator@VClient@@@std@@@2@@Z) referenced in function 
  _main	DataTracker
  ```
]

#oneliner-slide[
  ```js
  1 + "2" == "12"
  ```

  #pdfpc.speaker-note("Scripting takes over")
]

#oneliner-slide(size: 1.7em)[
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
    let mut data = vec![1, 2]; // allocate an array
    let first = &data[0];      // create an immutable ref
    data.push(4);              // attempt to mutate
  }
  ```

  ```rust Vec::push()``` takes a mutable reference, which needs to be exclusive.
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
  = 3. Powerful compile-time checks
]

#slide[
  == Zero-cost abstractions

  #set align(horizon)
  The ability to use higher-level features without incurring additional runtime cost.

  The trade-off: compile-time complexity
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
    Aim for compile-time enforcements instead of runtime validations

    - Type-drive development;
    - Abuse `Option`, `Result`, and `enum`;
    - Typestate pattern.
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

#centered-slide[
  == Clippy is awesome

  #figure(
    image("assets/clippy.png", width: 70%)
  )
]

#centered-slide[
  == Rust-analyzer <=> TS Server
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
  == for JS/TS developers
  #v(2em)

  Miguel Palhas / \@naps62
]
