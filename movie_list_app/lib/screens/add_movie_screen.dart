import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/firestore_service.dart';

class AddMovieScreen extends StatefulWidget {
  @override
  _AddMovieScreenState createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _directorController = TextEditingController();
  final _posterUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _directorController.dispose();
    _posterUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Movie',
          style: TextStyle(color: Colors.white), // Set AppBar text color
        ),
        backgroundColor: Colors.blueGrey[900], // Set AppBar background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Movie Name',
                  border:
                      OutlineInputBorder(), // Add border around the text field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a movie name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16), // Add space between fields
              TextFormField(
                controller: _directorController,
                decoration: InputDecoration(
                  labelText: 'Director',
                  border:
                      OutlineInputBorder(), // Add border around the text field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the director\'s name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16), // Add space between fields
              TextFormField(
                controller: _posterUrlController,
                decoration: InputDecoration(
                  labelText: 'Poster URL',
                  border:
                      OutlineInputBorder(), // Add border around the text field
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the poster URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final movie = Movie(
                      name: _nameController.text,
                      director: _directorController.text,
                      posterUrl: _posterUrlController.text,
                    );
                    await FirestoreService.addMovie(movie);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blueGrey[900], // Set button background color
                  // Set button text color
                ),
                child: Text(
                  'Save Movie',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
