import { Component, OnInit, Output } from '@angular/core';
import { RegisterService } from '../../service/register.service';
import {AuthService} from '../../../admin-service/auth/auth.service';
import { ActivatedRoute, Router } from '@angular/router';
import { TokenService } from 'src/app/pages/admin-service/token/token.service';
import { SuperAdminService } from 'src/app/pages/admin-service/auth/super-admin.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html'
})
export class LoginComponent implements OnInit {
  @Output() isSuperAdmin: boolean;

  errors = [];
  error = null;
  public form = {
    username: null,
    password: null
  };
  process = false;

  constructor(
    private registerService: RegisterService,
    private tokenService: TokenService,
    private authService: AuthService,
    private supperAdminService: SuperAdminService,
    private router: Router,
    private route: ActivatedRoute
    ) { }

  ngOnInit(): void {
  }

  onSubmit() {
    this.process = true;
    // Form Code
    this.registerService.login(this.form).subscribe(
      response => this.handleResponse(response),
      error => this.handleError(error)
    );
  }

  handleResponse(response) {
    console.log('token response', response);
    this.process = false;
    this.tokenService.handle(this.form.username, response.token);
    this.authService.changeAuthStatus(true);
    this.router.navigate(['../'], {relativeTo: this.route});
  }

  handleError(error) {
    this.process = false;
    if (error.error.error) {
      this.error = error.error.error;
    } else if (error.error.message) {
      this.error = error.error.message;
    } else if (error.error.errors) {
      this.errors = error.error.errors;
    }
  }

}
