import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Change Username'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Change Username Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeUsernamePage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Change Email'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Change Email Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeEmailPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Change Password Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Account'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to Delete Account Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteAccountPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeUsernamePage extends StatelessWidget {
  const ChangeUsernamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Username'),
      ),
      body: Center(
        child: Text('Change Username Page'),
      ),
    );
  }
}

class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Email'),
      ),
      body: Center(
        child: Text('Change Email Page'),
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Center(
        child: Text('Change Password Page'),
      ),
    );
  }
}

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account'),
      ),
      body: Center(
        child: Text('Delete Account Page'),
      ),
    );
  }
}
