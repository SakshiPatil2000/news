import '../model/category_model.dart';

List<Category_Model> getCategories() {
  // new list
  List<Category_Model> categories = [];

  // Adding categories with the correct constructor parameters
  Category_Model category = Category_Model(
    imageUrl: 'https://images.unsplash.com/photo-1522869635100-9f4c5e86aa37?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80',
    categoryName: 'Entertainment',
  );
  categories.add(category);

  category = Category_Model(
    imageUrl: 'https://images.unsplash.com/39/lIZrwvbeRuuzqOoWJUEn_Photoaday_CSD%20(1%20of%201)-5.jpg?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
    categoryName: 'Business',
  );
  categories.add(category);

  category = Category_Model(
    imageUrl: 'https://images.unsplash.com/photo-1495563923587-bdc4282494d0?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
    categoryName: 'Sports',
  );
  categories.add(category);

  category = Category_Model(
    imageUrl: 'https://images.unsplash.com/photo-1495020689067-958852a7765e?ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
    categoryName: 'General',
  );
  categories.add(category);

  category = Category_Model(
    imageUrl: 'https://images.unsplash.com/photo-1494390248081-4e521a5940db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1595&q=80',
    categoryName: 'Health',
  );
  categories.add(category);

  category = Category_Model(
    imageUrl: 'https://images.unsplash.com/photo-1554475901-4538ddfbccc2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1504&q=80',
    categoryName: 'Science',
  );
  categories.add(category);

  return categories;
}
