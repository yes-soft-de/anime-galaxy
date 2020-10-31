class Interaction {
    String dislike;
    String like;
    String love;

    Interaction({this.dislike, this.like, this.love});

    factory Interaction.fromJson(Map<String, dynamic> json) {
        return Interaction(
            dislike: json['dislike'], 
            like: json['like'], 
            love: json['love'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['dislike'] = this.dislike;
        data['like'] = this.like;
        data['love'] = this.love;
        return data;
    }
}