export interface Anime {
    id?: number;
    name?: string;
    mainImage?: string;
    images?: Array<string>;
    imageURL: string;
    categoryName?: string;
    rating?: null;
    comments?: Array<any>;
    categoryID?: number;
    ageGroup: string;
    generalRating: number;
    interactions?: {
        love?: number;
        like?: number;
        dislike?: number;
        isLoved?: boolean
    };
    description?: string;
    episodesCount?: number;
    trailerVideo?: string;
    publishDate?: {
        timezone?: {
            name?: string;
            transitions?: [
                {
                    ts?: number;
                    time?: number;
                    offset?: number;
                    isdst?: boolean;
                    abbr?: string
                }
            ];
            location?: {
                country_code?: string;
                latitude?: number;
                longitude?: number;
                comments?: string;
            }
        };
        offset?: number;
        timestamp?: number;
    }
}