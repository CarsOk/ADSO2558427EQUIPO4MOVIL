import 'package:carousel_slider/carousel_slider.dart';
import 'package:domitransp/feature/home/presentation/widget/category_icon_widget.dart';
import 'package:flutter/material.dart';
import '../../../../routes/routes.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _current = 0;

  List<String> imageList = [
    'https://via.placeholder.com/350x180',
    'https://via.placeholder.com/350x180',
    'https://via.placeholder.com/350x180',
    'https://via.placeholder.com/350x180',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imageList.map((item) => Container(
              child: Center(
                child: Image.network(
                  item,
                  fit: BoxFit.cover,
                  width: 1000,
                ),
              ),
            )).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageList.map((url) {
              int index = imageList.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }).toList(),
        )],
        );
  }
}



class CategoryButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  GestureDetector? gesture;
  Function()? onTap;

  CategoryButton({
    required this.color,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 48.0,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryIconWidget(icono: Icons.add, onTap: (){}, nombre: 'giros nacionales'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}