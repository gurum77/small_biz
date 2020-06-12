import 'dart:io';

void main(List<String> arguments) {
  File visionTextFile = File('visiontext1.txt');
  List<String> lines = visionTextFile.readAsLinesSync();

  print(lines);
}
