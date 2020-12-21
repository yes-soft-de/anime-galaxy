export interface EpisodeComingSoon {
    animeName: string;
    seasonNumber: number;
    episodeNumber: number;
    description: string;
    image: string;
    duration: {
        timezone: {
            name: string;
            transitions: [
                {
                    ts: number;
                    time: number;
                    offset: number;
                    isdst: boolean;
                    abbr: string;
                }
            ];
            location: {
                country_code: string;
                latitude: number;
                longitude: number;
                comments: string;
            }
        }
        offset: number;
        timestamp: number;
    };
    publishDate: {
        timezone: {
            name: string;
            transitions: [
                {
                    ts: number;
                    time: number;
                    offset: number;
                    isdst: boolean;
                    abbr: string;
                }
            ];
            location: {
                country_code: string;
                latitude: number;
                longitude: number;
                comments: string;
            };
        };
        offset: number;
        timestamp: number
    };
    createdAt: {
        timezone: {
            name: string;
            transitions: [
                {
                    ts: number;
                    time: number;
                    offset: number;
                    isdst: boolean;
                    abbr: string
                }
            ];
            location: {
                country_code: string;
                latitude: number;
                longitude: number;
                comments: string;
            };
        };
        offset: number;
        timestamp: number;
    };
    categoryName: string;
}