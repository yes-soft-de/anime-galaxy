export interface AnimeEpisodes {
    id: number;
    animeName: string;
    comments: number;
    createdAt: {
        timestamp: number;
    }
    description: string;
    duration: { timestamp: number; }
    episodInteraction: {
        love: number; 
        like: number; 
        dislike: number;
    }
    episodeNumber: number
    image: string;
    publishDate: { timestamp: number; }
    rating: number;
    seasonNumber: number;
}