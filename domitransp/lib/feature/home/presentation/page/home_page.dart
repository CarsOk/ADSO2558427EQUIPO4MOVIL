import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyCarousel(),
    );
  }
}

class MyCarousel extends StatelessWidget {
  final List<String> imageUrls = [
    "https://example.com/image1.jpg",
    "https://example.com/image2.jpg",
    // Add more image URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Carousel'),
      ),
      body: CarouselSlider.builder(
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return ImageCarouselItem(url: imageUrls[index]);
        },
        options: CarouselOptions(
          aspectRatio: 16/9,
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}

class ImageCarouselItem extends StatelessWidget {
  final String url;

  ImageCarouselItem({required this.url});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // La imagen se ha cargado correctamente
          return Image.network(url);
        } else if (snapshot.hasError) {
          // Se produjo un error al cargar la imagen
          return Center(
            child: Text('Error al cargar la imagen'),
          );
        } else {
          // Mientras la imagen se está cargando, puedes mostrar un indicador de carga
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> loadImage() async {
    try {
      // Intenta cargar la imagen desde la URL
      await NetworkImage(url).resolve(ImageConfiguration.empty);
    } catch (e) {
      // Captura la excepción y maneja el error
      print('Error al cargar la imagen desde la URL: $url');
      // Puedes personalizar esta parte según tus necesidades, como mostrar un marcador de posición o cargar una imagen predeterminada.
    }
  }
}
