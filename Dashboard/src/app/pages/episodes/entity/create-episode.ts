export interface CreateEpisode {
    id: number;
    animeID:number;
    categoyID: number;
    seasonNumber: number;
    episodeNumber: number;
    description: string;
    image:string;
    duration: string;
    publishDate: Date
}