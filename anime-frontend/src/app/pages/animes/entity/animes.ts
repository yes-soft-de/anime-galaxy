export interface Animes {
    id: number;
    name: string;
    mainImage: string;
    categoryName: string;
    rating: number;
    comments: number;
    // categoryID: number;
    categories?: { id: number; name: string;}[];
    interaction: {
        love: number;
        like: number;
        dislike: number;
    }
    createdAt: { timestamp: number };
    createdBy: string;
    imageURL: string;
    suggest: boolean;
    updatedAt: { timestamp: number };
    updatedBy: string;
}