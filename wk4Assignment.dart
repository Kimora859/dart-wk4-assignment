import 'dart:io';

// Interface for things that can be calculated
abstract class Calculable {
  double calculate();
}

// Shape class with basic properties
class Shape {
  final String color;

  Shape(this.color);
}

// Circle class inheriting from Shape and implementing Calculable
class Circle extends Shape implements Calculable {
  final double radius;
  final String color;
  final double pi = 3.142;

  Circle(this.color, this.radius) : super(color);

  // Override calculate method to calculate area
  @override
  double calculate() {
    return pi * radius * radius;
  }

  // Override draw method specific to Circle (optional)
  @override
  String toString() {
    return "Circle{color: $color, radius: $radius}";
  }
}

// Function to read data from a file and create a Circle object
Circle createCircleFromFile(String filename) {
  try {
    final file = File(filename);
    final lines = file.readAsLinesSync();
    final color = lines[0];
    final radius = double.parse(lines[1]);
    return Circle(color, radius);
  } on FileSystemException catch (e) {
    print("Error: File not found or inaccessible: $e");
    return Circle("", 0.0); // Return a default circle
  } on FormatException {
    print("Error: Invalid data format in file");
    return Circle("", 0.0); // Return a default circle
  }
}

// Function to calculate the total area of multiple circles using a loop
double calculateTotalArea(List<Circle> circles) {
  double totalArea = 0.0;
  for (final circle in circles) {
    totalArea += circle.calculate();
  }
  return totalArea;
}

void main() {
  // Create a Circle object from a file
  final circle1 = createCircleFromFile("circle1.txt");
  print(
      circle1); // Output: Circle{color: <color from file>, radius: <radius from file>}

  // Create another Circle object manually
  final circle2 = Circle("blue", 5.0);

  // List of circles
  final circles = [circle1, circle2];

  // Calculate total area using a loop
  final totalArea = calculateTotalArea(circles);
  print("Total area of all circles: $totalArea");
}
