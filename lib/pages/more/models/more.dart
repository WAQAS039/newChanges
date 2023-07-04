class More{
  String? _name;
  String? _image;
  String? get name => _name;
  String? get image => _image;

  More({required name,required image}){
    _name = name;
    _image = image;
  }
}