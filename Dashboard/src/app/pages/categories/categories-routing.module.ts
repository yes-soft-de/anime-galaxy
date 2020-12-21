import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddCategoryComponent } from './components/add-category/add-category.component';
import { CategoriesComponent } from './categories.component';
import { ListCategoryComponent } from './components/list-category/list-category.component';
import { EditCategoryComponent } from './components/edit-category/edit-category.component';


const routes: Routes = [
  {
    path: '',
    component: CategoriesComponent,
    children: [
      { path: '', component: ListCategoryComponent },
      { path: 'add', component: AddCategoryComponent },
      { path: 'edit/:id', component: EditCategoryComponent },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class CategoriesRoutingModule { }
