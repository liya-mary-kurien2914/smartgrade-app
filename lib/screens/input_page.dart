import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _currentCGPAController = TextEditingController();
  TextEditingController _desiredCGPAController = TextEditingController();
  String? _selectedSemester;
  String? _thinkingStyle;

  final List<String> semesters = ['S1', 'S2', 'S3', 'S4', 'S5', 'S6', 'S7', 'S8'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/background.jpg",
            fit: BoxFit.cover,
          ),

          // Semi-transparent Overlay
          Container(color: Colors.black.withOpacity(0.5)),

          // Main Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SmartCGPA Calculator",
                    style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  // Form
                  Card(
                    color: Colors.white.withOpacity(0.85),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Current Semester
                            Text("Current Semester", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            DropdownButtonFormField<String>(
                              value: _selectedSemester,
                              items: semesters.map((sem) => DropdownMenuItem(value: sem, child: Text(sem))).toList(),
                              onChanged: (value) => setState(() => _selectedSemester = value),
                              decoration: InputDecoration(border: OutlineInputBorder()),
                              validator: (value) => value == null ? "Select your current semester" : null,
                            ),
                            SizedBox(height: 15),

                            // Current CGPA
                            Text("Current CGPA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            TextFormField(
                              controller: _currentCGPAController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Enter current CGPA";
                                final cgpa = double.tryParse(value);
                                if (cgpa == null || cgpa < 0 || cgpa > 10) return "Enter a valid CGPA (0 - 10)";
                                return null;
                              },
                            ),
                            SizedBox(height: 15),

                            // Desired CGPA
                            Text("Desired CGPA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            TextFormField(
                              controller: _desiredCGPAController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(border: OutlineInputBorder(), filled: true, fillColor: Colors.white),
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Enter desired CGPA";
                                
                                final desiredCGPA = double.tryParse(value);
                                final currentCGPA = double.tryParse(_currentCGPAController.text);
                                
                                if (desiredCGPA == null || desiredCGPA < 0 || desiredCGPA > 10) return "Enter a valid CGPA (0 - 10)";
                                if (currentCGPA != null && desiredCGPA < currentCGPA) return "Desired CGPA must be ≥ Current CGPA";
                                
                                if (_selectedSemester != null) {
                                  int completedSemesters = semesters.indexOf(_selectedSemester!) + 1;
                                  int remainingSemesters = 8 - completedSemesters;
                                  double maxPossibleCGPA = ((currentCGPA! * completedSemesters) + (10 * remainingSemesters)) / 8;
                                  
                                  if (desiredCGPA > maxPossibleCGPA) {
                                    return "Unattainable CGPA. Max possible: ${maxPossibleCGPA.toStringAsFixed(2)}";
                                  }
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),

                            // Thinking Style
                            Text("Thinking Style", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            TextFormField(
                              readOnly: true,
                              controller: TextEditingController(text: _thinkingStyle ?? ""),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  message: "🔹 Logical: Step-by-step problem-solving approach.\n"
                                      "🔹 Conceptual: Focuses on recognizing patterns and recalling key ideas.",
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.info_outline, color: Colors.blue),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                String? result = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Select Thinking Style"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text("Logical"),
                                            subtitle: Text("Prefers structured, step-by-step problem-solving."),
                                            onTap: () => Navigator.pop(context, "Logical"),
                                          ),
                                          ListTile(
                                            title: Text("Conceptual"),
                                            subtitle: Text("Recognizes patterns and recalls key ideas."),
                                            onTap: () => Navigator.pop(context, "Conceptual"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                if (result != null) {
                                  setState(() {
                                    _thinkingStyle = result;
                                  });
                                }
                              },
                              validator: (value) => value == null || value.isEmpty ? "Select thinking style" : null,
                            ),
                            SizedBox(height: 25),

                            // Submit Button
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.pushNamed(context, '/result', arguments: {
                                      "currentCGPA": _currentCGPAController.text,
                                      "desiredCGPA": _desiredCGPAController.text,
                                      "semester": _selectedSemester,
                                      "thinkingStyle": _thinkingStyle
                                    });
                                  }
                                },
                                child: Text("Next", style: TextStyle(fontSize: 18, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
