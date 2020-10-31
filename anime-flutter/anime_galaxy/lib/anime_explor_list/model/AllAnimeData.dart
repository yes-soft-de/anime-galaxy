import 'Interaction.dart';

class AllAnimeData {
    String categoryName;
    String comments;
    int id;
    Interaction interaction;
    String mainImage;
    String name;
    String rating;

    AllAnimeData({this.categoryName, this.comments, this.id, this.interaction, this.mainImage, this.name, this.rating});

    factory AllAnimeData.fromJson(Map<String, dynamic> json) {
        return AllAnimeData(
            categoryName: json['categoryName'], 
            comments: json['comments'], 
            id: json['id'], 
            interaction: json['interaction'] != null ? Interaction.fromJson(json['interaction']) : null, 
            mainImage: json['mainImage'], 
            name: json['name'], 
            rating: json['rating'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['categoryName'] = this.categoryName;
        data['comments'] = this.comments;
        data['id'] = this.id;
        data['mainImage'] = this.mainImage;
        data['name'] = this.name;
        data['rating'] = this.rating;
        if (this.interaction != null) {
            data['interaction'] = this.interaction.toJson();
        }
        return data;
    }
}