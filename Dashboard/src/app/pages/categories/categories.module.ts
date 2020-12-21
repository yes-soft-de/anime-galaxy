import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CategoriesRoutingModule } from './categories-routing.module';
import { CategoriesComponent } from './categories.component';
import { ListCategoryComponent } from './components/list-category/list-category.component';
import { AddCategoryComponent } from './components/add-category/add-category.component';
import { EditCategoryComponent } from './components/edit-category/edit-category.component';
import { ThemeModule } from 'src/app/@theme/theme.module';
// import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
// import { ToastrModule } from 'ngx-toastr';



@NgModule({
  declarations: [CategoriesComponent, ListCategoryComponent, AddCategoryComponent, EditCategoryComponent],
  imports: [
    CommonModule,
    CategoriesRoutingModule,
    ThemeModule,
    // BrowserAnimationsModule, // required animations module
    // ToastrModule.for/Root(), // ToastrModule added

  ]
})
export class CategoriesModule { }
