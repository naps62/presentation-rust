#import "./theme.typ": *

#set page(paper: "presentation-16-9")
#set text(size: 25pt)

#show: simple-theme.with(
  foreground: dark,
  background: light
)

#title-slide[
  = Rust
  === for JS/TS developers

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
  1 + "2" == 3
  ```

  #pdfpc.speaker-note("Scripting takes over")
]

#oneliner-slide(size: 1.7em)[
  == `Undefined is not a function`
]

#focus-slide[
  == 2. Types of Typings
]

#slide[
  == Structural Typing (Typescript, OCaml, ...)
  #set text(size: 22pt)

  ```typescript
  type Foo = { x: number, y: string };
  type Bar = { x: number };

  let x: Foo = { x: 1, y: "hello" };

  // works
  let y: Bar = x;

  console.log(y)
  // => { x: 1, y: "hello" }
  ```
]

#slide[
  == Nominal Typing (Rust, C/C++, ...)
  #set text(size: 22pt)

  ```rust
  struct Foo { x: i32, y: String };
  struct Bar { x: i32 };

  fn main() {
    let x: Foo = Foo { x: 1, y: "hello".to_string() };

    // this would not compile
    // let y: Bar = x;
    
    // works (explicit conversion needs to be defined)
    let y: Bar = x.into();
  }
  ```
]

#focus-slide[
  == What makes Rust good?
]

#slide[
  = "If it compiles, it works"

  #v(2em)
  #pause
  not to be taken literally

  it's how strongly typed programming *feels*
]

#slide[
  = "Making illegal states unrepresentable"
]

#focus-slide[
  == 1. Types, but comfortably
]

#slide[
  #side-by-side[
    ```rust
    let list: Vec<u32> =
      vec![1u32, 2u32, 3u32]
        .iter()
        .map(|v: u32| v + 1)
        .collect::<Vec<u32>>()
    ```
  ][
    #only(2)[
      ```rust
      let list: Vec<u32> =
        vec![1, 2, 3]
          .iter()
          .map(|v: u32| v + 1)
          .collect::<Vec<u32>>()
      ```

      integer types are easily inferred
      (u8, 16, u32, ...)
    ]

    #only(3)[
      ```rust
      let list: Vec<u32> =
        vec![1, 2, 3]
          .iter()
          .map(|v| v + 1)
          .collect::<Vec<u32>>()
      ```

      closure arguments are inferred
      99% of the time
    ]

    #only(4)[
      ```rust
      let list: Vec<u32> =
        vec![1, 2, 3]
          .iter()
          .map(|v| v + 1)
          .collect::<Vec<_>>()
      ```

      elements in collections are inferred
      99% of the time
    ]

    #only(5)[

      ```rust
      let list: Vec<u32> =
        vec![1, 2, 3]
          .iter()
          .map(|v| v + 1)
          .collect()
      ```

      actually, the entire `collect` type and `list` type are redundant
    ]

    #only(6)[

      ```rust
      let list: Vec<_> =
        vec![1, 2, 3]
          .iter()
          .map(|v| v + 1)
          .collect()
      ```

      and the `Vec` element itself is inferred from numbers
    ]
  ]
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
  == 2. Borrow checker
]

#slide[
  == Ownership and References

  #side-by-side[
    ```typescript
    type Foo = { x: number };

    function add(foo: Foo) {
      foo.x += 1;
    }
    ```
  ][
    #only(1)[
      ```rust
      struct Foo { x: u32 }

      fn add(foo: Foo) {
        foo.x += 1;
      }
      ```
      #set text(size: 20pt)
      error[E0594]: cannot assign to `foo.x`, as `foo` is not declared as mutable
    ]
    #only(2)[
      ```rust
      struct Foo { x: u32 }

      fn add(foo: &Foo) {
        foo.x += 1;
      }
      ```
      #set text(size: 20pt)
      error[E0594]: cannot assign to `foo.x`, which is behind a `&` reference
    ]
    #only(3)[
      ```rust
      struct Foo { x: &mut u32 }

      fn add(foo: mut Foo) {
        foo.x += 1;
      }
      ```
    ]
  ]
]

#focus-slide[
  == 3. Algebraic types
]

#horizon-slide[
  == Product types
  when you have one thing AND another thing

  ```rust
  struct Rectangle {
    width: u32,
    height: u32
  }
  ```
]

#horizon-slide[
  == Sum types
  when you have one thing OR another thing

  #side-by-side[
    ```rust
    enum Option<T> {
      None,
      Some(T)
    }
    ```
  ][
    ```rust
    enum Result<T, E> {
      Ok(T),
      Err(E)
    }
    ```
  ]
]

#focus-slide[
  == 3. Zero cost abstractions
]

#slide[
  #set align(horizon)
  The ability to use higher-level features without incurring additional runtime cost.

  The trade-off: compile-time complexity
]

#focus-slide[
  == 4. Tooling
]

#centered-slide[
  TODO rust-analyzer screenshot
]

#centered-slide[
  TODO cargo
]

#centered-slide[
  TODO build for WASM
]

#focus-slide[
  == What's "built with Rust"?
]

#centered-slide[
  == `just`
  #figure(image("assets/just.png", height: 75%))
]

#centered-slide[
  == `delta`
  #figure(image("assets/delta.png", height: 75%))
]

#centered-slide[
  == Typst
  #figure(image("assets/typst.png", height: 75%))
]

#centered-slide[
  #figure(image("assets/tauri.png", height: 75%))
]

#focus-slide[
  == Why NOT Rust?
]

#centered-slide[
  = Refactoring is a slog 
  == (Fact Checking)
]

#centered-slide[
  #figure(image("assets/rust-refactoring.png"))
]

#title-slide[
  = Rust
  == for JS/TS developers
  #v(2em)

  Miguel Palhas / \@naps62
]
