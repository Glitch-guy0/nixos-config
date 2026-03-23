# NixOS Configuration Constitution

## Core Principles

### I. Modularity First
Every configuration element must be designed for reuse. Modules in `modules/` must be self-contained and independently testable. Logic belongs in the most specific layer: modules for reusable components, profiles for compositions, hosts for machine-specific configurations.

### II. Flake-Based Architecture
All configuration flows through `flake.nix` as the single entry point. Direct imperative access to NixOS configuration is prohibited. Every change must be traceable through the flake inputs, outputs, and relevant module chains.

### III. Declarative by Default
All configuration MUST be declarative. Prefer Nix module options over shell scripts. Use pure evaluation patterns. Immutable system state is the goal; impermanence is handled through explicit configuration.

### IV. Composability
Profiles combine modules into logical groupings. Hosts compose profiles and modules. No direct logic duplication across hosts or profiles. When logic appears in multiple places, extract it into a module.

### V. Documentation Synchronization
Code and documentation must remain synchronized. Any Nix configuration change requires corresponding documentation updates. Documentation drift is treated as a critical defect.

### VI. Separation of Concerns
Three distinct layers govern change management:
- **Architecture/Correctness**: nix-expert agent handles architecture placement, risk identification, and Nix idioms
- **Documentation/Knowledge**: nix-docs-writer agent handles clarity, structure, and knowledge transfer
- **Validation**: Both agents must sign off before changes are valid

## Nix Configuration Governance

This section defines the mandatory workflow for all changes involving Nix-related code.

### Applicable Scope

This governance policy MUST be triggered when changes involve any of the following:

- `flake.nix`
- `modules/` directory
- `profiles/` directory
- `hosts/` directory
- `pkgs/` directory
- `overlays/` directory
- `lib/` directory
- Any Nix expression file (`.nix` extension)

### Two-Agent Workflow

All Nix-related changes MUST follow a two-agent workflow using rule files located at:

```
./agents/rules/nix-expert.md
./agents/rules/nix-docs-writer.md
```

#### Agent 1: Planning and Validation (nix-expert)

The nix-expert agent MUST be engaged first for all Nix changes. This agent follows a structured Thinking Process to ensure architectural soundness:

- Context Identification: Determine affected layer and scope
- Architectural Fit: Validate placement in modules/profiles/hosts
- Dependency & Impact Analysis: Assess ripple effects
- Best Practices Check: Verify declarative, reproducible, idiomatic Nix
- Documentation Cross-Check: Align with NixOS manual and nixpkgs conventions
- Plan Before Action: Generate clear, minimal change strategy
- Validation Output: Always produce Plan, Validation, Changes, and Notes

This agent is responsible for:

**Planning Phase**
- Produce a structured plan identifying affected layer (module/profile/host/package)
- Validate architecture placement decisions
- Identify risks, anti-patterns, or architectural violations
- Suggest minimal, idiomatic Nix solutions

**Validation Phase**
- Verify flake.nix structure integrity
- Validate module imports and composition
- Confirm overlay and package definition correctness
- Ensure nixpkgs compatibility and best practices compliance

**Output Requirements**
- Plan with step-by-step changes and target directories
- Validation report noting risks or issues found
- Minimal diff-style code snippets
- Best practice notes and documentation references

#### Agent 2: Documentation (nix-docs-writer)

After nix-expert validation is complete and changes are finalized, the nix-docs-writer agent MUST update documentation. This agent follows a structured Thinking Process to ensure clarity and completeness:

- Context Understanding: Identify what changed and where
- Audience Identification: Write for beginner users, contributors, and maintainers
- Purpose Extraction: Explain why the component exists
- System Placement: Explain flow from flake.nix through profiles/modules/hosts
- Simplification: Convert Nix code to human explanation, not raw dumps
- Consistency Check: Align with existing docs, avoid contradictions
- Output Structure: Always produce Title, Overview, Details, Usage/Examples, and Notes

