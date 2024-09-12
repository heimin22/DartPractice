import 'dart:io';

class PriorityQueue<T> {
  List<T> _elements = [];
  final int Function(T, T) comparator;

  PriorityQueue(this.comparator);

  void add(T element) {
    _elements.add(element);
    _elements.sort(comparator);
  }

  T removeFirst() {
    return _elements.removeAt(0);
  }

  bool get isNotEmpty => _elements.isNotEmpty;
}

class State {
  List<List<int>> puzzle;
  int cost; // Cost (g + h)
  int moves; // Moves taken (g)
  State? parent;

  State(this.puzzle, this.moves, this.cost, this.parent);

  // Find the position of the empty space (0).
  List<int> findEmptySpace() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (puzzle[i][j] == 0) {
          return [i, j];
        }
      }
    }
    return [-1, -1];
  }

  // Check if current state matches the goal state.
  bool isGoal(List<List<int>> goal) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (puzzle[i][j] != goal[i][j]) return false;
      }
    }
    return true;
  }

  // Clone the state for movement.
  List<List<int>> clonePuzzle() {
    return puzzle.map((row) => List<int>.from(row)).toList();
  }

  // Heuristic: Sum of Manhattan distances of all tiles from their goal positions.
  static int calculateHeuristic(List<List<int>> puzzle, List<List<int>> goal) {
    int distance = 0;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        int value = puzzle[i][j];
        if (value != 0) {
          for (int x = 0; x < 3; x++) {
            for (int y = 0; y < 3; y++) {
              if (goal[x][y] == value) {
                distance += (x - i).abs() + (y - j).abs();
              }
            }
          }
        }
      }
    }
    return distance;
  }
}

State? solvePuzzle(List<List<int>> initial, List<List<int>> goal) {
  PriorityQueue<State> queue = PriorityQueue((a, b) => a.cost.compareTo(b.cost));
  Set<String> visited = {};
  int steps = 0; // bibilangin yung steps tapos maeexpand yung nodes
  const stepsLimit = 10000;

  // heuristic para sa initial state ni tropa
  int initialHeuristic = State.calculateHeuristic(initial,goal);
  State initialState = State(initial, 0, initialHeuristic, null);
  queue.add(initialState);

  while (queue.isNotEmpty) {
    State currentState = queue.removeFirst();
    steps++; // bilang bawat steps

    if (steps >= stepsLimit) {
      print("Step limit reached, di kaya boss, lagpas 10000 steps na.");
      return null;
    }

    if (currentState.isGoal(goal)) {
      print('Total steps (nodes expanded): $steps');
      return currentState;
    }

    // convert yung state to string para sa mga visited set
    String stateString = currentState.puzzle.toString();
    if (visited.contains(stateString)) {
      continue;
    }
    visited.add(stateString);

    // kukunin naman nito yung position ng empty tile
    List<int> emptyPos = currentState.findEmptySpace();
    int emptyRow = emptyPos[0];
    int emptyCol = emptyPos[1];

    List<List<int>> directions = [
      [-1, 0],
      [1, 0],
      [0, -1],
      [0, 1],
    ];

    for (List<int> direction in directions) {
      int newRow = emptyRow + direction[0];
      int newCol = emptyCol + direction[1];

      if (newRow >= 0 && newRow < 3 && newCol >= 0 && newCol < 3) {
        // cloclone niya naman yung puzzle para sa new state
        List<List<int>> newPuzzle = currentState.clonePuzzle();
        // swap yung mga empty space duon sa new position
        newPuzzle[emptyRow][emptyCol] = newPuzzle[newRow][newCol];
        newPuzzle[newRow][newCol] = 0;

        int newMoves = currentState.moves + 1;
        int newHeuristic = State.calculateHeuristic(newPuzzle, goal);
        int totalCost = newMoves + newHeuristic;
        State newState = State(newPuzzle, newMoves, totalCost, currentState);
        queue.add(newState);
      }
    }
  }

  print("Total steps ni nigga: $steps");
  return null;
}

void printPuzzle(List<List<int>> puzzle) {
  for (int i = 0; i < 3; i++) {
    print(puzzle[i].map((e) => e == 0 ? ' ' : e).join(' '));
  }
  print('\n');
}

void showSolution(State? state) {
  if (state == null) return;
  List<State> steps = [];
  while (state != null) {
    steps.add(state);
    state = state.parent;
  }
  steps = steps.reversed.toList();

  print("Solution found in ${steps.length - 1} moves:");
  for (State step in steps) {
    printPuzzle(step.puzzle);
  }
}

void main() {
  // ito yung goal state ko dapat
  List<List<int>> goal = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
  ];

  // tapos ito yung kukuha sa initial state ng user
  List<List<int>> initial = [];
  print("Enter the initial 8-puzzle configuration (row by row, use 0 for the empty space");
  for (int i = 0; i < 3; i++) {
    initial.add(stdin.readLineSync()!.split(' ').map(int.parse).toList());
  }

  print("\nInitial State:");
  printPuzzle(initial);

  print("\nGoal State:");
  printPuzzle(goal);

  // cacall niya na si otits solvePuzzle to save this nigga's day
  State? solution = solvePuzzle(initial, goal);

  if (solution != null) {
    showSolution(solution);
  }
  else {
    print("Unsolvable boss");
  }
}