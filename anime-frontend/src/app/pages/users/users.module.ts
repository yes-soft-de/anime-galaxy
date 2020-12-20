import { NgModule } from '@angular/core';

import { UsersRoutingModule } from './users-routing.module';
import { ListUserComponent } from './list-user/list-user.component';
import { AddUserComponent } from './add-user/add-user.component';
import { EditUserComponent } from './edit-user/edit-user.component';
import { UsersComponent } from './users.component';
import { ThemeModule } from 'src/app/@theme/theme.module';


@NgModule({
  declarations: [ListUserComponent, AddUserComponent, EditUserComponent, UsersComponent],
  imports: [
    UsersRoutingModule,
    ThemeModule
  ]
})
export class UsersModule { }
