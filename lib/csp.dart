part of constrained;

/// CSP = Constraint Satisfaction Problem
class CSP {
  final List variables;
  final Map domains;
  Map constraints = {};
  
  CSP(this.variables, this.domains) {
    for (var variable in variables) {
      constraints[variable] = [];
    }
  }
  
  void addUnaryConstraint(UnaryConstraint uc) {
    constraints[uc.variable].add(uc);
  }
  
  void addBinaryConstraint(BinaryConstraint bc) {
    constraints[bc.variable1].add(bc);
    constraints[bc.variable2].add(bc);
  }
  
  void addListConstraint(ListConstraint lc) {
    for (var variable in lc.variables) {
      constraints[variable].add(lc);
    }
  }
}