# algo_owls
A repo of solutions to competitive programming problems for those who code late at nite!

Solutions are available in a variety of languages, but not all languages. The primary purpose of this repo is to make it convenient for competitive programmers to solve problems in the language of their choice. If your desired language is not listed, create your own pair of branches and use the other languages as a template for the work you'll do.

There are a few common items that will be found in each of the branches listed below. First, each branch will come with a template file named `hello` or `Hello`, which serves as a good starting point for any solution. It is recommended that you copy this file when starting a problem. Second, each branch will come with an `algo_owls` bash script which will serve as a utility over the algo owls CLI implemented within `src`.

The `algo_owls` bash script has the following interface:

`algo_owls [-* | build | run <SOLUTION> | [test quest] <SOLUTION> | init <path-to-Solution> | clean ]`
- `-*` Forwards all arguments to the algo owls CLI defined in `src` (see `src/README.md`)
- `build` Compiles the project into `target` (if applicable)
- `run` Compiles the project into `target` (if applicable) and executes the target solution
- `test` Compiles the project into `target`, executes the target solution, and runs `tests` against the target solution
- `init` Creates a new solution from the `hello` template using the provided file path (not including `src/solutions/`)
- `clean` Removes all builds from `target`

All target solutions should be provided as a filename without an extension. The only exception is when using the `init` command, which also includes the path prefix to the target solution rooted at the `solutions` directory. For example, a solution for `FadingWind` can be created by running `algo_owls init icpc/nar2022/FadingWind`.

### C
For the C branch: `git checkout cfault`

For the C solutions branch: `git checkout cfault-solutions`

### C++
For the C++ branch: `git checkout cmypp`

For the C++ solutions branch: `git checkout cmypp-solutions`

### Go
For the Go branch: `git checkout gokartz`

For the Go solutions branch: `git checkout gokartz-solutions`

### Java
For the Java branch: `git checkout hotjava`

For the Java solutions branch: `git checkout hotjava-solutions`

### Python
For the Python branch: `git checkout pyday`

For the Python solutions branch: `git checkout pyday-solutions`

### Rust
For the Rust branch: `git checkout rusteze`

For the Rust solutions branch: `git checkout rusteze-solutions`

### TypeScript
For the TypeScript branch: `git checkout scriptdaddy`

For the TypeScript solutions branch: `git checkout scriptdaddy-solutions`

### Zig
For the Zig branch: `git checkout ziggywithit`

For the Zig solutions branch: `git checkout ziggywithit-solutions`
