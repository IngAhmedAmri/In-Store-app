import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../pages/sub_category_screen.dart';
import '../pages/add_product_screen.dart';
import '../pages/shopping.dart' as shopping;
import '../pages/message.dart' as message;
import '../pages/account.dart' as account;
import 'category.dart';

class Brand {
  final String name;
  Brand({required this.name});
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

  final List<Brand> brands = [
    Brand(name: "Brand 1"),
    Brand(name: "Brand 2"),
    Brand(name: "Brand 3"),
  ];

  final List<Product> fakeProducts = [
    Product(
      name: "T-shirt homme",
      description: "T-shirt pour homme de couleur bleue",
      price: 19.99,
      brand: Brand(name: "Brand 1"),
    ),
    Product(
      name: "Robe femme",
      description: "Robe pour femme de couleur rouge",
      price: 29.99,
      brand: Brand(name: "Brand 2"),
    ),
    Product(
      name: "Aspirateur",
      description: "Aspirateur puissant pour nettoyer la maison",
      price: 149.99,
      brand: Brand(name: "Brand 3"),
    ),
    // Ajoutez plus de produits si nécessaire
  ];

  @override
  _HomeInstaScreenState createState() => _HomeInstaScreenState();
}


class _HomeInstaScreenState extends State<HomeInstaScreen>
    with SingleTickerProviderStateMixin {
  Color appBarColor = Colors.pink.shade200;
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Product> _filteredProducts = [];
  late FocusNode _searchFocusNode;
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isHomeSelected = false;
  bool _isShoppingSelected = false;
  bool _isMessageSelected = false;
  bool _isAccountSelected = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    _isHomeSelected = true;
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void showSubCategories(
      BuildContext context, int index, List<Category> categories) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubCategoryScreen(
          category: categories[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex == 0 && ModalRoute.of(context)?.canPop == false) {
      return SizedBox
          .shrink(); // Renvoyer un widget vide si les conditions sont remplies
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 170.0,
              color: appBarColor,
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                title: Padding(
                  padding: const EdgeInsets.only(
                      top: 35.0, left: 30), // Ajouter un padding supérieur
                  child: TextField(
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Rechercher un produit',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _updateSearch,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize:
                      Size.fromHeight(1.0), // Height of the bottom line
                  child: Container(
                    color: Colors.black, // Color of the bottom line
                    height: 1.0, // Height of the bottom line
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight, // Adjust position as needed
            left: 0,
            right: 280,
            child: Image.asset(
              'assets/Logo1.png', // Chemin vers votre image
              height: 60.0, // Ajustez la hauteur de l'image selon vos besoins
              fit: BoxFit.contain, // Ajustez le mode de remplissage de l'image
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: CategoryWidget(
                  categories: widget.categories,
                  onCategoryTap: (index) {
                    showSubCategories(context, index, widget.categories);
                  },
                ),
              ),


            ],
          ),
          
        ],
      ),



      // la barre de navigation en bas de mon ecran
      bottomNavigationBar: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 100),
            transform: Matrix4.translationValues(
                0.0, 50.0 * (1.0 - _animation.value), 0.0), // Move up and down
            child: AnimatedOpacity(
              opacity: _animation.value,
              duration: Duration(milliseconds: 100),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.black, width: 1.0), // Add top border
                  ),
                ),
                child: BottomAppBar(
                  child: Container(
                    height: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: _selectedIndex == 0
                              ? Icon(Icons.home)
                              : Icon(Icons.home_outlined),
                          onPressed: () {
                            _onItemTapped(0);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 1
                              ? Icon(Icons.shopping_bag)
                              : Icon(Icons.shopping_bag_outlined),
                          onPressed: () {
                            _onItemTapped(1);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 2
                              ? Icon(Icons.message)
                              : Icon(Icons.message_outlined),
                          onPressed: () {
                            _onItemTapped(2);
                          },
                        ),
                        IconButton(
                          icon: _selectedIndex == 3
                              ? Icon(Icons.account_circle)
                              : Icon(Icons.account_circle_outlined),
                          onPressed: () {
                            _onItemTapped(3);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addProduct(dynamic result) async {
    if (result != null && result is Product) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? storedProducts = prefs.getString('products');
      List<Product> productsList = storedProducts != null
          ? (json.decode(storedProducts) as List<dynamic>)
              .map((item) => Product.fromJson(item))
              .toList()
          : [];

      setState(() {
        productsList.add(result);
      });

      prefs.setString('products', json.encode(productsList));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _updateIconStates();
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeInstaScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => shopping.ShoppingPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => message.MessagePage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => account.AccountPage()),
        );
        break;
    }
  }

  void _updateSearch(String query) {
    setState(() {
      // Filtrer les produits en fonction du terme de recherche
      _filteredProducts = widget.fakeProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _updateIconStates() {
    _isHomeSelected = _selectedIndex == 0;
    _isShoppingSelected = _selectedIndex == 1;
    _isMessageSelected = _selectedIndex == 2;
    _isAccountSelected = _selectedIndex == 3;
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final Brand brand;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      brand: Brand(name: json['brand']['name']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'brand': {'name': brand.name},
      };
}
