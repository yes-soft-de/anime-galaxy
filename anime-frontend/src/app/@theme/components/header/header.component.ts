import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from 'src/app/pages/admin-service/auth/auth.service';
import { SuperAdminService } from 'src/app/pages/admin-service/auth/super-admin.service';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent implements OnInit {
  loggedIn: boolean;
  isSupperAdmin: boolean;

  constructor(private tokenService: TokenService, 
              private supperAdminService: SuperAdminService,
              private authService: AuthService,
              private router: Router) { }

  ngOnInit(): void {
    this.authService.authState.subscribe(loggedIn => this.loggedIn = loggedIn);

    this.supperAdminService.adminState.subscribe(isSuperAdmin => {
      this.isSupperAdmin = isSuperAdmin;
      console.log('Admin State', this.isSupperAdmin);
    });
  }

  logout() {
    this.tokenService.deleteToken();
    this.authService.changeAuthStatus(false);
    this.supperAdminService.chnageAdminState(false);
    this.router.navigate(['/login']);
  }

}
