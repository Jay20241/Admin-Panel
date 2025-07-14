import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:multiwebpanel/views/side_bar/buyers.dart';
import 'package:multiwebpanel/views/side_bar/category.dart';
import 'package:multiwebpanel/views/side_bar/orders.dart';
import 'package:multiwebpanel/views/side_bar/products.dart';
import 'package:multiwebpanel/views/side_bar/subcategory_screen.dart';
import 'package:multiwebpanel/views/side_bar/upload_banner.dart';
import 'package:multiwebpanel/views/side_bar/vendors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Widget _selectedScreen = VendorsScreen();

  screenSelector(item){
    switch(item.route){
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
        break;
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = OrdersScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = CategoryScreen();
        });
        break;
      case SubcategoryScreen.id:
        setState(() {
          _selectedScreen = SubcategoryScreen();
        });
        break;
      case UploadBanner.id:
        setState(() {
          _selectedScreen = UploadBanner();
        });
        break;
      case ProductsScreen.id:
        setState(() {
          _selectedScreen = ProductsScreen();
        });
        break;
      default:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 18, 110, 185),
        title: Text('Multi-store Admin Panel', style: TextStyle(color: Colors.white),),
      ),
      
      body: _selectedScreen,
      sideBar: SideBar(
        header: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 18, 110, 185),
          ),
          child: Center(child: Text('EasyGrow', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.7),)),
        ),
        items: [
          AdminMenuItem(title: "Vendors", route: VendorsScreen.id, icon: CupertinoIcons.person_3),
          AdminMenuItem(title: "Buyers", route: BuyersScreen.id, icon: CupertinoIcons.person),
          AdminMenuItem(title: "Orders", route: OrdersScreen.id, icon: CupertinoIcons.shopping_cart),
          AdminMenuItem(title: "Categories", route: CategoryScreen.id, icon: Icons.category),
          AdminMenuItem(title: "Sub Categories", route: SubcategoryScreen.id, icon: Icons.subdirectory_arrow_right_sharp),
          AdminMenuItem(title: "Upload Banners", route: UploadBanner.id, icon: CupertinoIcons.rectangle_3_offgrid),
          AdminMenuItem(title: "Products", route: ProductsScreen.id, icon: Icons.store),
        ], 
        selectedRoute: VendorsScreen.id,
        onSelected: (item){
          screenSelector(item);
        },
        
        ),
      
      );
  }
}