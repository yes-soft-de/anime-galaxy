import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddAdminsComponent } from './components/add-admins/add-admins.component';
import { ListAdminsComponent } from './components/list-admins/list-admins.component';


const routes: Routes = [
  { path: '', component: ListAdminsComponent },
  { path: 'add', component: AddAdminsComponent },

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AdminsRoutingModule { }
