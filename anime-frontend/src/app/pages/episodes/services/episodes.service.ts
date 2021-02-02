import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { CreateEpisode } from '../entity/create-episode';
import { CreateEpisodeResponse } from '../entity/create-episode-response';
import { EpisodeComingSoonResponse } from '../entity/episode-coming-soon-response';
import { EpisodeComingSoon } from '../entity/episode-coming-soone';

@Injectable({
  providedIn: 'root'
})
export class EpisodesService {

  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }

  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  
  allEpisodesComingSoon(): Observable<EpisodeComingSoonResponse> {
    return this.httpClient.get<EpisodeComingSoonResponse>(
      AdminConfig.episodeComingSoonAPI
    ).pipe(catchError(EpisodesService.errorHandler));
  }


  allAnimeEpisodes(animeID: number): Observable<any> {
    return this.httpClient.get(
      `${AdminConfig.animeEpisodesAPI}/${animeID}`
    ).pipe(catchError(EpisodesService.errorHandler));
  }

  allAnimeSeasonEpisodes(animeID: number, season: number): Observable<any> {
    return this.httpClient.get(
      `${AdminConfig.animeEpisodesAPI}/${animeID}/${season}`
    ).pipe(catchError(EpisodesService.errorHandler));
  }

  getEpisode(episodeID: number): Observable<any> {
    return this.httpClient.get<any>(
      `${AdminConfig.episodeAPI}/${episodeID}`
    ).pipe(catchError(EpisodesService.errorHandler));
  }

  createEpisode(episode: CreateEpisode): Observable<CreateEpisodeResponse> {
    return this.httpClient.post<CreateEpisodeResponse>(
      AdminConfig.episodeAPI, JSON.stringify(episode),
      this.tokenService.httpOptions()
      ).pipe(catchError(EpisodesService.errorHandler));
  }


  updateEpisode(episode: CreateEpisode): Observable<CreateEpisodeResponse> {
    return this.httpClient.put<CreateEpisodeResponse>(
      AdminConfig.episodeAPI, JSON.stringify(episode),
      this.tokenService.httpOptions()
      ).pipe(catchError(EpisodesService.errorHandler));
  }


  deleteEpisode(episodeID: number): Observable<any> {
    return this.httpClient.delete<any>(
      `${AdminConfig.episodeAPI}/${episodeID}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(EpisodesService.errorHandler));
  }

  // Admin Section - Upload Image
  public uploadImage(image: File): Observable<string> {
    const formData = new FormData();
    formData.append('image', image);
    return this.httpClient.post<string>(`${AdminConfig.generalUploadAPI}`, formData);
  }



}
