# Research: Documentation Overhaul

**Feature**: 001-update-docs  
**Date**: 2026-03-24  
**Purpose**: Resolve technical unknowns and document best practices for documentation overhaul

## Research Findings

### 1. Documentation Structure Best Practices

**Decision**: Audience-based documentation structure with three distinct sections

**Rationale**: 
- Aligns with user mental models (users know whether they're end-users or contributors)
- Reduces cognitive load by filtering irrelevant content
- Matches industry standards (Microsoft, Google, Red Hat documentation patterns)

**Alternatives Considered**:
- Task-based organization: Rejected because users still need audience context
- Hybrid approach: Too complex for initial implementation
- Single unified guide: Rejected due to mixed audience confusion

### 2. Documentation Content Strategy

**Decision**: Phased delivery approach

**Rationale**:
- Phase 1 delivers immediate value (core operations)
- Reduces risk by validating Phase 1 before committing to comprehensive docs
- Allows user feedback to shape Phase 2+ content

**Phases Defined**:
- **Phase 1**: Installation, profile switching, basic troubleshooting, secrets management
- **Phase 2**: Architecture deep-dives, migration guides, advanced contributor workflows
- **Phase 3**: Comprehensive reference, API documentation (if applicable)

### 3. Markdown Documentation Standards

**Decision**: Clean technical style with consistent formatting

**Rationale**:
- Markdown is repository standard
- Clean style improves readability
- Professional tone suits technical audience

**Formatting Standards**:
- Headers: `#` for title, `##` for sections, `###` for subsections
- Code blocks: Triple backticks with language identifier
- Callouts: Blockquotes with bold labels (e.g., `> **Note**:`)
- Lists: Hyphen-based unordered lists
- Tables: Standard Markdown tables with alignment

### 4. Command Validation Strategy

**Decision**: All documented commands must be tested before documentation is complete

**Rationale**:
- Ensures accuracy (FR-003)
- Prevents user frustration from broken instructions
- Maintains documentation credibility

**Validation Process**:
1. Write command in documentation draft
2. Execute command in clean test environment
3. Verify expected output
4. Update documentation if discrepancies found
5. Mark command as "tested" in draft

### 5. NixOS Documentation Conventions

**Decision**: Follow NixOS manual conventions for terminology and structure

**Rationale**:
- Users familiar with NixOS expect standard terminology
- Reduces learning curve
- Aligns with ecosystem expectations

**Key Conventions**:
- "flake.nix" not "Flake" or "flake file"
- "Home Manager" capitalized
- "nixos-rebuild" command format
- "host" for machine configurations
- "profile" for user environment bundles

### 6. Documentation Testing Strategy

**Decision**: User feedback testing with 3+ testers of varying experience levels

**Rationale**:
- Validates SC-007 (positive usability feedback)
- Catches unclear instructions before release
- Provides diverse perspectives (beginner, intermediate, expert)

**Testing Protocol**:
1. Recruit testers with varying NixOS experience
2. Provide task list (install, switch profile, etc.)
3. Observe without assistance
4. Collect time-to-completion metrics
5. Gather qualitative feedback
6. Iterate on documentation based on findings

## Resolved Clarifications

| Unknown | Resolution | Source |
|---------|------------|--------|
| Documentation approach | Delete and replace all existing docs | User clarification Q1 |
| Organization structure | Audience-based (End User, Developer, Contributor) | User clarification Q2 |
| Prerequisites | Assume basic Linux, explain NixOS concepts | User clarification Q3 |
| Content scope | Phased: Core first, comprehensive later | User clarification Q4 |
| Visual style | Clean technical with professional tone | User clarification Q5 |

## Best Practices Summary

### Technical Writing
- Write in active voice
- Use imperative mood for instructions ("Run this command" not "You should run")
- Include expected output examples
- Provide troubleshooting notes for common failures
- Link to related sections for discoverability

### Code Documentation
- Show complete, runnable examples
- Include comments for non-obvious parts
- Use consistent formatting
- Test all examples

### User Experience
- Front-load critical information
- Use progressive disclosure (basics first, advanced later)
- Provide search-friendly headings
- Include table of contents for long documents

## Dependencies & Risks

### Dependencies
- Repository structure must remain stable during documentation development
- Scripts in `scripts/` must remain functional
- NixOS/Home Manager commands must remain current

### Risks
- **Documentation drift**: Mitigated by testing commands before publication
- **Scope creep**: Mitigated by phased approach with clear Phase 1 boundaries
- **User resistance to change**: Mitigated by clear migration notes

## Recommendations

1. **Start with Phase 1**: Focus on core operations first
2. **Test as you write**: Validate each command during documentation
3. **Get early feedback**: Share drafts with 1-2 users before finalizing
4. **Plan Phase 2**: Document what Phase 2 will cover to set expectations
