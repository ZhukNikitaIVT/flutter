import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({super.key});

Future<void> launchGitHubProfile(BuildContext context) async {
    const url = 'https://github.com/KolosovaElena-Predan';
    try {
      if (!await launchUrl(Uri.parse(url))) {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ошибка загрузки. Повторите попытку позже.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    }
  }


  Widget InfoRowInterface(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('О разработчике'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Информация о разработчике:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            InfoRowInterface('Ф.И.:', 'Колосова Елена'),
            InfoRowInterface('Группа:', 'ВМК-22'),
            InfoRowInterface('email:', 'elena.kolosova.04@mail.ru'),
            ElevatedButton(
              onPressed: () => launchGitHubProfile(context),
              child: const Text('Перейти на гитхаб'),
            ),
          ],
        ),
      ),
    );
  }
}