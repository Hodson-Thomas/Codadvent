CountPositions ← {
  dirs ← "NSWE"
  deltas ← ⟨0‿¯1, 0‿1, 1‿0, ¯1‿0⟩
  moves ← deltas ⊏˜ dirs ⊐ 𝕩
  positions ← ⟨0‿0⟩ ∾ +` moves
  ≠ ⍷ positions
}
