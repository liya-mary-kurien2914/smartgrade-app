import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ✅ Dark Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black87,
                  Colors.blueGrey.shade900,
                ],
              ),
            ),
          ),

          // ✅ Centering Content
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left Side Content (Text & Button)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SmartCGPA',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Achieve Your Dream CGPA with Smart Planning!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/input'); // Navigate to input form
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        'Start Prediction',
                        style: TextStyle(
                          color: Colors.black87, // ✅ Darker text color for better contrast
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),

                    // Contact Details
                    Column(
                      children: [
                        Text(
                          'Contact Us:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'smartcgpa@example.com',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'www.smartcgpa.com',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(width: 40), // Space between text and image

                // Right Side Image
                Image.asset(
                  'assets/student.jpg', // Ensure this image exists in the assets folder
                  width: 500,
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
