part of constrained;

/// empty base class
abstract class Constraint {
    bool isSatisfied(Map assignment);
}

/// constraint of one variable
abstract class UnaryConstraint extends Constraint {
  var variable;
  UnaryConstraint(this.variable);
}

/// constraint between two variables
abstract class BinaryConstraint extends Constraint {
  var variable1, variable2;
  BinaryConstraint(this.variable1, this.variable2);
}

/// constraint between multiple variables
abstract class ListConstraint extends Constraint {
  List variables;
  ListConstraint(this.variables);
}