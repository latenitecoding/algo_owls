-- ========================================================
-- Helpers
-- ========================================================
import Lean.Data.Json.Parser

def nextArray : IO (List Int) := do
    let stdin ← IO.getStdin
    let input ← stdin.getLine
    input.splitOn " "
        |> List.map String.trim
        |> List.map String.toInt!
        |> pure

def nextFloat : IO Float := do
    let stdin ← IO.getStdin
    let input ← stdin.getLine
    match Lean.Json.parse input with
    | .ok (.num x) => pure (x.toFloat)
    | _ => pure (0.0)

def nextInt : IO Int := do
    let stdin ← IO.getStdin
    let input ← stdin.getLine
    pure (String.toInt! input.trim)

def nextLine : IO String := do
    let stdin ← IO.getStdin
    let input ← stdin.getLine
    pure (input.trim)

def nextNat : IO Nat := do
    let stdin ← IO.getStdin
    let input ← stdin.getLine
    pure (String.toNat! input.trim)

def nextTuple : IO (List Int) := do
    let stdin ← IO.getStdin
    let input ← stdin.getLine
    input.splitOn " "
        |> List.take 2
        |> List.map String.trim
        |> List.map String.toInt!
        |> pure

-- ========================================================
-- Solution
-- ========================================================

def main : IO Unit := IO.println "Hello, World!"
