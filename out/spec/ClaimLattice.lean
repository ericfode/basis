import Std

namespace ClaimLattice

inductive BadIdeaClass where
  | impossible
  | useless
  | moreComplexThanNothing
  | missesProblem
  | underspecified
  | unfalsifiable
  deriving Repr, DecidableEq

inductive Severity where
  | low
  | medium
  | high
  deriving Repr, DecidableEq, Ord

structure ImageStats where
  nodeCount : Nat
  edgeCount : Nat
  findingCount : Nat
  highSeverityFindingCount : Nat
  hasProblem : Bool
  hasGoals : Bool
  hasValidation : Bool
  deriving Repr

def generatedStats : ImageStats := {
  nodeCount := 130,
  edgeCount := 145,
  findingCount := 2,
  highSeverityFindingCount := 0,
  hasProblem := true,
  hasGoals := true,
  hasValidation := true
}

def coreSurfacePresent (stats : ImageStats) : Prop :=
  stats.hasProblem = true ∧ stats.hasGoals = true ∧ stats.hasValidation = true

def rejectsHighImpossibleFindings (stats : ImageStats) : Prop :=
  stats.highSeverityFindingCount = 0

def readyForPrototype (stats : ImageStats) : Prop :=
  coreSurfacePresent stats ∧ rejectsHighImpossibleFindings stats

theorem missing_core_surface_blocks_ready
    (stats : ImageStats)
    (h : stats.hasProblem = false ∨ stats.hasGoals = false ∨ stats.hasValidation = false) :
    ¬ readyForPrototype stats := by
  intro ready
  rcases ready with ⟨core, _⟩
  rcases core with ⟨problem, goals, validation⟩
  rcases h with hProblem | hGoals | hValidation
  · simp [hProblem] at problem
  · simp [hGoals] at goals
  · simp [hValidation] at validation

-- Generated from /Users/ericfode/Documents/New project 4/spec.md
-- detected: misses_problem
-- detected: underspecified

end ClaimLattice
