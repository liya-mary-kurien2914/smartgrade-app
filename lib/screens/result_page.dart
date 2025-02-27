import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> arguments;

  ResultPage({required this.arguments});

  @override
  Widget build(BuildContext context) {
    String currentSemester = arguments["semester"];
    double currentCGPA = double.parse(arguments["currentCGPA"]);
    double desiredCGPA = double.parse(arguments["desiredCGPA"]);

    // Convert semester string (e.g., "S5") to an integer
    int currentSemIndex = int.parse(currentSemester.substring(1)); // Extract number from "Sx"

    // Number of remaining semesters
    int remainingSems = 8 - currentSemIndex;

    // Calculate required SGPA per semester
    double requiredSGPA = ((desiredCGPA * 8) - (currentCGPA * currentSemIndex)) / remainingSems;

    return Scaffold(
      appBar: AppBar(title: Text("SGPA Calculation")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "To achieve your desired CGPA of $desiredCGPA, you need the following SGPA in each remaining semester:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: remainingSems,
                itemBuilder: (context, index) {
                  int semesterNumber = currentSemIndex + index + 1; // Start from next semester
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("Semester S$semesterNumber"),
                      subtitle: Text("Required SGPA: ${requiredSGPA.toStringAsFixed(2)}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navigate to subject-wise breakdown for this semester
                          Navigator.pushNamed(context, '/subjectBreakdown', arguments: {
                            "semester": "S$semesterNumber",
                            "requiredSGPA": requiredSGPA,
                            "thinkingStyle": arguments["thinkingStyle"]
                          });
                        },
                        child: Text("Next"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
