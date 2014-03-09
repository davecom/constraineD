part of constrained;

/// Return an unassigned variable - we may want to use some logic here to return the
/// minimum-remaining values
selectUnassignedVariable(Map assignment, CSP csp, bool mrv) {
  // do we want to use the mrv heuristic
  if (mrv) {
    //get the one with the biggest domain
    int maxRemainingValues = 0;
    var maxVariable;
    for (var variable in csp.variables) {
      if (!assignment.containsKey(variable)) {
        if (csp.domains[variable].length > maxRemainingValues) {
          maxRemainingValues = csp.domains[variable].length;
          maxVariable = variable;
        }
      }
    }
    return maxVariable;
  } else { //if not just pick the first one that comes up
    for (var variable in csp.variables) {
      if (!assignment.containsKey(variable)) return variable;
    }
  }
}

/// get the domain variables in a good order
orderDomainValues(var variable, Map assignment, CSP csp, bool lcv) {
  if (lcv) {
      /*// currently works only for binary constraints
        // dictionary that we'll sort by the key - the number of constraints
        Map newOrder = {};
        // go through the constraints of the var for each value
        for (var val in csp.domains[variable]) {
            int constraintCount = 0;
            for (var constraint in csp.constraints[variable]) {
                var variableOfInterest = constraint.variable1;
                if (constraint.variable1 == variable) variableOfInterest = constraint.variable2;
                if (csp.domains[variableOfInterest].contains(val)) constraintCount ++;
            newOrder[val] = constraintCount;
        }
        // sort by the constraint_count and return the lowest ones first
        List valList = [];
        for pair in sorted(new_order.items(), key=itemgetter(1)):
            val_list.append(pair[0])
        return val_list */
  } else {
    // no logic right now just return the domain
    return csp.domains[variable];
  }
}

/// check if the value assignment is consistent by checking all constraints of the variable
bool isConsistent(var variable, var value, Map assignment, CSP csp) {
  Map tempAssignment = new Map.from(assignment);
  tempAssignment[variable] = value;
  for (Constraint constraint in csp.constraints[variable]) {
    if (!constraint.isSatisfied(tempAssignment)) return false;
  }
  return true;
}

/// the meat of the backtrack algorithm - a recursive depth first search
/// Returns the assignment, or null if none can be found
Map backtrackingSearch(CSP csp, Map assignment, {bool mrv: false, bool
    mac3: false, bool lcv: false}) {
  // assignment is complete if it has as many assignments as there are variables
  if (assignment.length == csp.variables.length) return assignment;

  // get a var to assign
  var variable = selectUnassignedVariable(assignment, csp, mrv);

  // get the domain of it and try each value in the domain
  for (var value in orderDomainValues(variable, assignment, csp, lcv)) {
    Map oldAssignment = new Map.from(assignment);

    // if the value is consistent with the current assignment we continue
    if (isConsistent(variable, value, assignment, csp)) {

      // assign it since it's consistent
      assignment[variable] = value;

      // do inferencing if we have that turned on
      if (mac3) {
        /*
                inferences = inference(var, assignment, csp)
                #by design inferences will have assignments already made
                
                if (inferences != False):
                    assignment = inferences
                    result = backtrack(assignment, csp)
                    
                    if (result != False) return result; */
      } else {

        Map result = backtrackingSearch(csp, assignment, mrv: mrv, mac3: mac3, lcv: lcv);
        if (result != null) return result;
      }
    }

    //substitution for removing everything
    assignment = oldAssignment;
  }
  return null;
}
