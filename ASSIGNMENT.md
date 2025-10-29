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
3
```
*Explanation: In call-by-value, the value of x (3) is copied to the formal parameter. The set operation changes only the local copy, not the original variable x.*

b. **REF (call-by-reference):**

```
4
```
*Explanation: In call-by-reference, the formal parameter references the same location as the actual parameter. The set operation modifies the original variable x.*

c. **NAME (call-by-name):**

```
4
```
*Explanation: In call-by-name, the actual parameter expression is substituted for the formal parameter. Since we're passing a variable x, it behaves similarly to call-by-reference.*

d. **NEED (call-by-need):**

```
4
```
*Explanation: In call-by-need (lazy evaluation with memoization), the actual parameter is evaluated once when first needed and cached. Since we're passing a variable, it behaves like call-by-reference for assignment.*

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
2
```
*Explanation: The expression `set x = sub1(x)` is evaluated once before the call, setting x to 2 and passing 2 to the procedure. The procedure evaluates its parameter three times (all returning 2), then returns the last value (2). The outer x remains 2.*

b. **REF (call-by-reference):**

```
2
```
*Explanation: A reference to the result of `set x = sub1(x)` is passed. The expression is evaluated once, setting x to 2. The procedure then evaluates this reference three times (all returning 2).*

c. **NAME (call-by-name):**

```
0
```
*Explanation: The expression `set x = sub1(x)` is substituted for the formal parameter. Each time the parameter is evaluated in the procedure body, it re-evaluates `set x = sub1(x)`, decrementing x each time: first to 2, then to 1, then to 0.*

d. **NEED (call-by-need):**

```
2
```
*Explanation: The expression `set x = sub1(x)` is evaluated once when first needed (setting x to 2), then the result is cached. Subsequent evaluations return the cached value (2).*

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

1. ✅ Completed Q1 and Q2 evaluations in this file
2. ✅ Modified CICO implementation with:
   - Updated `ref` file with VarRef class and copyOut methods
   - Updated `code` file with modified VarExp evalRef
   - Updated `val` file with copy-out logic in ProcVal apply
3. ✅ All tests passing with correct CICO semantics

### CICO Implementation Summary

The CICO implementation has been successfully completed with the following modifications:

1. **`ref` file**: Added `VarRef` class that implements copy-in/copy-out semantics and added `copyOut()` method to base `Ref` class
2. **`code` file**: Modified `VarExp.evalRef()` to wrap references in `VarRef` for copy-in behavior
3. **`val` file**: Modified `ProcVal.apply()` to call `copyOut()` on all references after procedure execution

The implementation correctly evaluates the test case to 10, demonstrating proper CICO semantics where:
- Parameters are copied in at call time
- Local changes don't affect originals during execution
- Values are copied back out upon procedure return
