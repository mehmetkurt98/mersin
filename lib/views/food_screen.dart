import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../models/restorant_model.dart';

class FoodScreen extends StatelessWidget {
  final List<Restaurant> restaurants = [
    Restaurant(
      name: "Next Republic Mersin",
      description: "Lezzetli yemekleri ile ünlü restoran.",
      rating: 4.5,
      image: "assets/images/restorants/image0.png",
    ),
    Restaurant(
      name: "Iskele",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image1.png",
    ),
    Restaurant(
      name: "Roof 14 By Divan",
      description: "",
      rating: 2.0,
      image: "assets/images/restorants/image2.png",
    ),
    Restaurant(
      name: "Maki Restoran",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image3.png",
    ),
    Restaurant(
      name: "Abidin Tantuni",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image4.png",
    ),
    Restaurant(
      name: "Ada ET Doner-Pozcu",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image5.png",
    ),
    Restaurant(
      name: "Borsa Tantuni",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image6.png",
    ),
    Restaurant(
      name: "Gattini Bistro Espresso",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image7.png",
    ),
    Restaurant(
      name: "Aşina Makam Restaurant",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image8.png",
    ),
    Restaurant(
      name: "Salih Usta Tantuni & Biftek",
      description: "Deniz ürünleri konusunda uzman restoran.",
      rating: 2.0,
      image: "assets/images/restorants/image9.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Restoranlar"),
        ),
        body: ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantCard(restaurant: restaurants[index]);
          },
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant? restaurant;

  RestaurantCard({this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            restaurant?.image ?? "assets/images/default_image.png",
            fit: BoxFit.cover,
            height: 200.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant?.name ?? "Restoran Adı Yok",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                RatingBar.builder(
                  initialRating: restaurant?.rating ?? 0.0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Rating güncellendiğinde yapılacak işlemler
                  },
                ),
                SizedBox(height: 8.0),
                Text(
                  restaurant?.description ?? "Açıklama Yok",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
