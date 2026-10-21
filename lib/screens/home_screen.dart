import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categories = ['Semua', 'Bakery', 'Resto', 'Cafe'];
  String _category = 'Semua';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final list = _category == 'Semua'
        ? dummyProducts
        : dummyProducts.where((p) => p.category == _category).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.location_on, color: cs.primary),
                  const SizedBox(width: 4),
                  Text('Medan, Sumatera Utara', style: tt.titleSmall),
                ]),
                const SizedBox(height: 12),
                Text('Selamatkan makanan,\nhemat pengeluaran',
                    style: tt.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                const SearchBar(hintText: 'Cari roti, nasi, kopi...', leading: Icon(Icons.search)),
                const SizedBox(height: 16),
                // Banner dampak
                Card(
                  color: cs.primaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(children: [
                      Icon(Icons.eco, size: 40, color: cs.onPrimaryContainer),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text('Setiap pesanan membantu mengurangi food waste (SDG 12).',
                            style: tt.bodyMedium?.copyWith(color: cs.onPrimaryContainer)),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: _categories
                      .map((c) => ChoiceChip(
                            label: Text(c),
                            selected: _category == c,
                            onSelected: (_) => setState(() => _category = c),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text('Tersedia di dekat kamu', style: tt.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ]),
            ),
          ),
          // Grid responsif: jumlah kolom menyesuaikan lebar layar
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.74,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => ProductCard(
                  product: list[i],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProductDetailScreen(product: list[i])),
                  ),
                ),
                childCount: list.length,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
