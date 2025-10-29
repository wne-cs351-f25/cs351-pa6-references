# PA6: Parameter Passing Mechanisms

## Overview

This assignment explores different parameter passing mechanisms in programming languages, with a focus on implementing copy-in, copy-out (CICO) semantics. You'll compare call-by-value, call-by-reference, call-by-name, and call-by-need strategies, then implement CICO from a provided REF language base.

## Learning Objectives

- Understand and implement different parameter passing mechanisms
- Compare call-by-value, call-by-reference, call-by-name, and call-by-need semantics
- Implement copy-in, copy-out (CICO) parameter passing
- Analyze how parameter passing affects program behavior and side effects

## Assignment Tasks

### Part 1: Evaluate Parameter Passing Semantics

#### Q1: Basic Parameter Passing

Evaluate the following program in each of the four parameter passing languages (SET, REF, NAME, NEED). You should understand how to evaluate them manually for exams.

```
let
    x = 3
    f = proc(x) set x = 4
in {
    .f(x) ;
    x
}
```

a. **SET (call-by-value):**

```
# Your answer here
```

b. **REF (call-by-reference):**

```
# Your answer here
```

c. **NAME (call-by-name):**

```
# Your answer here
```

d. **NEED (call-by-need):**

```
# Your answer here
```

#### Q2: Side Effects in Parameter Passing

Evaluate the following program in each language:

```
let
    x = 3
    f = proc(x) { x ; x ; x }
in {
    .f(set x = sub1(x));
    x
}
```

a. **SET (call-by-value):**

```
# Your answer here
```

b. **REF (call-by-reference):**

```
# Your answer here
```

c. **NAME (call-by-name):**

```
# Your answer here
```

d. **NEED (call-by-need):**

```
# Your answer here
```

### Part 2: Implement Copy-In, Copy-Out (CICO)

The "copy-in, copy-out" parameter passing semantics (also called "call-by-value-result", "call-by-copy-restore", and "call-by-value-return") combines the semantics of call-by-value with the ability to side-effect the actual parameters if they are variables.

#### Key Characteristics:

- Actual parameter values are copied into formal parameters (copy-in)
- Changes to formal parameters don't affect actual parameters during execution
- Upon procedure return, formal parameter values are copied back to actual parameters (copy-out)
- Only works for actual parameters that are variables

#### Example:

```
let
  x = 5
in
  let
    p = proc(t) {set x = add1(x) ; set t = +(t,t)}
  in
    { .p(x) ; x }
```

- **SET (call-by-value):** evaluates to 6
- **REF (call-by-reference):** evaluates to 12
- **CICO (copy-in, copy-out):** evaluates to 10

### Implementation Instructions

The CICO directory contains the REF implementation. You will modify only the `code`, `ref`, and `val` files. The `grammar`, `prim`, and `env` files remain unchanged.

#### Step 1: Add VarRef Class (in `ref` file)

Add this VarRef class to handle copy-in, copy-out semantics:

```java
%%%VarRef
public class VarRef extends Ref {

    public Val val; // for copy-in
    public Ref ref; // for copy-out

    public VarRef(Ref ref) {
        this.val = ref.deRef(); // local copy
        this.ref = ref;         // where to copy out
    }

    public Val deRef() {
        return val;
    }

    public Val setRef(Val v) {
        return val = v;
    }

    public void copyOut() {
        // TODO: Implement copy-out functionality
        // Set the reference to the current value
    }
}
%%%
```

#### Step 2: Add copyOut Method to Ref Class (in `ref` file)

Add this method to the Ref abstract class:

```java
public void copyOut() {
    // Default: do nothing (for ValRef instances)
}
```

#### Step 3: Modify VarExp evalRef Method (in `code` file)

Change the VarExp evalRef() method to use VarRef instead of direct reference:

```java
public Ref evalRef(Env env) {
    return new VarRef(env.applyEnvRef(var));
}
```

#### Step 4: Modify ProcVal apply Method (in `val` file)

Update the apply() method in ProcVal class to handle copy-out:

Replace the final return statement with:

```java
Val val = body.eval(nenv);
// TODO: Iterate through refList and call copyOut() on each reference
return val;
```

#### Step 5: Complete VarRef copyOut Method

Implement the actual copy-out functionality in the VarRef class.

## Testing Your Implementation

1. Build your CICO language:

   ```bash
   cd CICO
   plccmk
   ```

2. Test with the example program:

   ```bash
   echo "let x = 5 in let p = proc(t) {set x = add1(x) ; set t = +(t,t)} in { .p(x) ; x }" | java -cp Java/ Rep
   ```

   This should evaluate to 10 with correct CICO implementation.

3. Compare with other parameter passing mechanisms by testing the same expressions in SET, REF, NAME, and NEED languages.

## Deliverables

1. Completed Q1 and Q2 evaluations in this file
2. Modified CICO implementation with:
   - Updated `ref` file with VarRef class and copyOut methods
   - Updated `code` file with modified VarExp evalRef
   - Updated `val` file with copy-out logic in ProcVal apply
3. All tests passing with correct CICO semantics
