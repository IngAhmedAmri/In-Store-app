import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeInstaScreen(),
    );
  }
}

class HomeInstaScreen extends StatefulWidget {
  final List<Category> categories = [
    Category(name: "Electromenager", icon: Icons.kitchen, color: Colors.red),
    Category(name: "Vetement", icon: Icons.accessibility, color: Colors.blue),
    Category(name: "Maison", icon: Icons.home, color: Colors.green),
    Category(
        name: "Mode Beauté & Santé",
        icon: Icons.favorite,
        color: Colors.purple),
    Category(name: "Informatique", icon: Icons.computer, color: Colors.orange),
    Category(
        name: "Sports & Loisirs",
        icon: Icons.sports_soccer,
        color: Colors.teal),
    Category(name: "Jeux & Jouets", icon: Icons.toys, color: Colors.amber),
  ];

  @override
  _HomeInstaScreenState createState() => _HomeInstaScreenState();
}

class _HomeInstaScreenState extends State<HomeInstaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Listes Categories',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink, // Changer la couleur de fond de l'AppBar
        elevation: 0, // Supprimer l'ombre de l'AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Naviguer vers la page de paramètres du compte
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink.shade300,
              ),
              child: Text(
                'lllllll Categories',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            for (var category in widget.categories)
              ListTile(
                title: Text(category.name),
                onTap: () {
                  Navigator.pop(context); // Fermer le Drawer
                  // Naviguer vers l'écran de la catégorie sélectionnée
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryScreen(category: category),
                    ),
                  );
                },
                // Set background color for each ListTile
                tileColor: category.color,
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryScreen(category: widget.categories[index]),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    child: Text(
                      widget.categories[index].name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: widget.categories[index].color,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Bienvenue sur notre E-Commerce',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddProductScreen(categories: widget.categories),
            ),
          );
          _addProduct(result);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Product',
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Naviguer vers la page des préférences
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  // Naviguer vers la page des favoris
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addProduct(Map<String, dynamic> result) async {
    if (result != null) {
      Product newProduct = result['product'];
      Category selectedCategory = result['category'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> productsJson =
          prefs.getStringList(selectedCategory.name) ?? [];
      productsJson.add(jsonEncode(newProduct.toJson()));
      prefs.setStringList(selectedCategory.name, productsJson);

      setState(() {
        for (var category in widget.categories) {
          if (category.name == selectedCategory.name) {
            category.products.add(newProduct);
            break;
          }
        }
      });
    }
  }
}

class Category {
  final String name;
  final IconData icon;
  final Color color;
  final List<Product> products;

  Category(
      {required this.name,
      required this.icon,
      required this.color,
      this.products = const []});
}

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen({required this.category});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product> _products = [];

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  void _loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productsJson = prefs.getStringList(widget.category.name);
    if (productsJson != null) {
      setState(() {
        _products = productsJson
            .map((json) => Product.fromJson(jsonDecode(json)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_products[index].name),
            subtitle: Text(_products[index].description),
            trailing: Text("\$${_products[index].price.toStringAsFixed(2)}"),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final List<String> images;

  Product({
    required this.name,
    required this.description,
    required this.price,
    this.images = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'images': images,
    };
  }
}

class AddProductScreen extends StatefulWidget {
  final List<Category> categories;

  AddProductScreen({required this.categories});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  Category? selectedCategory;
  List<String> selectedImages = [];

  void _addImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImages.add(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: DropdownButton<Category>(
                  hint: Text('Select Category'),
                  value: selectedCategory,
                  onChanged: (Category? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: widget.categories
                      .map<DropdownMenuItem<Category>>((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addImage,
                child: Text('Add Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      selectedCategory != null) {
                    Product newProduct = Product(
                      name: nameController.text,
                      description: descriptionController.text,
                      price: double.parse(priceController.text),
                      images: selectedImages,
                    );
                    Navigator.pop(context,
                        {'product': newProduct, 'category': selectedCategory});
                  }
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
