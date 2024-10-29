import 'package:flutter/material.dart';
import 'package:my_solonet_app/constants.dart';

class HomeProfile extends StatefulWidget {
  const HomeProfile({super.key});

  @override
  State<HomeProfile> createState() => _HomeProfileState();
}

class _HomeProfileState extends State<HomeProfile> {
  get crossAxisAlignment => null; // Timer untuk menggeser halaman

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kColorUtama,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        // Wrapping the body with ScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Info Card
            Card(
              elevation: 4,
              color: kColorUtama,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150'), // Placeholder image
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // User Information Card with Icons
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInfoRow(Icons.person, 'User ID: \n 123456'),
                    _buildInfoRow(
                        Icons.home, 'Alamat: \n Jl Mangga No 23 Solo'),
                    _buildInfoRow(Icons.phone, 'Telp / WA: \n 0856-4567-3894'),
                    _buildInfoRow(
                        Icons.network_wifi, 'Paket Internet: \n Up To 10 Mbps'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Settings Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('Edit Profile'),
                      trailing: Icon(
                        Icons.edit,
                        color: kColorUtama,
                      ),
                      onTap: () {
                        // Edit profile action
                      },
                    ),
                    ListTile(
                      title: Text('Change Password'),
                      trailing: Icon(
                        Icons.lock,
                        color: kColorUtama,
                      ),
                      onTap: () {
                        // Change password action
                      },
                    ),
                    ListTile(
                      title: Text('Logout'),
                      trailing: Icon(
                        Icons.logout,
                        color: kColorUtama,
                      ),
                      onTap: () {
                        // Logout action
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32), // Space before the version text

            // Version Number
            Text(
              'Version 1.0.0', // Replace with your version
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey, // Grey color for the version text
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build info rows with icons
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: kColorUtama), // Icon color
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
