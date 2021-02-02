import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';

import { AdminsRoutingModule } from './admins-routing.module';
import { ListAdminsComponent } from './components/list-admins/list-admins.component';
import { AddAdminsComponent } from './components/add-admins/add-admins.component';


@NgModule({
  declarations: [ListAdminsComponent, AddAdminsComponent],
  imports: [
    ThemeModule,
    AdminsRoutingModule
  ]
})
export class AdminsModule { }
