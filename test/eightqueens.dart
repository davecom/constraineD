import "package:constrained/constrained.dart";

class EightQueensConstraint extends ListConstraint {

  EightQueensConstraint(var positions) : super(positions);

  bool isSatisfied(Map assignment) {
    Iterable d = assignment.values;

    // not the most efficient check for attacking each other...
    // better to subtract one from the other and go from there
    for (int q in d) {
      for (int i = q - 1; q % 8 > i % 8; i--) { //same file backwards
        if (d.contains(i)) {
          return false;
        }
      }
      for (int i = q + 1; q % 8 < i % 8; i++) { //same file forwards
        if (d.contains(i)) {
          return false;
        }
      }
      for (int i = q - 9; i >= 0 && q % 8 > i % 8; i -= 9) { // diagonal up and back
        if (d.contains(i)) {
          return false;
        }
      }
      for (int i = q - 7; i >= 0 && q % 8 < i % 8; i -= 7) { // diagonal up and forward
        if (d.contains(i)) {
          return false;
        }
      }
      for (int i = q + 7; i < 64 && i % 8 < q % 8; i += 7) { // diagonal down and back
        if (d.contains(i)) {
          return false;
        }
      }
      for (int i = q + 9; i < 64 && q % 8 < i % 8; i += 9) { // diagonal down and forward
        if (d.contains(i)) {
          return false;
        }
      }
    }

    // until we have all of the variables assigned, the assignment is valid
    return true;
  }
}

void drawQueens(Map solution) {
  String output = "";
  for (int i = 0; i < 64; i++) {
    if (solution.values.contains(i)) {
      output += "Q";
    } else {
      output += "X";
    }
    if (i % 8 == 7) {
      output += "\n";
    }
  }
  print(output);
}


void main() {
  List variables = [0, 1, 2, 3, 4, 5, 6, 7];
  Map domains = {};
  for (int variable in variables) {
    domains[variable] = new List();
    for (int i = variable; i < 64; i += 8) {
      domains[variable].add(i);
    }
  }

  CSP eightQueensCSP = new CSP(variables, domains);

  eightQueensCSP.addListConstraint(new EightQueensConstraint(variables));

  Stopwatch stopwatch = new Stopwatch()..start();
  backtrackingSearch(eightQueensCSP, {}, mrv: true).then((solution) {
    print("Took " + stopwatch.elapsed.toString() + " seconds to solve.");
    print(solution);
    drawQueens(solution);
  });

}
