import { Component, OnDestroy, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { ListCategory } from '../../entity/list-category';
import { ListCategoryResponse } from '../../entity/list-category-response';
import { CategoryService } from '../../services/category.service';

@Component({
  selector: 'app-list-category',
  templateUrl: './list-category.component.html',
  styleUrls: ['./list-category.component.scss']
})
export class ListCategoryComponent implements OnInit, OnDestroy {

  categories: ListCategory[];
  categoriesList: ListCategory[] = [];
  categoriesFilterList: ListCategory[] = [];         // We Create It Second For Filter
  isDeleted = false;
  config: any;                    // Config Variable For Pagination Configuration
  name: string;                   // name variable to store the input search value
  allCategoriesObservable: Subscription;

  constructor(private categoryService: CategoryService,    
              private toaster: ToastrService,
              private router: Router,
              private route: ActivatedRoute ) { }

  ngOnInit() {
    this.getCategories();
  }

  ngOnDestroy() {
    this.allCategoriesObservable.unsubscribe();
  }

  getCategories() {
    // Fetch All Category
    this.allCategoriesObservable = this.categoryService.allCategories().subscribe(
        (data: ListCategoryResponse) => {
          if (data) {
            console.log('all Categories :', data);
            this.categories = data.Data;
            this.categoriesList = data.Data;
          }
        }, error1 => this.handleError(error1),
        () => {
          this.categoriesFilterList = this.categoriesList;
        });

    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.categoriesList.length
    };
  }


  // Handle Response Error
  handleError(error) {
    this.categories = [];
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  // Delete The Category
  delete(categoryId: number) {
    if (confirm('Are You Sure You Want To Delete This Category')) {
      this.isDeleted = true;
      this.categoryService.deleteCategory(categoryId).subscribe(
        data => {
          this.toaster.success('Category Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
          this.getCategories();
        }
      );
    } else {
      return false;
    }
  }


  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.categoriesFilterList = [...this.categoriesList];
    } else {
      this.categoriesFilterList = [];
      this.categoriesFilterList = this.categoriesList.filter(res => {
        // Search In Name Column
        const nameResult = res.name.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In Residence Column
        // const residenceResult = res.residence.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        if (nameResult) {
          // display the Name Column
          return nameResult;
        // } else if (residenceResult) {
          // display the Residence Column
          // return residenceResult;
        }
      });
    }
  }


}
