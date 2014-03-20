import "package:constrained/constrained.dart";

class MapColoringConstraint extends BinaryConstraint {

  MapColoringConstraint(var variable1, var variable2): super(variable1,
      variable2);

  bool isSatisfied(Map assignment) {
    // if either variable is not in the assignment then it must be consistent
    // since they still have their domain
    if (!assignment.containsKey(variable1) || !assignment.containsKey(variable2
        )) {
      return true;
    }
    // check that the color of var1 does not equal var2
    return (assignment[variable1] != assignment[variable2]);
  }
}


void main() {
  List variables = ["Western Australia", "Northern Territory",
      "South Australia", "Queensland", "New South Wales", "Victoria", "Tasmania"];
  Map domains = {};
  for (var variable in variables) {
    domains[variable] = ["r", "g", "b"];
  }

  CSP mapCSP = new CSP(variables, domains);

  mapCSP.addBinaryConstraint(new MapColoringConstraint("Western Australia",
      "Northern Territory"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("Western Australia",
      "South Australia"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("South Australia",
      "Northern Territory"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("Queensland",
      "Northern Territory"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("Queensland",
      "South Australia"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("Queensland",
      "New South Wales"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("New South Wales",
      "South Australia"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("Victoria",
      "South Australia"));
  mapCSP.addBinaryConstraint(new MapColoringConstraint("Victoria",
      "New South Wales"));

  Stopwatch stopwatch = new Stopwatch()
    ..start();
  backtrackingSearch(mapCSP, {}).then((solution) {
    print(stopwatch.elapsedMicroseconds);
    print(solution);
  });
}
