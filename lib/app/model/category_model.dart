class Category {

String icon;
String name;
String description;
  Category({
    required this.icon,
    required this.name,
    required this.description,
  });

}

enum CategoryType {
all('all', 'Todos'), 
electronics('electronics', 'Eletrônicos'), 
jewelery('jewelery', 'Jóias'), 
womensClothing("women's clothing", 'Roupas Femininas'), 
mensClothing("men's clothing", 'Roupas Masculinas'); 

  final String name;
  final String  description;
  const CategoryType(this.name, this.description);
} 