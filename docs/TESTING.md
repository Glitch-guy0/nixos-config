# User Testing Protocol

**Purpose**: Validate documentation usability with real users

**Scope**: All end-user documentation (Phase 1), developer documentation (Phase 2)

---

## Testing Requirements

All documentation MUST be tested with:

- **Minimum 3 testers** with varying experience levels
- **Timed tasks** to measure completion time
- **Feedback collection** for qualitative insights
- **Iteration** based on findings

---

## Tester Recruitment

### Experience Levels

Recruit testers across these levels:

| Level | Description | Count |
|-------|-------------|-------|
| Beginner | No NixOS experience, basic Linux knowledge | 1 |
| Intermediate | Some NixOS experience, used flakes | 1 |
| Expert | Experienced NixOS user, familiar with this repo | 1 |

### Recruitment Criteria

- **Beginner**: Can use Linux command line, new to Nix/NixOS
- **Intermediate**: Has used NixOS before, understands flakes concept
- **Expert**: Regular NixOS user, can help identify technical inaccuracies

---

## Test Scenarios

### Scenario 1: Fresh Installation (US1)

**Task**: Follow installation documentation to install NixOS

**Success Criteria**:
- Completes installation without external help
- Time < 60 minutes (SC-001)
- System boots successfully
- Can identify what went wrong if failed

**Measurements**:
- Start time
- Completion time
- Stuck points (where did they pause?)
- Help requests (did they ask for help?)
- Final outcome (success/failure)

### Scenario 2: Profile Switching (US2)

**Task**: Find and switch to an appropriate profile

**Success Criteria**:
- Finds profile information in < 2 minutes (SC-004)
- Successfully switches profile
- Understands profile differences

**Measurements**:
- Time to find documentation
- Time to complete switch
- Comprehension check (can they explain profile differences?)

### Scenario 3: Secrets Management (US1)

**Task**: Generate age keys and encrypt a test secret

**Success Criteria**:
- Generates age key successfully
- Encrypts secret without errors
- Can decrypt secret

**Measurements**:
- Completion time
- Error count
- Comprehension of key management

---

## Test Session Structure

### Pre-Test (5 minutes)

1. Explain test purpose: "Testing the documentation, not you"
2. Get consent for observation and timing
3. Record tester experience level
4. Set up screen sharing or observation

### During Test (30-60 minutes)

1. **Observe silently** - Don't help unless completely stuck
2. **Note stuck points** - Where do they hesitate?
3. **Time each task** - Use stopwatch or timing tool
4. **Record verbal feedback** - "Think aloud" protocol
5. **Document workarounds** - What did they try when stuck?

### Post-Test (10 minutes)

1. **Collect quantitative feedback**:
   - Rate clarity 1-5
   - Rate completeness 1-5
   - Rate ease of use 1-5
   
2. **Collect qualitative feedback**:
   - What was most helpful?
   - What was most confusing?
   - What's missing?
   - What should be removed?

3. **Verify success criteria**:
   - Did they complete all tasks?
   - How long did it take?
   - Did they need help?

---

## Feedback Collection

### Quantitative Survey

```markdown
## Documentation Feedback

**Task**: [Installation / Profile Switching / Secrets]

**Experience Level**: [Beginner / Intermediate / Expert]

**Ratings** (1 = Poor, 5 = Excellent):
- Clarity: [1-5]
- Completeness: [1-5]
- Ease of Use: [1-5]
- Command Accuracy: [1-5]

**Would you recommend this documentation to others?** [Yes/No]

**Time to complete**: [minutes]

**External help needed?** [Yes/No - If yes, what kind?]
```

### Qualitative Questions

1. What was the clearest part of the documentation?
2. What was the most confusing part?
3. Where did you get stuck?
4. What information was missing?
5. What should be added?
6. What should be removed?
7. Any other comments?

---

## Results Analysis

### Quantitative Analysis

Calculate for each scenario:

- **Average completion time**
- **Success rate** (% who completed without help)
- **Average ratings** (clarity, completeness, ease)
- **Net Promoter Score** (% recommend - % wouldn't recommend)

### Qualitative Analysis

Identify themes:

- **Common stuck points** (mentioned by 2+ testers)
- **Missing information** (requested by 2+ testers)
- **Confusing sections** (rated low clarity)
- **Helpful sections** (mentioned positively)

---

## Iteration Process

### After Each Test Session

1. **Document findings** immediately
2. **Identify critical issues** (blockers)
3. **Fix critical issues** before next test
4. **Note patterns** across testers

### After All Test Sessions

1. **Aggregate results** from all testers
2. **Prioritize fixes** by impact and frequency
3. **Update documentation** for top issues
4. **Re-test** if major changes made
5. **Document changes** made based on feedback

---

## Success Criteria Validation

### SC-001: Installation in < 60 minutes

**Measurement**: Average time across all testers  
**Target**: < 60 minutes for all experience levels  
**Validation**: All 3 testers complete in < 60 minutes

### SC-004: Find answers in < 2 minutes

**Measurement**: Time to locate relevant documentation  
**Target**: < 2 minutes for common tasks  
**Validation**: Average < 2 minutes across all testers

### SC-007: Positive usability feedback

**Measurement**: Survey ratings and qualitative feedback  
**Target**: Average rating ≥ 4/5, positive comments  
**Validation**: 3+ testers provide positive feedback

---

## Test Session Template

```markdown
# Test Session: [Tester Initials]

**Date**: YYYY-MM-DD  
**Experience Level**: [Beginner/Intermediate/Expert]  
**Scenario**: [Installation/Profile Switching/Secrets]

## Results

**Completion Time**: XX minutes  
**Success**: [Yes/No]  
**Help Needed**: [Yes/No - describe]

## Ratings

- Clarity: X/5
- Completeness: X/5
- Ease of Use: X/5

## Stuck Points

1. [Where they got stuck]
2. [What they tried]
3. [Resolution]

## Feedback

**Most Helpful**: [quote or summary]  
**Most Confusing**: [quote or summary]  
**Missing**: [what they said was missing]

## Action Items

- [ ] [Fix to implement]
- [ ] [Section to clarify]
- [ ] [Information to add]
```

---

## Version Information

**Version**: 1.0.0  
**Created**: 2026-03-24  
**Feature**: 001-update-docs
