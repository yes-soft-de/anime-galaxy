import { HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { HelperService } from 'src/app/@theme/helper/helper.service';
import { AdminConfig } from '../../AdminConfig';
import { AdminRole } from '../../register/entity/admin-roles';
import { SuperAdminService } from '../auth/super-admin.service';

@Injectable({
  providedIn: 'root'
})
export class TokenService {
  // expireTime = HelperService.timeToMillisecond("02:00:00");
  userName: string;
  private iss = {
    //login: AdminConfig.loginAPI,
    username: ''
  };
  private roles: string[];

  constructor(private supperAdminService: SuperAdminService) { 
    console.log('Expire Time To Delete Your Token is : ', HelperService.convertSecondsToHMS(7200));
  }

  handle(username, token) {
    this.iss.username = username;
    // this.setToken(token);
    const expire_time_millseconds = 7200 * 1000;
    this.setTokenWithExpiry("token", token, expire_time_millseconds);
  }

    // Delete The Token From The Cookie
  deleteToken() {
    localStorage.removeItem('token');
  }

  isValid() {
    const token = this.getTokenWithExpiry('token');
    if (token) {
      const payload = this.payload(token);
      this.supperAdminService.chnageAdminState(this.isSuperAdmin());    
      return (Object.values(this.iss).indexOf(payload.username) > -1 || token != '') ? true : false;
    }
    return false;
  }

  payload(token) {
    const payload = token.split('.')[1];
    return this.decode(payload);
  }

  // decode the token to fetch the data from it
  decode(payload) {
    const payloadJson = JSON.parse(atob(payload));
    this.roles = payloadJson.roles; 
    this.userName = payloadJson.username;
    // console.log(payloadJson);
    return payloadJson;
  }

  // Check If The User Is Super Admin
  isSuperAdmin() {
    return (this.roles?.indexOf(AdminRole.SUPER_ADMIN_ROLE) > -1) ? true : false; 
  }

  loggedIn() {
    return this.isValid();
  }

  setTokenWithExpiry(key, value, ttl) {
    const now = new Date()
    // `item` is an object which contains the original value
    // as well as the time when it's supposed to expire
    const item = {
      value: value,
      expiry: now.getTime() + ttl,
    }
    localStorage.setItem(key, JSON.stringify(item))
  }


  getTokenWithExpiry(key) {
    const itemStr = localStorage.getItem(key)
    // if the item doesn't exist, return null

    if (!itemStr) {
      return null
    }
    const item = JSON.parse(itemStr)
    const now = new Date()
    // compare the expiry time of the item with the current time
    if (now.getTime() > item.expiry) {
      // If the item is expired, delete the item from storage
      // and return null
      localStorage.removeItem(key)
      return null
    }
    return item.value
  }

  httpOptions() {
    const token = this.getTokenWithExpiry('token');
    if (token) {
      return {
        headers: new HttpHeaders({
          'Content-Type': 'application/json',
          Authorization: `Bearer ` + token
       })
      }
    }    
  }

}
