import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import {catchError} from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { CategoryResponse } from '../entity/category-response';
import { ListCategory } from '../entity/list-category';
import { ListCategoryResponse } from '../entity/list-category-response';


@Injectable({
  providedIn: 'root'
})
export class CategoryService {
  myToken: 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpYXQiOjE2MDY1NzI5MDgsImV4cCI6MTYwNjU3NjUwOCwicm9sZXMiOlsidXNlciIsIlJPTEVfVVNFUiJdLCJ1c2VybmFtZSI6InRhbGFsIn0.bAUsJpeehZYcr2JK8RSOMBIA6JSWAPHTtrf12DuTnassYqVPiOfqlNb7sCnJ5tTuJtKSju4s340wtNFtEXEb-z7ZgdMeVa2PjO_NNwxUHSRJ2FHgxgZlxrt-5sGPf06sJeiA_nQbjIk4WS654XDLRhNVy57aTip2FY0NHgC-rk0NZwty5kIa-LRZ8-V4pHLWd1pNe_TCbR_MpbTiT5LbbTI108Je845MzF_SAsAnDHjm1UJfJ-J4id8TCTJnmlBjQAZ-8HFUWVr1zyVmocc3vO5c1HPrOM3_vb1xRdXm1n3Aj8SWS2OiwmAxc-_1EowcmWCPxrOE0Fq5kiHMJL0YNi8tCF998SM_ESgoDzwo6nnEDi0qPrwVr1Bfzz-vVe2oz-x3vQhFLflqmzi9tipdgrQUTJ6jO7uvdg3c5LPptZ9clDiwk3fauPpVTd9o-tIq7VGZO9Rxk4akOOuNuNt8G_8miFJfyuCOskJ7AsMBJSfxPvBjQZWh2eU-ecgwgWXCJQSeAl_iJY2VDuf6_1huZiivm_r34zvZAfrS5w4M5hrLEVmYONvuZHRyHKRdNGhaaKw64OqaWzAX06e5zOhw7PNsQ6wskFgwVb-lQWKftXvBn2zNSUxt1ZKd23a7QXFUDQNrmt06neQmTFHLzoPoU4BEJQZIj_qFXM9NzliDGc8';
  constructor(private httpClient: HttpClient) { }


  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allCategories(): Observable<ListCategoryResponse> {
    const httpOptions = {
      headers: new HttpHeaders({
       Authorization: `Bearer ${this.myToken}`
     })
   }
    return this.httpClient.get<ListCategoryResponse>(
      AdminConfig.categoryAPI
    ).pipe(catchError(CategoryService.errorHandler));
  }

  getCategory(categoryId: number): Observable<CategoryResponse> {
    return this.httpClient.get<CategoryResponse>(
      `${AdminConfig.categoryAPI}/${categoryId}`
    ).pipe(catchError(CategoryService.errorHandler));
  }

  createCategory(category: ListCategory): Observable<ListCategory> {
    return this.httpClient.post<ListCategory>(
      AdminConfig.categoryAPI, JSON.stringify(category)
      ).pipe(catchError(CategoryService.errorHandler));
  }


  updateCategory(category: ListCategory): Observable<ListCategory> {
    return this.httpClient.put<ListCategory>(
      AdminConfig.categoryAPI, JSON.stringify(category)
      ).pipe(catchError(CategoryService.errorHandler));
  }


  deleteCategory(id: number): Observable<any> {
    const httpOptions = {
      headers: new HttpHeaders({
        // 'Content-Type': 'application/json',
        Authorization: `Bearer ${this.myToken}`
     })
   }
    return this.httpClient.delete<any>(
      `${AdminConfig.categoryAPI}/${id}`
      ).pipe(catchError(CategoryService.errorHandler));
  }

  // Admin Section - Upload Image For Category
  public uploadImage(image: File): Observable<string> {
    const formData = new FormData();
    formData.append('image', image);
    return this.httpClient.post<string>(`${AdminConfig.generalUploadAPI}`, formData);
  }
}
