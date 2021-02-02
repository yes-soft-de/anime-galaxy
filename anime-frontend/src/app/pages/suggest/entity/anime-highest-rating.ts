export interface AnimeHighestRating {
    id: number;
    animeMainImage: string;
    animeName: string;
    categoryID: number
    categoryName: string;
    categories?: { id: number; name: string;}[];
    suggest: boolean;
}