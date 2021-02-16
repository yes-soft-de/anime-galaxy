import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { EditSuggestComponent } from './components/edit-suggest/edit-suggest.component';
import { HightestRatedAnimeComponent } from './components/hightest-rated-anime/hightest-rated-anime.component';
import { SuggestComponent } from './suggest.component';


const routes: Routes = [
  {
    path: '',
    component: SuggestComponent,
    children: [
      { path: '', component: HightestRatedAnimeComponent },
      { path: 'edit/:id', component: EditSuggestComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class SuggestRoutingModule { }
