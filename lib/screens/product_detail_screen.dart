import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(children: [
            AspectRatio(aspectRatio: 16 / 10, child: ProductImage(path: p.image)),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.name, style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(p.shop, style: tt.titleMedium),
                const SizedBox(height: 12),
                Row(children: [
                  Text(rupiah(p.price),
                      style: tt.headlineSmall?.copyWith(color: cs.primary, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text(rupiah(p.originalPrice),
                      style: tt.bodyMedium?.copyWith(decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 8),
                  Chip(label: Text('Hemat ${p.discountPercent}%')),
                ]),
                const Divider(height: 32),
                InfoRow(icon: Icons.near_me, text: 'Jarak ${p.distance}'),
                InfoRow(icon: Icons.schedule, text: 'Pickup ${p.pickupTime}'),
                InfoRow(icon: Icons.inventory_2, text: 'Sisa stok ${p.stock}'),
                const Divider(height: 32),
                Text('Deskripsi', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(p.description),
              ]),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            IconButton.outlined(
              onPressed: _qty > 1 ? () => setState(() => _qty--) : null,
              icon: const Icon(Icons.remove),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('$_qty', style: tt.titleLarge),
            ),
            IconButton.outlined(
              onPressed: _qty < p.stock ? () => setState(() => _qty++) : null,
              icon: const Icon(Icons.add),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                label: 'Tambah • ${rupiah(p.price * _qty)}',
                icon: Icons.add_shopping_cart,
                onPressed: () {
                  CartModel.instance.add(p, _qty);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${p.name} ditambahkan ke keranjang')),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
