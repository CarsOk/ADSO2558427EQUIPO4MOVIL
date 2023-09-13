import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Color(0xFF4E0096),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CategoryButton(
                  color: Color(0xFF4E0096),
                  icon: Icons.local_shipping,
                  title: 'Consultar Envío',
                ),
                CategoryButton(
                  color: Color(0xFF4E0096),
                  icon: Icons.contact_phone,
                  title: 'Contáctanos',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CategoryButton(
                  color: Color(0xFF4E0096),
                  icon: Icons.web,
                  title: 'Web View',
                ),
                CategoryButton(
                  color: Color(0xFF4E0096),
                  icon: Icons.help,
                  title: 'Ayuda',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;

  CategoryButton({
    required this.color,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Puedes navegar a otras pantallas aquí cuando tengas implementadas las rutas.
        // Navigator.push(context, MaterialPageRoute(builder: (context) => OtraPantalla()));
      },
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
          ],
        ),
      ),
    );
  }
}