import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { NotFoundComponent } from '../@theme/components';
import { AfterLoginService } from './admin-service/guard/after-login.service';
import { BeforeLoginService } from './admin-service/guard/before-login.service';
import { SuperAdminService } from './admin-service/guard/super-admin.service';


const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./dashboard/dashboard.module').then(m => m.DashboardModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'login',
    loadChildren: () => import('./register/register.module').then(m => m.RegisterModule),
    canActivate: [BeforeLoginService]
  },
  {
    path: 'admins',
    loadChildren: () => import('./admins/admins.module').then(m => m.AdminsModule),
    canActivate: [AfterLoginService, SuperAdminService]
  },
  {
    path: 'categories',
    loadChildren: () => import('./categories/categories.module').then(m => m.CategoriesModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'animes',
    loadChildren: () => import('./animes/animes.module').then(m => m.AnimesModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'episodes',
    loadChildren: () => import('./episodes/episodes.module').then(m => m.EpisodesModule),
    canActivate: [AfterLoginService]
  },
  {
    path: 'suggest',
    loadChildren: () => import('./suggest/suggest.module').then(m => m.SuggestModule),
    canActivate: [AfterLoginService]
  },
  { path: '**', component: NotFoundComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PagesRoutingModule { }
