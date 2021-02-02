import { Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AdminConfig } from '../../AdminConfig';
import { TokenService } from '../../admin-service/token/token.service';

@Injectable({
  providedIn: 'root'
})
export class AdminsService {

  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }

  private static errorHandle(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

  getAdmins(): Observable<any> {
    return this.httpClient.get(
      AdminConfig.adminsAPI,
      this.tokenService.httpOptions()
    ).pipe(catchError(AdminsService.errorHandle));
  }

  createAdmins(data): Observable<any> {
    return this.httpClient.post<any>(
      AdminConfig.createAdminsAPI,
      JSON.stringify(data),
      this.tokenService.httpOptions()
    ).pipe(catchError(AdminsService.errorHandle));
  }

  deleteAdmin(adminID: string): Observable<any> {
    return this.httpClient.delete(
      `${AdminConfig.deleteAdminsAPI}/${adminID}`,
      this.tokenService.httpOptions()
    ).pipe(catchError(AdminsService.errorHandle));
  }
  
  // Admin Section - Upload Image
  public uploadImage(image: File): Observable<string> {
    const formData = new FormData();
    formData.append('image', image);
    return this.httpClient.post<string>(`${AdminConfig.generalUploadAPI}`, formData);
  }

}
