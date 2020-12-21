import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddEpisodesComponent } from './components/add-episodes/add-episodes.component';
import { EditEpisodesComponent } from './components/edit-episodes/edit-episodes.component';
import { ListComingSoonEpisodesComponent } from './components/list-coming-soon-episodes/list-coming-soon-episodes.component';
import { ListEpisodesComponent } from './components/list-episodes/list-episodes.component';
import { EpisodesComponent } from './episodes.component';


const routes: Routes = [
  {
    path: '',
    component: EpisodesComponent,
    children: [
      { path: '', component: ListEpisodesComponent },
      { path: 'add', component: AddEpisodesComponent },
      { path: 'edit/:id', component: EditEpisodesComponent },
      { path: 'episodesComingSoon', component: ListComingSoonEpisodesComponent },
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EpisodesRoutingModule { }
