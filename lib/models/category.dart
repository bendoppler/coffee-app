class Category {
  String id, createdTime, lastModifiedTime, title, description, image;

  Category(
    {this.id = '',
      this.createdTime = '',
      this.lastModifiedTime = '',
      this.title = '',
      this.description = '',
      this.image = ''});

  Category.fromJson(Map<String, dynamic> info)
    : this(
    id: info['categoryId'],
    createdTime: info['createdTime'],
    lastModifiedTime: info['lastModifiedTime'],
    title: info['title'],
    description: info['description'],
    image: info['image']);
}