# Profiles Overview

**Audience**: End User  
**Purpose**: Understand available profiles and choose the right one  
**Prerequisites**: Completed [installation](installation.md)

---

## What is a Profile?

Profiles are "capability bundles" that define your user environment. They include applications, tools, and configurations for specific use cases.

---

## Available Profiles

### Base Profile (`base`)

**For**: All users - foundational layer

**Includes**:
- Essential tools: `bash`, `git`, `curl`, `wget`
- Basic shell configuration
- Common utilities

**Use When**: Building a custom profile or minimal setup

---

### Minimal Profile (`minimal`)

**For**: Recovery, constrained environments, minimalists

**Includes**:
- Absolute basics: `vim`, `wget`
- No extra tools

**Use When**: 
- System recovery
- Ultra-minimal setups
- Resource-constrained machines

---

### Server Profile (`server`)

**For**: Headless servers, VPS, production systems

**Includes**:
- Base profile tools
- Server-hardened configuration
- No graphical environment

**Use When**:
- Running a server
- Headless systems
- Production deployments

---

### Developer Profile (`developer`)

**For**: Software developers, programmers

**Includes**:
- Base profile tools
- Compilers (language-specific)
- IDEs and editors
- Development tooling

**Use When**:
- Software development
- Programming projects
- Building applications

---

### Gaming Profile (`gaming`)

**For**: Gamers, entertainment

**Includes**:
- Base profile tools
- Game launchers
- Graphics drivers
- Gaming peripherals support

**Use When**:
- Gaming desktop/laptop
- Entertainment system
- Multimedia center

---

### Designer Profile (`designer`)

**For**: Designers, content creators

**Includes**:
- Base profile tools
- Design software
- Video editing tools
- Creative applications

**Use When**:
- Graphic design work
- Video editing
- Content creation

---

## Profile Comparison

| Profile | GUI | Dev Tools | Games | Design | Use Case |
|---------|-----|-----------|-------|--------|----------|
| `base` | No | No | No | No | Foundation |
| `minimal` | No | No | No | No | Recovery |
| `server` | No | No | No | No | Headless |
| `developer` | Optional | Yes | No | No | Development |
| `gaming` | Yes | No | Yes | No | Gaming |
| `designer` | Yes | No | No | Yes | Creative |

---

## How Profiles Work

1. **Import**: Profiles import base modules
2. **Compose**: Can combine multiple profiles
3. **Override**: User config can override profile defaults
4. **Switch**: Change profiles anytime

---

## Choosing a Profile

**Questions to Ask**:

1. **Do you need a GUI?**
   - Yes → `developer`, `gaming`, or `designer`
   - No → `base`, `minimal`, or `server`

2. **What's your primary use?**
   - Development → `developer`
   - Gaming → `gaming`
   - Design → `designer`
   - Server → `server`
   - Minimal → `minimal`

3. **Need to customize?**
   - Start with `base` and add packages
   - Or create a custom profile

---

## Next Steps

- [Profile Switching](profile-switching.md) - Learn to switch profiles
- [Troubleshooting](troubleshooting.md) - Common profile issues

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Result**: ✅ Profile descriptions accurate

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
