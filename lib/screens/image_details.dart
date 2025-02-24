import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageDetails extends StatelessWidget {
  final ImageModel image;

  ImageDetails({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          image.tokenName,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo[900], // Darker indigo for contrast
        centerTitle: true,
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Row with two columns: Left column for details, Right column for QR code
            Row(
              children: [
                // Left Column (Details)
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.indigo[50]!, Colors.indigo[200]!], // Soft blue gradient
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(Icons.person, "Artist", image.artistName),
                          _buildInfoRow(Icons.numbers, "Token ID", image.tokenId.toString()),
                          _buildInfoRow(
                            image.soldFlag == "0" ? Icons.cancel : Icons.check_circle,
                            "Sold",
                            image.soldFlag == "0" ? "No" : "Yes",
                            color: image.soldFlag == "0" ? Colors.red : Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Right Column (QR Code)
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],  // Light blue background for QR section
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.2),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.qr_code, "QR Code URL", image.qrcodeUrl),
                        SizedBox(height: 10),
                        Center(
                          child: Image.network(
                            image.qrcodeUrl,  // Display the QR code
                            height: 150,  // Make the QR code visible with a fixed size
                            width: 150,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.indigo, size: 24),  // Bluish icon color
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.black54),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
