export interface Animes {
    id: number;
    name: string;
    mainImage: string;
    categoryName: string;
    rating: number;
    comments: number;
    categoryID: number;
    interaction: {
        love: number;
        like: number;
        dislike: number;
    }
}