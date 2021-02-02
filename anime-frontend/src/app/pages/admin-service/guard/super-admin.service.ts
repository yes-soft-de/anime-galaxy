import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs';
import { TokenService } from '../token/token.service';

@Injectable({
  providedIn: 'root'
})
export class SuperAdminService implements CanActivate {

  constructor(private tokenService: TokenService,
    private router: Router,
    private toaster: ToastrService) { }

  canActivate(
    next: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
      let supperAdmin = this.tokenService.isSuperAdmin();
      if(supperAdmin){
        return supperAdmin ;
      } else {
        this.toaster.error('Sorry This Route For Super Admin Only');
        this.router.navigate(['/']);
        return;
      }
  }

}
