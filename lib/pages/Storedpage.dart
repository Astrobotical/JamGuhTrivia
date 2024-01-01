import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildProductCard('Catty', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBqI2XvFPqE2J005FDXI8RlC2elEbXRtik-KkGksYVOA&s', 1.99,context),
          _buildProductCard('Eagle Rick', 'https://cdn1.vectorstock.com/i/1000x1000/99/55/aggressive-eagle-or-hawk-logo-icon-silhouette-vector-47259955.jpg', 1.99,context),
          _buildProductCard('Slitherath ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlzHBvyKHNgURT4VxRbCXmaldzYp93UR644h9xcNkLiO5iTjHysq9Cz6WxJIg8roGOGks&usqp=CAU', 1.99,context),
          _buildProductCard('Bundle Pack', 'https://static.thenounproject.com/png/3424183-200.png', 9.99,context),
        ],
      ),
    );
  }

  Widget _buildProductCard(
      String name, String imagePath, double price, BuildContext context) {
    return Card(
      elevation: 3.0,
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(name),
        leading: Image.network(
          imagePath,
          width: 50.0,
          height: 50.0,
        ),
        trailing: ElevatedButton(
          onPressed: () {
            _purchaseProduct(context, name, price);
          },
          child: Text('Buy \$${price.toStringAsFixed(2)}'),
        ),
      ),
    );
  }

  void _purchaseProduct(
      BuildContext context, String productName, double price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Purchase Successful'),
          content: Text(
              'You have successfully purchased $productName for \$${price.toStringAsFixed(2)}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
