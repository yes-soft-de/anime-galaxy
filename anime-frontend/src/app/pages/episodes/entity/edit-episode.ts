export interface EditEpisode {
    animeID: number;
    animeName: string;
    animePublishDate: { timestamp: number };
    baseURL: string;
    categoryName?: string;
    categoryID?: number;
    categories?: { id: number; name: string;}[];
    comments: Array<any>;
    createdAt: { timestamp: number };
    description: string;
    duration: { timestamp: number; };
    episodeNumber: number;
    image: string;
    posterImage: string;
    imageURL: string;
    posterImageURL: string;
    interactions: Object;
    publishDate: { timestamp: number };
    rating: number;
    seasonNumber: number;
}