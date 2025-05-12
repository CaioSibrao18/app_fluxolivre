import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  static final List<Map<String, dynamic>> items = [
    {'title': 'Usuários', 'image': Icons.group},
    {'title': 'Relatório', 'image': Icons.assignment},
    {'title': 'Configurações', 'image': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Fluxo Livre - ADMIN'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              if (items[index]['title'] == 'Usuários') {
                Navigator.pushNamed(context, '/users');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Center(
                    child: Icon(
                      items[index]['image'],
                      size: 80,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      items[index]['title'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
