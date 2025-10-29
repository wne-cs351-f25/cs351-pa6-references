# PA6: Parameter Passing Mechanisms

## Overview

This assignment explores different parameter passing mechanisms in programming languages. You'll compare call-by-value (SET), call-by-reference (REF), call-by-name (NAME), and call-by-need (NEED) strategies, then implement copy-in, copy-out (CICO) semantics.

## Repository Structure

```
pa6/
├── SET/        # Call-by-value implementation
├── REF/        # Call-by-reference implementation
├── NAME/       # Call-by-name implementation
├── NEED/       # Call-by-need implementation
├── CICO/       # Copy-in, copy-out (to be completed)
└── ASSIGNMENT.md  # Detailed assignment instructions
```

## Quick Start

### Using GitHub Codespaces

1. Click the green "Code" button above
2. Select "Codespaces" tab
3. Click "Create codespace on main"
4. Wait for the environment to build (first time takes ~2-3 minutes)
5. The terminal will open with PLCC ready to use

### Using VS Code DevContainers

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)
2. Install [VS Code](https://code.visualstudio.com/)
3. Install the "Dev Containers" extension in VS Code
4. Clone this repository locally
5. Open in VS Code and click "Reopen in Container" when prompted
6. The environment will build with PLCC installed

## Assignment Tasks

1. **Part 1**: Evaluate given expressions using all four parameter passing mechanisms
2. **Part 2**: Implement CICO (copy-in, copy-out) semantics by modifying the REF implementation

See `ASSIGNMENT.md` for complete instructions and requirements.

## Submission

**To Submit:**

1. Complete all questions, including written answers in this README
2. Test your grammars to ensure they work correctly
3. From inside your container: `tar -czf /workspace/pa6-YOURNAME.zip /workspace`
4. Download and submit the zip file to Kodiak

**Grading Criteria:**

- **Submission (33.3%):** Files are properly named and located as specified
- **Completeness (33.3%):** All questions attempted (incomplete = incorrect)
- **Correctness (33.3%):** Solutions demonstrate understanding of syntax specifications

**Late Policy:** 10% per day, maximum 5 days late

Good luck with your assignment!

---

_Course content developed by Declan Gray-Mullen for WNEU with Claude_
