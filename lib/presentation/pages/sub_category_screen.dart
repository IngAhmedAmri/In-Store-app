import 'package:flutter/material.dart';
import 'category.dart';


class Product {
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}

class SubCategory {
  final String name;
  final List<Product> products;

  SubCategory({
    required this.name,
    required this.products,
  });
}

class SubCategoryScreen extends StatefulWidget {
  final Category category;

  SubCategoryScreen({required this.category});

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  bool _isCategoryVisible = false;

  @override
  void initState() {
    super.initState();
    // Définir un délai pour l'animation d'apparition
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isCategoryVisible = true;
      });
    });
  }

  final Map<String, List<SubCategory>> categorySubCategories = {
    "Electromenager": [
      SubCategory(
        name: 'Petit électroménager',
        products: [
          Product(
            name: 'Mixeur',
            price: 99.99,
            description: 'Description :  Optez pour ce Robot Galaxy Naturel SUPER MIXEUR 1.5L, votre meilleur allié dans la préparation de vos recettes! le mixeur puissant Blender Galaxy naturel, est  très facile à utiliser, et qui permettra d’agrandir votre répertoire de recettes notamment pour une alimentation plus saine avec des aliments frais.',
            imageUrl: '../../../assets/Mixeur.png',
          ),
          Product(
            name: 'Cafetière',
            price: 139.99,
            description: 'Description :  Pour les fans du Café, au bureau ou à la maison, profitez d’un moment de plaisir avec la Cafetière ! Sa grande capacité permet de préparer une quantité de 12 tasses de café. Ainsi, vous pouvez servir en même temps tout les invités, collègues, famille, etc. De plus, cette Cafetière à prix pas cher est simple à utiliser .',
            imageUrl: '../../../assets/Cafetiere.jpeg',
          ),
        ],
      ),
      SubCategory(
        name: 'Gros électroménager',
        products: [
          Product(
            name: 'Réfrigérateur',
            price: 1199.99,
            description: 'Description :  Réfrigérateur deux portes de 547 litres avec compresseur à onduleur Smart Inverter, Door Cooling+™ et LED tactile, ThinQ™ avec Wi-Fi - Platine argent',
            imageUrl: '../../../assets/Refrigerateur.png',
          ),
          Product(
            name: 'Lave-linge',
            price: 699.99,
            description: 'Description :  Nettoyez vos vêtements en profondeur et de manière hygiénique. En générant de la vapeur depuis la partie inférieure du tambour, ce programme hygiénique s\'assure que l\'ensemble du linge soit imprégné.',
            imageUrl: '../../../assets/Lave-linge.jpg',
          ),
        ],
      ),
    ],
    "Vetement": [
      SubCategory(
        name: 'Homme',
        products: [
          Product(
            name: 'Chemise',
            price: 39.99,
            description: 'Description de la chemise',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Pantalon',
            price: 59.99,
            description: 'Description du pantalon',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Femme',
        products: [
          Product(
            name: 'Robe',
            price: 49.99,
            description: 'Description de la robe',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Jupe',
            price: 39.99,
            description: 'Description de la jupe',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Enfant',
        products: [
          Product(
            name: 'T-shirt enfant',
            price: 19.99,
            description: 'Description du t-shirt enfant',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Pantalon enfant',
            price: 29.99,
            description: 'Description du pantalon enfant',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Bébé',
        products: [
          Product(
            name: 'Body bébé',
            price: 9.99,
            description: 'Description du body bébé',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Pyjama bébé',
            price: 14.99,
            description: 'Description du pyjama bébé',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    ],
    "Maison": [
      SubCategory(
        name: 'Décoration',
        products: [
          Product(
            name: 'Cadre photo',
            price: 19.99,
            description: 'Description du cadre photo',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Lampe de table',
            price: 29.99,
            description: 'Description de la lampe de table',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Meubles',
        products: [
          Product(
            name: 'Canapé',
            price: 499.99,
            description: 'Description du canapé',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Table à manger',
            price: 299.99,
            description: 'Description de la table à manger',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    ],
    "Mode Beauté & Santé": [
      SubCategory(
        name: 'Maquillage',
        products: [
          Product(
            name: 'Palette de fards à paupières',
            price: 24.99,
            description: 'Description de la palette de fards à paupières',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Rouge à lèvres',
            price: 14.99,
            description: 'Description du rouge à lèvres',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Soins du visage',
        products: [
          Product(
            name: 'Crème hydratante',
            price: 19.99,
            description: 'Description de la crème hydratante',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Masque facial',
            price: 9.99,
            description: 'Description du masque facial',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    ],
    "Informatique": [
      SubCategory(
        name: 'Ordinateurs portables',
        products: [
          Product(
            name: 'Laptop Dell',
            price: 799.99,
            description: 'Description du laptop Dell',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Laptop HP',
            price: 699.99,
            description: 'Description du laptop HP',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Accessoires informatiques',
        products: [
          Product(
            name: 'Souris sans fil',
            price: 29.99,
            description: 'Description de la souris sans fil',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Clavier mécanique',
            price: 49.99,
            description: 'Description du clavier mécanique',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    ],
    "Sports & Loisirs": [
      SubCategory(
        name: 'Fitness',
        products: [
          Product(
            name: 'Tapis de yoga',
            price: 19.99,
            description: 'Description du tapis de yoga',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Haltères',
            price: 29.99,
            description: 'Description des haltères',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Sports d\'équipe',
        products: [
          Product(
            name: 'Ballon de football',
            price: 14.99,
            description: 'Description du ballon de football',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Maillot de basketball',
            price: 24.99,
            description: 'Description du maillot de basketball',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    ],
    "Jeux & Jouets": [
      SubCategory(
        name: 'Jeux de société',
        products: [
          Product(
            name: 'Monopoly',
            price: 29.99,
            description: 'Description du Monopoly',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Uno',
            price: 9.99,
            description: 'Description du Uno',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
      SubCategory(
        name: 'Jouets pour enfants',
        products: [
          Product(
            name: 'Poupée',
            price: 19.99,
            description: 'Description de la poupée',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          Product(
            name: 'Voiture télécommandée',
            price: 39.99,
            description: 'Description de la voiture télécommandée',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    ],
    // Ajoutez les autres catégories et sous-catégories ici
  };

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: AnimatedOpacity(
            opacity: _isCategoryVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Text(
              widget.category.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background_image.jpg'), // Remplacez par votre propre image
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: categorySubCategories[widget.category.name]!.length,
          itemBuilder: (context, index) {
            final subCategory =
                categorySubCategories[widget.category.name]![index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(subCategory.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductListScreen(subCategory: subCategory),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final SubCategory subCategory;

  ProductListScreen({required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subCategory.name),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: subCategory.products.map((product) {
          return ProductCard(product: product);
        }).toList(),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                '\DT${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 14, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  void _showAddToCartPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double _price = 0.0;

        return AlertDialog(
          title: Text('Saisir votre prix de vente'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _price = double.tryParse(value) ?? 0.0;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Le produit a été ajouté avec succès'),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _showSampleRequestPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Demande d\'Échantillon'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showSampleRequestSuccessPopup(context, true);
                },
                child: Text('Échantillon Gratuit'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showPaymentModal(context);
                },
                child: Text('Échantillon Payant'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSampleRequestSuccessPopup(BuildContext context, bool isFree) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Demande d\'Échantillon'),
          content: Text(isFree
              ? 'Votre demande d\'échantillon gratuit est en cours de traitement.'
              : 'Votre demande d\'échantillon payant est en cours de traitement.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  void _showPaymentModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modalités de Paiement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Veuillez sélectionner le mode de paiement :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showSampleRequestSuccessPopup(context, false);
                },
                child: Text('En Espèces à la Livraison'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showCardPaymentModal(context);
                },
                child: Text('Par Carte Bancaire'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCardPaymentModal(BuildContext context) {
    String cardName = '';
    String cardNumber = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Paiement par Carte Bancaire'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom sur la Carte'),
                onChanged: (value) {
                  cardName = value;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(labelText: 'Numéro de Carte'),
                onChanged: (value) {
                  cardNumber = value;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _showSampleRequestSuccessPopup(context, false);
                },
                child: Text('Valider'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '\DT${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _showAddToCartPopup(context);
                    },
                    child: Text('Ajouter au Panier'),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      _showSampleRequestPopup(context);
                    },
                    child: Text('Demander un Échantillon'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
