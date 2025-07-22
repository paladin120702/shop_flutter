import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/drawer_item.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/order_list.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My requests'),
        centerTitle: true,
      ),
      drawer: const DrawerItem(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: FutureBuilder(
          future: Provider.of<OrderList>(
            context,
            listen: false,
          ).loadOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Consumer<OrderList>(
                builder: (ctx, orders, child) => ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, i) => OrderWidget(order: orders.items[i]),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
