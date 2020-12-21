import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AnimesRoutingModule } from './animes-routing.module';
import { ListAnimeComponent } from './components/list-anime/list-anime.component';
import { AddAnimeComponent } from './components/add-anime/add-anime.component';
import { EditAnimeComponent } from './components/edit-anime/edit-anime.component';
import { AnimesComponent } from './animes.component';
import { ThemeModule } from 'src/app/@theme/theme.module';


@NgModule({
  declarations: [ListAnimeComponent, AddAnimeComponent, EditAnimeComponent, AnimesComponent],
  imports: [
    CommonModule,
    AnimesRoutingModule,
    ThemeModule
  ]
})
export class AnimesModule { }
