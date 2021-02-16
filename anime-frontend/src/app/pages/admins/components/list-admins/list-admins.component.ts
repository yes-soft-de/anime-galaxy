import { typeWithParameters } from '@angular/compiler/src/render3/util';
import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import { Admin } from '../../entity/admin';
import { AdminResponse } from '../../entity/admin-response';
import { AdminsService } from '../../services/admins.service';

@Component({
  selector: 'app-list-admins',
  templateUrl: './list-admins.component.html',
  styleUrls: ['./list-admins.component.scss']
})
export class ListAdminsComponent implements OnInit {
  private destory$: Subject<void> = new Subject();
  admins: Admin[];
  adminsList: Admin[] = [];
  adminsFilterList: Admin[] = [];
  name: string;
  config: any;
  isDeleted = false;


  constructor(private adminService: AdminsService,
              private toaster: ToastrService) { }

  ngOnInit(): void {
    this.getAdmins();

    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.adminsList.length
    };
  }

  getAdmins() {
    this.adminService.getAdmins()
    .pipe(takeUntil(this.destory$))
    .subscribe(
      (response: AdminResponse) => {
        // console.log('All Admins: ', response);
        this.admins = response.Data;
        this.adminsList = response.Data;
      }, error => this.handleError(error),
      () => {
        this.adminsFilterList = this.adminsList;
      }
    );
  }


  
  // Handle Response Error
  handleError(error) {
    this.admins = [];
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

  pageChanged(event) {
    this.config.currentPage = event;
  }

  // Delete The Admin
  delete(adminID: string) {
    if (confirm('Are You Sure You Want To Delete This Admin')) {
      this.isDeleted = true;
      this.adminService.deleteAdmin(adminID).subscribe(
        data => {
          this.toaster.success('Admin Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getAdmins();
        }
      );
    } else {
      return false;
    }
  }

  
  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.adminsFilterList = [...this.adminsList];
    } else {
      this.adminsFilterList = [];
      this.adminsFilterList = this.adminsList.filter(res => {
        // Search In Name Column
        if (res.userName) {
          const userName = res.userName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (userName) {
            // display the Name Column
            return userName;
          }
        }
        if (res.location) {
          // Search In Residence Column
          const location = res.location.toLocaleLowerCase().match(this.name.toLocaleLowerCase());          
          if (location) {
            // display the Name Column
            return location;
          }
        }
        
      });
    }
  }

}
