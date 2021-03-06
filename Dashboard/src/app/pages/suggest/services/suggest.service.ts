import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { Suggest } from '../entity/suggest';

@Injectable({
  providedIn: 'root'
})
export class SuggestService {

  constructor(private httpClient: HttpClient) { }

    // Handling the error
    private static errorHandler(error: HttpErrorResponse) {
      return throwError(error || 'Server Error');
    }
  

    allHightestRatedAnime(): Observable<any> {
      return this.httpClient.get(
        AdminConfig.getHighestRatedAnimeAPI
      ).pipe(catchError(SuggestService.errorHandler));
    }
  
    animeSuggest(animeID: number, isSuggest: boolean): Observable<Suggest> {
      const suggestValue = isSuggest === false ? 0 : 1;
      return this.httpClient.put<Suggest>(
        `${AdminConfig.animeAPI}/${suggestValue}`, 
        JSON.stringify({id: animeID})
        ).pipe(catchError(SuggestService.errorHandler));
    }

}
