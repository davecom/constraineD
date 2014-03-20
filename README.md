constraineD
===========

Constraint Satisfaction Problem Solver for Dart that uses a basic backtracking algorithm.
It has no external dependencies and currently works. It is quite slow due to unimplemented optimizations like MAC3 and LCV.

It does however support the MRV optimization.

## Constraints
Constraints are defined with an object hierarchy that begins with the primitive abstract class **Constraint**. All **Constraint** objects must implement one method - *isSatisfied()* - which returns a *bool* indicating whether the constraint has been satisfied by the provided assignment. The abstract subclasses **UnaryConstraint**, **BinaryConstraint**, and **ListConstraint** should typically be subclassed by a program using *constraineD* with an implementation of *isSatisfied()* being the primary definition of a problem.

## CSPs
A **CSP** is an object that defines a (C)onstraint (S)atisfaction (P)roblem. It holds all of the variables and constraints utilizing those variables that make up a problem. It also holds a domain for each variables through a map called *domains*. 

## Solving a CSP
A **CSP** is solved using a simple backtracking algorithm via the function *backtrackingSearch()*. It takes a **CSP** and a *Map* called *assignment*. Typically *assignment* will just be a blank map when you start up *backtrackingSearch*. *backtrackingSearch* returns a *Future<Map>* that represents a Map of the resulting assignments from successfully solving the **CSP**. If no result could be found this *Future* will hold a *null* value (equivalent of *new Future.value(null)*).

*backtrackingSearch()* has optional placeholders for the MRV, LCV, and MAC3 backtracking search constraint satisfaction problem optimizations that can be turned on via optional boolean parameters. A buggy implemention of MRV is already written, but for now LCV and MAC3 are just true placeholders.

## Examples
There are examples of SEND + MORE = MONEY, the Australian Map Coloring Problem, and a couple circuit board layout problems in the *test* directory. There is also an example of using constraineD for creating a non-overlapping wordsearch grid in Chapter 16 of Dart for Absolute Beginners.
