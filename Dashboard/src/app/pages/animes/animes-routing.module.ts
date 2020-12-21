import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AnimesComponent } from './animes.component';
import { AddAnimeComponent } from './components/add-anime/add-anime.component';
import { EditAnimeComponent } from './components/edit-anime/edit-anime.component';
import { ListAnimeComponent } from './components/list-anime/list-anime.component';


const routes: Routes = [
  {
    path: '',
    component: AnimesComponent,
    children: [
      { path: '', component: ListAnimeComponent },
      { path: 'add', component: AddAnimeComponent },
      { path: 'edit/:id', component: EditAnimeComponent },
      
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AnimesRoutingModule { }
