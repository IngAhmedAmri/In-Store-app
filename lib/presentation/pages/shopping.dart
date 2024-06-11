import 'package:flutter/material.dart';
import '../pages/home_instascreen.dart' as home;
import '../pages/message.dart' as message;
import '../pages/account.dart' as account;

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Liste fictive de produits
  List<Product> products = [
    Product('Pull', 'Description 1', 30.0, 'assets/Product1.png'),
    Product('Robe', 'Description 2', 65.0, 'assets/Product2.png'),
    Product('Product 3', 'Description 3', 25.0, 'assets/product3.jpg'),
    // Ajoutez d'autres produits selon vos besoins
  ];

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          // Replace Navigator.pop with navigation to the home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => home.HomeInstaScreen()),
          );
          break;
        case 1:
          // Current page, do nothing
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => message.MessagePage()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => account.AccountPage()),
          );
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes produits'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 produits par ligne
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio:
                    0.75, // Ratio largeur/hauteur de chaque produit
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Action lorsque le produit est cliqué
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(
                              products[index].image,
                              fit: BoxFit.cover,
                              height: 150, // Hauteur de l'image
                              width: double
                                  .infinity, // Prend toute la largeur de la carte
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  products[index].name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  products[index].description,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '\DT${products[index].price.toString()}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
                height:
                    80), // Ajout d'un espace en bas pour éviter le chevauchement du bas de la page
          ],
        ),
      ),
     bottomNavigationBar: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(
                0.0,
                50.0 * (1.0 - _animation.value),
                0.0), // Déplacer vers le haut et vers le bas
            child: AnimatedOpacity(
              opacity: _animation.value,
              duration: Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ), // Ajouter une bordure supérieure
                  ),
                ),
                child: BottomAppBar(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: _selectedIndex == 0
                              ? Icon(Icons.home)
                              : Icon(Icons.home_outlined),
                          onPressed: () {
                            _onItemTapped(0);
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: _selectedIndex == 1
                              ? Icon(Icons.shopping_bag)
                              : Icon(Icons.shopping_bag_outlined),
                          onPressed: () {
                            _onItemTapped(1);
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: _selectedIndex == 2
                              ? Icon(Icons.message)
                              : Icon(Icons.message_outlined),
                          onPressed: () {
                            _onItemTapped(2);
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: _selectedIndex == 3
                              ? Icon(Icons.account_circle)
                              : Icon(Icons.account_circle_outlined),
                          onPressed: () {
                            _onItemTapped(3);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
  final String image;

  Product(this.name, this.description, this.price, this.image);
}
