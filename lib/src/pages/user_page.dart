import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<dynamic> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      // Substitua pelo seu endpoint real
      final response = await http.get(Uri.parse('http://localhost:3000/users'));

      if (response.statusCode == 200) {
        setState(() {
          users = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Erro ao carregar usuários');
      }
    } catch (e) {
      print('Erro: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void editarUsuario(Map<String, dynamic> user) {
    // Aqui você pode navegar para uma tela de edição ou abrir um diálogo
    print('Editar: ${user['nome']}');
  }

  void excluirUsuario(int id) async {
    // Substitua pelo seu endpoint real
    final response = await http.delete(Uri.parse('http://localhost:3000/users/$id'));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário excluído com sucesso!')),
      );
      fetchUsers(); // Atualiza a lista
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir usuário')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['nome']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => editarUsuario(user),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => excluirUsuario(user['id']),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
