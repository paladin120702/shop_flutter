import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/utils/app_routes.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome!'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Requests'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Exit'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
            },
          ),
        ],
      ),
    );
  }
}
