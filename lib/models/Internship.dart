class Internship{
  String uid ="";
  String companyName;
  String internshipTitle;
  String city;
  String country;
  String publishDay;
  String description;
  String responsibilities;
  String address;

  Internship(this.companyName,this.internshipTitle,this.city,this.country,this.publishDay,this.description,this.responsibilities,this.address);

  Internship.fromMap(Map<String,dynamic> m):
        this(
    m['companyName'], m['internshipTitle'],m['city'],m['country'],m['publishDay'],m['description'],m['responsibilities'],m['address']
  );

  Map<String,dynamic> toMap(){
    return {
      'companyName':companyName,
      'internshipTitle':internshipTitle,
      'city':city,
      'country':country,
      'publishDay':publishDay,
      'description':description,
      'responsibilities':responsibilities,
      'address':address
    };
  }
  void setId(String id){
    this.uid = id;
  }
}