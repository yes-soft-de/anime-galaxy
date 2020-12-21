export interface EditEpisode {
    animeID: number;
    animeName: string;
    animePublishDate: { timestamp: number };
    baseURL: string;
    categoryName: string;
    categoryID: number;
    comments: Array<any>;
    createdAt: { timestamp: number };
    description: string;
    duration: { timestamp: number; };
    episodeNumber: number;
    image: string;
    imageURL: string;
    interactions: Object;
    publishDate: { timestamp: number };
    rating: number;
    seasonNumber: number;
}