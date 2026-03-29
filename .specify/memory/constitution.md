<!--
  Sync Impact Report - Amendment v1.2.0 → v1.3.0
  ===============================================
  Version Change: 1.2.0 → v1.3.0 (MINOR - new sections added)

  Added Sections:
    - VIII. Defense in Depth (Security)
    - IX. Zero Trust (Security)
    - X. Secrets Management (Security)
    - XI. Security by Design (Security)
    - XII. Validation Before Apply (Testing)
    - XIII. Test Pyramid for Configuration (Testing)
    - XIV. Reproducibility Verification (Testing)
    - XV. Incremental Change Testing (Testing)
    - Security Principles section
    - Testing Principles section

  Modified Sections:
    - Core Principles: Added Principles VIII-XV (Security & Testing)
    - Development Workflow: Preceded by Security and Testing sections

  Templates Requiring Update:
    - ✅ .specify/templates/plan-template.md (Constitution Check already covers security/testing)
    - ✅ .specify/templates/spec-template.md (no changes needed)
    - ✅ .specify/templates/tasks-template.md (no changes needed)

  Agent Files Referenced:
    - ./agents/skills/security-agent.md
    - ./agents/skills/testing-agent.md

  Deferred Items:
    - None
-->

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

### VII. Documentation as Source of Truth
The `docs/` directory is the first-class source of truth for system behavior. Always consult `docs/` before making assumptions about architecture, workflows, or business logic. Treat documentation as the primary reference for understanding the system.

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
- Produce a structured plan identifying affected layer (module/profile/host)
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

## Vector Indexing & Retrieval (VectorCode)

### Context
The project uses VectorCode (CLI RAG utility) for semantic search over the codebase.

### Key Commands
- `vectorcode init`
- `vectorcode vectorise`
- `vectorcode query`
- `vectorcode update`
- `vectorcode check`

### Constraints & Limitations (MUST ACKNOWLEDGE)
- Retrieval often returns **only a single most semantically similar result**
- May produce **false positives**
- Query quality is **highly dependent on precision**
- Not reliable for broad or exploratory queries

### Rules

**DO:**
- ALWAYS treat VectorCode results as **assistive, not authoritative**
- ALWAYS cross-check retrieved results with:
  - actual source code
  - `docs/` directory
- Prefer **multiple refined queries** over a single broad query
- Use VectorCode primarily for:
  - pinpoint lookups
  - known-symbol searches
  - targeted debugging context

**DON'T:**
- NEVER rely on a single query result for critical decisions
- Do NOT assume retrieved file is the correct one without verification
- Do NOT use vague queries like "show me auth stuff"
- Do NOT skip manual verification of retrieved results

### Usage Priority
When using VectorCode, always verify results against primary sources in this order:
1. `docs/` directory
2. actual source code
3. VectorCode retrieval results (assistive only)

## Documentation Source of Truth (docs/)

### Context
The `docs/` directory contains project documentation and is a first-class source of truth for system behavior and design decisions.

### Rules

**DO:**
- ALWAYS consult `docs/` before making assumptions about system behavior
- Treat `docs/` as:
  - architectural reference
  - workflow guide
  - business logic explanation
- Prefer `docs/` over inferred understanding from partial code
- Ensure code changes align with existing documentation
- Reference `docs/` concepts in explanations and commit messages

**DON'T:**
- Do NOT make architectural decisions without checking `docs/` first
- Do NOT silently resolve ambiguity between code and docs - FLAG it explicitly
- Do NOT introduce behavior that contradicts documented architecture
- Do NOT write explanations that contradict `docs/` without updating docs first

### Usage Priority Order
When reasoning about the system, follow this order:
1. **docs/** - Primary source of truth
2. **actual source code** - Implementation reality
3. **VectorCode retrieval results** - Assistive only

### Mismatch Handling
If there is a mismatch between code and documentation:
1. FLAG the discrepancy explicitly
2. DO NOT silently resolve the ambiguity
3. Update documentation or code to restore consistency
4. Document the resolution in the commit message

## Security Principles

### Context
Security is a first-class concern in system configuration. All changes must be evaluated for security implications.

### Core Security Principles

**VIII. Defense in Depth**
- Multiple layers of security controls must be present
- No single point of failure for security controls
- Layer configuration across modules, profiles, and hosts

**IX. Zero Trust**
- Never trust user inputs, external data, or network requests without verification
- Validate all Nix expressions for injection risks
- Verify integrity of flake inputs and external sources

**X. Secrets Management**
- All secrets must be managed via SOPS with age encryption
- No hardcoded credentials or API keys in configuration files
- Secrets rotation procedures must be documented

**XI. Security by Design**
- Security considerations must be part of planning, not afterthoughts
- Threat modeling required for new modules and profiles
- Risk assessment documented for significant changes

### Security Compliance

For each change, identify:
- Trust boundaries affected
- Data classification involved
- Attack surface implications
- Required security controls

**Agent Reference:** `./agents/skills/security-agent.md`

## Testing Principles

### Context
Configuration changes must be validated to ensure correctness, reproducibility, and expected behavior.

### Core Testing Principles

**XII. Validation Before Apply**
- All changes MUST be validated with `nix flake check` and `nixos-rebuild` dry-run
- Module imports must form a valid DAG (no circular dependencies)
- flake.nix structure integrity must be verified

**XIII. Test Pyramid for Configuration**
- Unit validation: Individual option syntax and type checking
- Integration validation: Module composition and profile combinations
- System validation: Full host builds via `nixos-rebuild build`

**XIV. Reproducibility Verification**
- Changes must produce identical outputs across builds
- No impure evaluation (no environment-dependent behavior)
- All runtime dependencies declared in buildInputs

**XV. Incremental Change Testing**
- Test changes in isolation before combining
- Verify no regression in dependent modules
- Cross-platform testing for multi-system flakes

### Testing Checklist

- [ ] `nix flake check` passes
- [ ] `nix flake eval` validates Nix expressions
- [ ] `nixos-rebuild dry-run` succeeds for affected hosts
- [ ] No circular imports in module structure
- [ ] flake.lock updated if inputs changed

**Agent Reference:** `./agents/skills/testing-agent.md`

## Development Workflow

### Pre-Change Checklist

1. Follow core principles (modularity, declarative, composability)
2. Consult `docs/` for existing patterns and architecture
3. Add inline documentation standard headers to every `.nix` file
4. Validate changes with `scripts/check.sh` before committing
5. Update `.sops.yaml` and re-key secrets if necessary
6. Record changes in `CHANGELOG.md`

### Style Standards

- Format code via `nixfmt-rfc-style`
- Keep modules single-purpose
- Maximum 200 lines per module
- Clear naming conventions for options and definitions

### Research & Discovery Workflow

When investigating existing functionality or planning changes:

1. **First**: Consult `docs/` directory for architectural context
2. **Second**: Use VectorCode for targeted searches (known symbols, specific patterns)
3. **Third**: Manually verify retrieved results against source code
4. **Always**: Cross-reference multiple sources before making decisions

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

**Version**: 1.3.0 | **Ratified**: 2026-03-23 | **Last Amended**: 2026-03-29
