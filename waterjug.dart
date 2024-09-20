import 'dart:collection';
import 'dart:ffi';
import 'dart:io';

class State {
  List<int> jugs;
  State? parent;

  State(this.jugs, [this.parent]);

  // method para macheck if yung currect state ba is equal duon sa final state
  bool isGoal(List<int> goal) {
    return jugs.equals(goal);
  }

  // taga-generate ng possible next states
  List<State> getNextStates(List<int> capacities) {
    List<State> nextStates = [];
    int n = jugs.length;

    // create ng copy ng current state
    for (int i = 0; i < n; i++) {
      if (jugs[i] != capacities[i]) {
        List<int> newJugs = List.from(jugs);
        newJugs[i] = capacities[i];
        nextStates.add(State(newJugs, this));
      }

      // empty yung jug
      if (jugs[i] != 0) {
        List<int> newJugs = List.from(jugs);
        newJugs[i] = 0;
        nextStates.add(State(newJugs, this));
      }

      // maglalagay ng tubig from jug i sa jug j
      for (int j = 0; j < n; j++) {
        if (i != j && jugs[i] != 0 && jugs[j] != capacities[j]) {
          List<int> newJugs = List.from(jugs);
          int transfer = min(jugs[i], capacities[j] - jugs[j]);
          newJugs[i] -= transfer;
          newJugs[j] += transfer;
          nextStates.add(State(newJugs, this));
        }
      }
    }

    return nextStates;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is State &&
        runtimeType == other.runtimeType &&
        jugs.equals(other.jugs);
  @override
  // TODO: implement hashCode
  int get hashCode => jugs.hashCode;
}

extension ListEquality on List<int> {
  bool equals(List<int> other) {
    if (length != other.length) return false;
    for (int i = 0; i < length; i++) {
      if (this[i] != other[i]) return false;
    }
    return true;
  }
}

// breadth first search algo para masolve yung problem
State? solve(List<int> initial, List<int> goal, List<int> capacities) {
  Queue<State> queue = Queue<State>();
  Set<State> visited = Set<State>();

  State initialState = State(initial);
  queue.add(initialState);
  visited.add(initialState);

  while(queue.isNotEmpty) {
    State currentState = queue.removeFirst();

    if (currentState.isGoal(goal)) {
      return currentState;
    }

    for (State nextState in currentState.getNextStates(capacities)) {
      if (!visited.contains(nextState)) {
        queue.add(nextState);
        visited.add(nextState);
      }
    }
  }

  return null;
}

// print yung steps galing initial state papuntang goal state
void printSolution(State state) {
  List<State> path = [];
  State? current = state;
  while (current != null) {
    path.add(current);
    current = current.parent;
  }

  for (int i = path.length - 1; i >= 0; i--) {
    print("Jugs: ${path[i].jugs}");
  }
}

void main() {
  // magtatanong kung ilang containers
  print("Ilang containers boss: ");
  int n = int.parse(stdin.readLineSync()!);

  // magtatanong kung ilan yung capacities nila
  List<int> capacities = [];
  for (int i = 0; i < n; i++) {
    print("Ilan yung laman nung container ${i + 1}: ");
    int capacity = int.parse(stdin.readLineSync()!);
    capacities.add(capacity);
  }

  // magtatanong kung ano yung initial state
}