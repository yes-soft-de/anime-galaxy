export interface CreateAnime {
    id: number;
    name: string;
    mainImage: string;
    description: string;
    trailerVideo: string;
    episodesCount: number;
    publishDate: Date;
    categoryID: number;
    ageGroup: string;
    generalRating: number;
    // suggest: boolean;
}