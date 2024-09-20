import 'dart:collection';
import 'dart:io';
import 'dart:math';

class State {
  List<int> jugs;
  State? parent;
  String action; // ito yung mag-eexplain ng actions

  State(this.jugs, this.action, [this.parent]);

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
        nextStates.add(State(
          newJugs,
          "Filled jug ${i + 1} to its capacity (${capacities[i]}).",
          this,
        ));
      }

      // empty yung jug
      if (jugs[i] != 0) {
        List<int> newJugs = List.from(jugs);
        newJugs[i] = 0;
        nextStates.add(State(
          newJugs,
          "Emptied jug ${i + 1}.",
          this,
        ));
      }

      // maglalagay ng tubig from jug i sa jug j
      for (int j = 0; j < n; j++) {
        if (i != j && jugs[i] != 0 && jugs[j] != capacities[j]) {
          List<int> newJugs = List.from(jugs);
          int transfer = min(jugs[i], capacities[j] - jugs[j]);
          newJugs[i] -= transfer;
          newJugs[j] += transfer;
          nextStates.add(State(
            newJugs,
            "Poured $transfer liters from jug ${i + 1} to jug ${j + 1}.",
            this,
          ));
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

  State initialState = State(initial, "Initial state.");
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
    print(path[i].action);
    print("");
  }
}

void main() {
  // magtatanong kung ilang containers
  print("Ilang containers boss: ");
  int n = int.parse(stdin.readLineSync()!);

  // magtatanong kung ilan yung capacities nila
  List<int> capacities = [];
  for (int i = 0; i < n; i++) {
    print("Ilan capacity nung container ${i + 1}: ");
    int capacity = int.parse(stdin.readLineSync()!);
    capacities.add(capacity);
  }

  // magtatanong kung ano yung initial state
  print("Ano yung initial state natin boss (amount ng tubig sa mga jug): ");
  List<int> initial = [];
  for (int i = 0; i < n; i++) {
    print("Gaano karami boss ${i + 1}: ");
    int water = int.parse(stdin.readLineSync()!);
    initial.add(water);
  }

  // magtatanong kung ano yung goal state
  print("Ano yung goal state natin boss (amount nung desired na laman sa jug): ");
  List<int> goal = [];
  for (int i = 0; i < n; i++) {
    print("Gaano karami boss ${i + 1}: ");
    int water = int.parse(stdin.readLineSync()!);
    goal.add(water);
  }

  // i-sosolve yung problem

  State? solution = solve(initial, goal, capacities);

  if (solution != null) {
    print("Ito ang solusyon bossing:");
    printSolution(solution);
  }
  else {
    print("Wala boss di kaya");
  }
}