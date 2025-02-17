import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import '../data/models/comment.dart';
import '../providers/comment_provider.dart';
import 'package:menu_digital/data/menu_digital_data.dart';
import 'package:menu_digital/screens/menuitem_details.dart';
import 'package:menu_digital/widgets/cardapio_item_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class CardapioScreen extends ConsumerStatefulWidget {
  const CardapioScreen({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  _CardapioScreenState createState() => _CardapioScreenState();
}

class _CardapioScreenState extends ConsumerState<CardapioScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final TextEditingController reviewController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;

  void _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  void _submitReview() async {
    if (reviewController.text.isEmpty) return;

    final commentNotifier = ref.read(commentProvider.notifier);
    final newComment = Comment(
      id: '',
      userName: user?.email ?? 'Anônimo',
      text: reviewController.text,
      imageUrl: imageFile?.path ?? '',
      date: DateTime.now(),
      idRestaurant: widget.restaurant.id,
    );

    await commentNotifier.addComment(newComment);
    reviewController.clear();
    setState(() {
      imageFile = null;
    });
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Tirar Foto"),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text("Escolher da Galeria"),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardapioItems(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: Image.asset(widget.restaurant.imageLogo).image,
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.restaurant.address,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(widget.restaurant.phoneNumber,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[800]),
                          Text(widget.restaurant.rating.toString(),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Pratos disponíveis:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: widget.restaurant.menuItems.length,
            itemBuilder: (ctx, index) => CardapioItemCard(
              cardapioItem: widget.restaurant.menuItems[index],
              selectedItemDetails: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      MenuItemDetails(item: widget.restaurant.menuItems[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection(BuildContext context) {
    final comments = ref.watch(commentProvider);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(comments[index].userName,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(comments[index].date.toString(),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    if (comments[index].imageUrl?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.file(File(comments[index].imageUrl!), height: 300, width: 300, fit: BoxFit.cover),
                      ),
                    Text(comments[index].text),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: reviewController,
                decoration: const InputDecoration(
                  labelText: 'Deixe seu comentário',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: _showImageSourceDialog,
                icon: const Icon(Icons.camera_alt),
                tooltip: 'Escolher imagem',
              ),
              if (imageFile != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.file(
                    File(imageFile!.path),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitReview,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(commentProvider.notifier).fetchComments(widget.restaurant.id));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.restaurant.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Cardápio'),
              Tab(text: 'Avaliações'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCardapioItems(context),
            _buildReviewSection(context),
          ],
        ),
      ),
    );
  }
}
