// screens/community_forum_screen.dart
import 'package:flutter/material.dart';

class CommunityForumScreen extends StatelessWidget {
  const CommunityForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Forum')),
      body: ListView(
        children: const [
          ListTile(
            title: Text('User 1'),
            subtitle: Text('How to start investing in mutual funds?'),
          ),
          ListTile(
            title: Text('User 2'),
            subtitle: Text('What is a balanced fund?'),
          ),
          ListTile(
            title: Text('User 3'),
            subtitle: Text('Any suggestions for short-term investments?'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to post a new question
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
