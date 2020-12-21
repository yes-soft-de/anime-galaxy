import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';
import { EpisodesRoutingModule } from './episodes-routing.module';

import { EpisodesComponent } from './episodes.component';
import { ListEpisodesComponent } from './components/list-episodes/list-episodes.component';
import { AddEpisodesComponent } from './components/add-episodes/add-episodes.component';
import { EditEpisodesComponent } from './components/edit-episodes/edit-episodes.component';
import { SeasonEpisodesComponent } from './components/list-episodes/season-episodes/season-episodes.component';
import { AnimeEpisodesComponent } from './components/list-episodes/anime-episodes/anime-episodes.component';
import { ListComingSoonEpisodesComponent } from './components/list-coming-soon-episodes/list-coming-soon-episodes.component';


@NgModule({
  declarations: [
    EpisodesComponent, 
    ListEpisodesComponent, 
    AddEpisodesComponent, 
    EditEpisodesComponent, 
    AnimeEpisodesComponent, 
    SeasonEpisodesComponent, 
    ListComingSoonEpisodesComponent
  ],
  imports: [
    ThemeModule,
    EpisodesRoutingModule
  ]
})
export class EpisodesModule { }
