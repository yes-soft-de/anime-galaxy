import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AddSeriesComponent } from './component/add-series/add-series.component';
import { AddEpisodeComponent } from './component/add-episode/add-episode.component';



@NgModule({
  declarations: [AddSeriesComponent, AddEpisodeComponent],
  imports: [
    CommonModule
  ]
})
export class SeriesModule { }
