# algo_owls
A repo of solutions to competitive programming problems for those who code late at nite!

Solutions are available in a variety of languages, but not all languages. The primary purpose of this repo is to make it convenient for competitive programmers to solve problems in the language of their choice. If your desired language is not listed, create your own branch and use the other branches as a template for the work you'll do.

There are a few common items that will be found in each of the branches listed below. First, each branch will come with a template file named `hello` or `Hello`, which serves as a good starting point for any solution. It is recommended that you copy this file when starting a problem. Second, each branch will come with an `algo_owls` bash script which will serve as a utility over the algo owls CLI implemented within `src`.

To learn more about the CLI, run the following command in your choice of terminal:
- `./algo_owls --help`

When using the algo owls CLI, target solutions are generally provided by name without a path or file extension. The only exception is when using the `init` command, which must include the path prefix to the target solution rooted at the `solutions` directory. For example, a solution for `FadingWind` can be created by running `algo_owls init icpc/nar2022/FadingWind`.

### Dev
For those that would like to contribute to the algo owls CLI, there is a `dev` branch where that work takes place.

In addition, the source files for the algo owls CLI are included in every branch as part of the `src` directory. The CLI is built using `bashly`, which you'll need to install. Do not modify the `algo_owls` script. Instead, modify files within the `src` directory and then rebuild the algo owls CLI using `bashly generate`.

### C
For the C branch: `git checkout cfault`

### C++
For the C++ branch: `git checkout cmypp`

### C#
For the C# branch: `git checkout dflat`

### Haskell
For the Haskell branch: `git checkout hadkell`

### Go
For the Go branch: `git checkout gokartz`

### Java
For the Java branch: `git checkout hotjava`

### Julia
For the Julia branch: `git checkout roberts`

### Lean
For the Lean branch: `git checkout leanonme`

### OCaml
For the OCaml branch: `git checkout humpday`

### Python
For the Python branch: `git checkout pyday`

### Rust
For the Rust branch: `git checkout rusteze`

### TypeScript
For the TypeScript branch: `git checkout scriptdaddy`

### Zig
For the Zig branch: `git checkout ziggywithit`
