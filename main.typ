#import "@preview/polylux:0.3.1": *

#import themes.simple: *
#set text(font: "Tahoma")
#set page(paper: "presentation-16-9")
#set text(size: 25pt)

#show: simple-theme.with(
)

#title-slide[
  = Rust
  === for JS/TS developers
  #v(2em)

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
    4. ...
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

#centered-slide[
  ```javascript 1 + "2" == 3```

  #pdfpc.speaker-note("Scripting takes over")
]

#slide[
  == Duck typing

  ```javascript
  class Duck {
    noise = () => console.log('quack')
  }

  function makeNoise(duck: Duck) {
    duck.noise();
  }

  let cat = { noise: () => console.log('meow') }
  makeNoise(cat)
  ```
]

#centered-slide[
  == `Undefined is not a function`
]

#focus-slide[
  == Types now
]

// structural vs nominal typing
#centered-slide[
  == Structural vs Nominal typing
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
    
    // works (more on this later)
    let y: Bar = x.into();
  }
  ```
]

#focus-slide[
  == What makes Rust good?
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
      let list: Vec<u32> = vec![1, 2, 3]
        .iter()
        .map(|v: u32| v + 1)
        .collect::<Vec<u32>>()
      ```

      integer types are easily inferred
      (u8, 16, u32, ...)
    ]

    #only(3)[
      ```rust
      let list: Vec<u32> = vec![1, 2, 3]
        .iter()
        .map(|v| v + 1)
        .collect::<Vec<u32>>()
      ```

      closure arguments are inferred
      99% of the time
    ]

    #only(4)[
      ```rust
      let list: Vec<u32> = vec![1, 2, 3]
        .iter()
        .map(|v| v + 1)
        .collect::<Vec<_>>()
      ```

      elements in collections are inferred
      99% of the time
    ]

    #only(5)[

      ```rust
      let list: Vec<u32> = vec![1, 2, 3]
        .iter()
        .map(|v| v + 1)
        .collect()
      ```

      actually, the entire `collect` type and `list` type are redundant
    ]

    #only(6)[

      ```rust
      let list: Vec<_> = vec![1, 2, 3]
        .iter()
        .map(|v| v + 1)
        .collect()
      ```

      and the `Vec` element itself is inferred from numbers:
    ]
  ]
]

#slide[
  #set align(horizon)

  Type inference actually eliminates most of the noise.
  Only exceptions: funtion headers, and ambiguous declarations

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
  == 3. Zero cost abstractions
]

#slide[
  #set align(horizon)
  The ability to use higher-level features without incurring additional runtime cost.

  The trade-off: compiler complexity, and compilation times.
]

#slide[
  == Zero Sized Types
  TODO: do I want to keep this topic?

  ```rust
  type Never = ();
  struct Void;
  enum Unit { Unit };
  ```
  }
]

#slide[
  == Why?

  1. To distinguish types that are structural equal, but conceptually different

  ```rust

  ```

]

#focus-slide[
  == 4. Tooling
]

#slide[
  == TODO

  1. dependency-management done righ
  2. out-of-the-box tooling docs, tests, benchmarks
  3. cross-platform support
  4. WASM
]

#focus-slide[
  == What's "built with Rust"?
]

#centered-slide[
  == Typst
  #figure(image("assets/typst.png", height: 75%))
]

#centered-slide[
  #figure(image("assets/tauri.png", height: 75%))
]

#centered-slide[
  == `just`
  #figure(image("assets/just.png", height: 75%))
]

#centered-slide[
  == `delta`
  #figure(image("assets/delta.png", height: 75%))
]

#title-slide[
  = Rust
  == for JS/TS developers
  #v(2em)

  Miguel Palhas / \@naps62
]