This agent is responsible for:

- Updating or creating files in the `/docs` directory
- Reflecting new behavior accurately with the current system state
- Explaining purpose, usage, and structure for all documented components
- Maintaining consistency with the architecture documentation

**Documentation Structure**
```
/docs
├── overview.md
├── architecture.md
├── flake.md
├── modules/
├── profiles/
├── hosts/
├── workflows.md
└── troubleshooting.md
```

### Validation Requirements

A Nix-related change is NOT valid unless:

1. It includes nix-expert validation output documenting:
   - Architecture placement decision
   - Risk assessment
   - Compliance with Nix best practices

2. Corresponding documentation is updated via nix-docs-writer:
   - Changes are reflected in relevant docs
   - Purpose and usage are explained
   - Structure and relationships are documented

### Separation of Responsibilities

**nix-expert is responsible for:**
- Correctness of Nix expressions
- Architecture soundness
- Nix idioms and best practices
- Minimal, composable configurations

**nix-docs-writer is responsible for:**
- Documentation clarity and accuracy
- Documentation structure and organization
- Knowledge transfer and usability
- Beginner-friendly explanations

### Constraints

1. **Direct edits to Nix configuration are not allowed** without nix-expert validation
2. **Documentation drift is not allowed** - docs must reflect current system state
3. **Agents must strictly follow their respective rule definitions** in `agents/rules/`
4. **No silent breaking changes** - all breaking changes must be documented and validated

### Uncertainty Handling

If uncertainty exists regarding Nix changes, the nix-expert agent MUST:

1. Explicitly mark areas as "needs verification"
2. Suggest relevant documentation sources for further review
3. Provide alternative approaches with trade-off analysis

## Development Workflow

### Pre-Change Checklist

1. Follow core principles (modularity, declarative, composability)
2. Add inline documentation standard headers to every `.nix` file
3. Validate changes with `scripts/check.sh` before committing
4. Update `.sops.yaml` and re-key secrets if necessary
5. Record changes in `CHANGELOG.md`

### Style Standards

- Format code via `nixfmt-rfc-style`
- Keep modules single-purpose
- Maximum 200 lines per module
- Clear naming conventions for options and definitions

## Governance

### Amendment Process

This constitution supersedes all other development practices. Amendments require:

1. Proposed changes documented with rationale
2. Impact assessment on existing configurations
3. Migration plan for any breaking changes
4. Validation that all principles remain coherent

### Compliance

- All pull requests MUST verify constitutional compliance
- Complexity must be justified when deviating from principles
- Use agent rule files as runtime development guidance

### Version Information

**Version**: 1.1.0 | **Ratified**: 2026-03-23 | **Last Amended**: 2026-03-23

<!--
  Sync Impact Report - Amendment v1.0.0 → v1.1.0
  ===============================================
  Version Change: 1.0.0 → 1.1.0 (MINOR - expanded guidance)
  
  Modified Sections:
    - Agent 1 (nix-expert): Added Thinking Process reference listing 8-step reasoning sequence
    - Agent 2 (nix-docs-writer): Added Thinking Process reference listing 10-step reasoning flow

  Added Content:
    - nix-expert Thinking Process: Context → Fit → Impact → Best Practices → Docs → Plan → Minimal → Output → Sanity
    - nix-docs-writer Thinking Process: Context → Audience → Purpose → Placement → Simplification → Examples → Consistency → Strategy → Output → Clarity

  Templates Requiring Update:
    - ✅ .specify/templates/plan-template.md (no changes needed)
    - ⚠️ .specify/templates/spec-template.md (consider Nix-specific requirements section)
    - ⚠️ .specify/templates/tasks-template.md (consider Nix task types)
    - ⚠️ .specify/templates/checklist-template.md (consider Nix validation tasks)

  Deferred Items:
    - Rename technical-writer.md to nix-docs-writer.md (user decision needed)
    - Update templates for Nix-specific workflows (optional enhancement)
-->
