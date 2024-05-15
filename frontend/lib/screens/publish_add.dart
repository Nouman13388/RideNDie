import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/screens/bottom_navbar.dart';

class PublishAdScreen extends StatefulWidget {
  const PublishAdScreen({Key? key}) : super(key: key);

  @override
  _PublishAdScreenState createState() => _PublishAdScreenState();
}

class _PublishAdScreenState extends State<PublishAdScreen> {
  String selectedCarModel = '2024';
  int selectedMileage = 0;
  String selectedCity = 'Abbottabad';
  String selectedCarType = 'Sedan';
  int price = 0;
  String description = '';
  String title = '';

  bool mileageError = false;
  bool priceError = false;
  bool descriptionError = false;
  bool titleError = false;

  // Firestore instance

  // Collection reference
  final CollectionReference _adsCollection =
      FirebaseFirestore.instance.collection('Ads');

  // List to store uploaded images
  List<String> uploadedImages = [];

  @override
  Widget build(BuildContext context) {
    List<String> carModels = [];
    for (int year = 2024; year >= 1960; year--) {
      carModels.add('$year');
    }

    List<String> carTypes = ['Sedan', 'Hatchback', 'SUV', 'Other'];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Publish Ad',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.indigoAccent,
                          width: 2.0,
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 35,
                        child: Icon(
                          CupertinoIcons.camera,
                          color: Colors.indigo,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add Photos',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Container to display uploaded images
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 115, 131, 217),
                          width: 1.0,
                        ),
                      ),
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: uploadedImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 80,
                            width: 80,
                            color: Colors.indigo[300],
                            child: Center(
                              child: Text(
                                'Image ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Category: ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  value: selectedCarType,
                  items: carTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCarType = newValue ?? '';
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Car Model: ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  value: selectedCarModel,
                  items: carModels.map((String model) {
                    return DropdownMenuItem<String>(
                      value: model,
                      child: Text(model),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCarModel = newValue ?? '';
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Registered City: ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownButton<String>(
                  value: selectedCity,
                  items: <String>[
                    'Abbottabad',
                    'Bahawalpur',
                    'Faisalabad',
                    'Gujranwala',
                    'Hyderabad',
                    'Islamabad',
                    'Karachi',
                    'Lahore',
                    'Multan',
                    'Peshawar',
                    'Quetta',
                    'Rawalpindi',
                    'Sahiwal',
                    'Sargodha',
                    'Sialkot',
                    'Sukkur',
                    'Swat',
                    'Taxila',
                    'Wah',
                    'Zhob'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCity = newValue ?? '';
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Add Title: ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                      titleError = title.isEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Add Title',
                    border: const OutlineInputBorder(),
                    errorText: titleError ? 'Please enter a title' : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Driven Mileage(KM): ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Add Mileage (KM)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedMileage = int.tryParse(value) ?? 0;
                      mileageError = selectedMileage == 0;
                    });
                  },
                ),
              ),
              if (mileageError)
                const Text(
                  'Please enter a valid mileage',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              const Text(
                'Price (PKR): ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Add Price (PKR)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      price = int.tryParse(value) ?? 0;
                      priceError = price == 0;
                    });
                  },
                ),
              ),
              if (priceError)
                const Text(
                  'Please enter a valid price',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 20),
              const Text(
                'Description: ',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: 'Add Description',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      description = value;
                      descriptionError = description.isEmpty;
                    });
                  },
                ),
              ),
              if (descriptionError)
                const Text(
                  'Please enter a description',
                  style: TextStyle(color: Colors.red),
                ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for publishing the ad
                    _publishAd();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBottomNavigationBar()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent[200],
                  ),
                  child: const Text(
                    'Publish',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to publish the ad
  // Method to publish the ad
  void _publishAd() {
    // Validate data before publishing
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && _validateData()) {
      // Fetch user data from Firestore
      FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get()
          .then((userData) {
        if (userData.exists) {
          // Get user's data
          Map<String, dynamic> userDataMap =
              userData.data() as Map<String, dynamic>;
          String userName = userDataMap['username'];
          String userEmail = userDataMap['email'];
          String userPhoneNumber = userDataMap['phoneNumber'];

          // Add ad data to Firestore
          _adsCollection.add({
            'carModel': selectedCarModel,
            'description': description,
            'price': price,
            'carType': selectedCarType,
            'city': selectedCity,
            'mileage': selectedMileage,
            'title': title,
            'userId': user.uid, // Add user's UID
            'userName': userName, // Add user's name
            'userEmail': userEmail, // Add user's email
            'userPhoneNumber': userPhoneNumber, // Add user's phone number
            // Add more fields as needed
          }).then((value) {
            // Reset form after successful submission
            _resetForm();
            // Show success message or navigate to a new screen
            // You can add your desired behavior here
          }).catchError((error) {
            // Handle errors
            if (kDebugMode) {
              print('Failed to publish ad: $error');
            }
            // Show error message to the user
            // You can add your desired behavior here
          });
        } else {
          // User data not found
          if (kDebugMode) {
            print('User data not found');
          }
          // Handle the situation accordingly
        }
      }).catchError((error) {
        // Handle errors
        print('Failed to fetch user data: $error');
        // Show error message to the user
        // You can add your desired behavior here
      });
    }
  }

  // Method to validate form data
  bool _validateData() {
    setState(() {
      titleError = title.isEmpty;
      mileageError = selectedMileage == 0;
      priceError = price == 0;
      descriptionError = description.isEmpty;
    });
    return !titleError && !mileageError && !priceError && !descriptionError;
  }

  // Method to reset the form
  void _resetForm() {
    setState(() {
      selectedCarType = 'Sedan';
      selectedCarModel = '2024';
      selectedCity = 'Abbottabad';
      selectedMileage = 0;
      price = 0;
      description = '';
      title = '';
      titleError = false;
      mileageError = false;
      priceError = false;
      descriptionError = false;
    });
  }
}
