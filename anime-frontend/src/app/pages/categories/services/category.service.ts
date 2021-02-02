import { HttpClient, HttpErrorResponse, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import {catchError} from 'rxjs/operators';
import { TokenService } from '../../admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { CategoryResponse } from '../entity/category-response';
import { ListCategory } from '../entity/list-category';
import { ListCategoryResponse } from '../entity/list-category-response';


@Injectable({
  providedIn: 'root'
})
export class CategoryService {
  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }


  // Handling the error
  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  allCategories(): Observable<ListCategoryResponse> {    
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
      AdminConfig.categoryAPI, JSON.stringify(category),
      this.tokenService.httpOptions()
      ).pipe(catchError(CategoryService.errorHandler));
  }


  updateCategory(category: ListCategory): Observable<ListCategory> {
    return this.httpClient.put<ListCategory>(
      AdminConfig.categoryAPI, JSON.stringify(category),
      this.tokenService.httpOptions()
      ).pipe(catchError(CategoryService.errorHandler));
  }


  deleteCategory(id: number): Observable<any> {    
    return this.httpClient.delete<any>(
      `${AdminConfig.categoryAPI}/${id}`,
      this.tokenService.httpOptions()
      ).pipe(catchError(CategoryService.errorHandler));
  }

  // Admin Section - Upload Image For Category
  public uploadImage(image: File): Observable<string> {
    const formData = new FormData();
    formData.append('image', image);
    return this.httpClient.post<string>(`${AdminConfig.generalUploadAPI}`, formData);
  }
}
