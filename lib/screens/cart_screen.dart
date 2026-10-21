import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';
import 'qr_pickup_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartModel.instance;
    final tt = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        final items = cart.items;
        return Scaffold(
          appBar: AppBar(title: const Text('Keranjang')),
          body: items.isEmpty
              ? Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.shopping_cart_outlined, size: 64, color: Theme.of(context).colorScheme.outline),
                    const SizedBox(height: 8),
                    Text('Keranjang masih kosong', style: tt.titleMedium),
                  ]),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final item = items[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(children: [
                          SizedBox(
                            width: 72,
                            height: 72,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ProductImage(path: item.product.image),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(item.product.name, style: tt.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                              Text(item.product.shop, style: tt.bodySmall),
                              Text('${item.qty} x ${rupiah(item.product.price)}'),
                            ]),
                          ),
                          IconButton(
                            onPressed: () => cart.remove(item),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
          bottomNavigationBar: items.isEmpty
              ? null
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('Total', style: tt.titleMedium),
                        Text(rupiah(cart.total), style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      ]),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                          label: 'Bayar & Buat QR Pickup',
                          icon: Icons.qr_code,
                          onPressed: () {
                            final code = 'SF-${DateTime.now().millisecondsSinceEpoch % 100000}';
                            final shops = items.map((e) => e.product.shop).toSet().join(', ');
                            final pickup = items.first.product.pickupTime;
                            final total = cart.total;
                            cart.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QrPickupScreen(orderCode: code, shop: shops, pickupTime: pickup, total: total),
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  ),
                ),
        );
      },
    );
  }
}
