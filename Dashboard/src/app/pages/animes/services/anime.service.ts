import { HttpClient, HttpErrorResponse, HttpEventType, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { Anime } from '../entity/anime';
import { AnimeResponse } from '../entity/anime-response';
import { Animes } from '../entity/animes';
import { AnimesResponse } from '../entity/animes-response';
import { CreateAnime } from '../entity/create-anime';
import { Suggest } from '../entity/suggest';

@Injectable({
  providedIn: 'root'
})
export class AnimeService {

  constructor(private httpClient: HttpClient) { }

  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allAnimes(): Observable<AnimesResponse> {
    return this.httpClient.get<AnimesResponse>(
      AdminConfig.animeAPI
    ).pipe(catchError(AnimeService.errorHandler));
  }

  getAnime(id: number): Observable<AnimeResponse> {
    return this.httpClient.get<AnimeResponse>(
      `${AdminConfig.animeAPI}/${id}`
    ).pipe(catchError(AnimeService.errorHandler));
  }

  createAnime(anime: CreateAnime): Observable<CreateAnime> {
    return this.httpClient.post<CreateAnime>(
      AdminConfig.animeAPI, JSON.stringify(anime)
      ).pipe(catchError(AnimeService.errorHandler));
  }


  updateAnime(anime: CreateAnime): Observable<CreateAnime> {
    return this.httpClient.put<CreateAnime>(
      `${AdminConfig.animeAPI}`, JSON.stringify(anime)
      ).pipe(catchError(AnimeService.errorHandler));
  }


  deleteAnime(id: number): Observable<any> {
    return this.httpClient.delete<any>(
      `${AdminConfig.animeAPI}/${id}`
      ).pipe(catchError(AnimeService.errorHandler));
  }


  animeSuggest(animeID: number, isSuggest: boolean): Observable<Suggest> {
    const suggestValue = isSuggest === false ? 0 : 1;
    return this.httpClient.put<Suggest>(
      `${AdminConfig.animeAPI}/${suggestValue}`, 
      JSON.stringify({id: animeID})
      ).pipe(catchError(AnimeService.errorHandler));
  }


  // Admin Section - Upload Image
  public uploadImage(image: File): Observable<string> {
    const formData = new FormData();
    formData.append('image', image);
    return this.httpClient.post<string>(`${AdminConfig.generalUploadAPI}`, formData);
  }

  // public uploadImage(image: File) {
  //   const formData = new FormData();
  //   formData.append('image', image);
  //   return this.httpClient.post<any>(
  //     `${AdminConfig.generalUploadAPI}`, 
  //     formData,
  //     {
  //       reportProgress: true,
  //       observe: 'events'
  //     }).pipe(map((event) => {
    
  //       switch (event.type) {
    
  //         case HttpEventType.UploadProgress:
  //           const progress = Math.round(100 * event.loaded / event.total);
  //           console.log('progress', progress);
  //           return { status: 'progress', message: progress };
    
  //         case HttpEventType.Response:
  //           return event.body;
  //         default:
  //           return `Unhandled event: ${event.type}`;
  //       }
  //     }));
  // }

  
}
