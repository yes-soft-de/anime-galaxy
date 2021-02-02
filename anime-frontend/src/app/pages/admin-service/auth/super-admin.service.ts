import { Injectable } from '@angular/core';
import { BehaviorSubject, Subject } from 'rxjs';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class SuperAdminService {
  private isSuperAdmin = new Subject<boolean>();
  adminState = this.isSuperAdmin.asObservable();

  constructor() { }

  chnageAdminState(value: boolean) {
    this.isSuperAdmin.next(value);
  }


}
